------------------------------------------------------------------------------------------------
--
--  Brief description:  Functions and constants for NoC generation.
--
------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.HermesPackage.all;

package standards is

    --------------------------------------------------------------------------------
    -- Router position constants 
    --------------------------------------------------------------------------------
    constant BL: integer := 0;
    constant BC: integer := 1;
    constant BR: integer := 2;
    constant CL: integer := 3;
    constant CC: integer := 4;
    constant CRX: integer := 5; 
    constant TL: integer := 6;
    constant TC: integer := 7;
    constant TR: integer := 8;

    function RouterPosition(router, X_ROUTERS, Y_ROUTERS: integer) return integer;
    function RouterAddress(router, X_ROUTERS,Y_ROUTERS, STACKS,TIERS: integer)  return std_logic_vector; 

    type arrayNrot_regflit is array (natural range <>) of regflit;

end standards;

package body standards is 
        
        -- Returns the router position in the mesh
        -- BR: Botton Right
        -- BL: Botton Left
        -- TR: Top Right
        -- TL: Top Left 
        -- CRX: Center Right 
        -- CL: Center Left
        -- CC: Center
        -- 4x4 positions exemple
        --              TL TC TC TR
        --              CL CC CC CRX 
        --              CL CC CC CRX 
        --              BL BC BC BR
        function RouterPosition(router, X_ROUTERS, Y_ROUTERS: integer) return integer is
                variable pos: integer range 0 to TR;
                variable line, column: integer;
                variable RouterTier: integer;
                variable localRouter: integer;
                begin
                        
                   
                    localRouter := router mod (X_ROUTERS*Y_ROUTERS);
                    column := localRouter mod X_ROUTERS;
                        
                    if localRouter >= (X_ROUTERS*Y_ROUTERS)-X_ROUTERS then --TOP ---------
                            if column = X_ROUTERS-1 then    --RIGHT
                                    pos := TR;
                            elsif column = 0 then          --LEFT
                                    pos := TL;
                            else                           --CENTER_X
                                    pos := TC;
                            end if;
                        -- router < X_ROUTERS
                    elsif localRouter < X_ROUTERS then          --BOTTOM--------------
                            if column = X_ROUTERS-1 then   --RIGHT
                                    pos := BR;
                            elsif column = 0 then          --LEFT
                                    pos := BL;
                            else                           --CENTER_X
                                    pos := BC;
                            end if;
                    else                                  --CENTER_Y-----------
                            if column = X_ROUTERS-1 then  --RIGHT
                                    pos := CRX; 
                            elsif column = 0 then         --LEFT
                                    pos := CL;
                            else                          --CENTER_X
                                    pos := CC;
                            end if;
                    end if; 
                    --report "POS "  & integer'image(pos) & "  " & integer'image(router)  & "  " &  integer'image(X_ROUTERS) & "  " & integer'image(Y_ROUTERS);
                    return pos;
                        
        end RouterPosition;

	-- ALTERAR PARA USAR A PARTE ALTA DO ADDR PARA ARMAZENAR S E T
        function RouterAddress(router, X_ROUTERS,Y_ROUTERS,STACKS,TIERS: integer) return std_logic_vector is

                variable pos_x,pos_y,ls,lt  : regquartoflit; 
                variable addr               : regflit; 
                variable aux                : integer;
                variable localRouter        : integer;
                variable RouterTier         : integer;
        begin 

                localRouter := router mod (X_ROUTERS*Y_ROUTERS);
                RouterTier := router / (X_ROUTERS*Y_ROUTERS); -- 0 to n 

                aux := (localRouter/X_ROUTERS); 
                pos_x := conv_std_logic_vector((localRouter mod X_ROUTERS),QUARTOFLIT);
                pos_y := conv_std_logic_vector(aux,QUARTOFLIT); 
                ls := conv_std_logic_vector(STACKS,QUARTOFLIT);
                lt := conv_std_logic_vector(RouterTier,QUARTOFLIT);
                
                addr := ls & lt & pos_x & pos_y;

                return addr;

        end RouterAddress;
               
end standards;

	
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.HermesPackage.all;
use work.standards.all;
use IEEE.std_logic_arith.all;


--
-- THE EXTERNAL INTERFACE OF THE NOC ARE THE LOCAL PORTS OF ALL ROUTERS
--
entity NOC is
    generic(    X_ROUTERS: integer := 3;
    	        Y_ROUTERS: integer := 3;
                TIERS: integer := 3;
                STACKS: integer := 1
                );

	port(
                ------------------------------------ todos sinais devem ser da grandeza (NB_ROUTERS * TIERS -1)
		clock         : in  std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0);
		reset         : in  std_logic;

		clock_rxLocal : in  std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0);
		rxLocal       : in  std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0);
		data_inLocal  : in  arrayNrot_regflit( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0 );
		credit_oLocal : out std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0);

		clock_txLocal : out std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0);
		txLocal       : out std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0);
		data_outLocal : out arrayNrot_regflit( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0 );
		credit_iLocal : in  std_logic_vector( (X_ROUTERS*Y_ROUTERS*TIERS-1) downto 0));
	end NOC;

architecture NOC of NOC is

        ---------------------------------------------- todos sinais devem ser da grandeza (NB_ROUTERS * TIERS -1)
        constant NB_ROUTERS : integer :=  X_ROUTERS * Y_ROUTERS * TIERS;

    -- array e sinais para controle - 5 fios de controle por roteador N/S/W/E/L
	type control_array is array (NB_ROUTERS-1 downto 0) of std_logic_vector(4 downto 0);
	signal tx, rx, clock_rx, clock_tx, credit_i, credit_o : control_array;
 
    -- barramentos de dados - number of ports of the router - 5 - N/S/W/E/L
	type data_array is array (NB_ROUTERS-1 downto 0) of arrayNport_regflit;
	signal data_in, data_out : data_array;

	signal address_router : regmetadeflit;

	type router_position is array (NB_ROUTERS-1 downto 0) of integer range 0 to TR;

        signal NocHeader : std_logic_vector((TAM_FLIT-1) downto METADEFLIT);

        signal sX_ROUTERS : regNport  :=  conv_std_logic_vector(X_ROUTERS,NPORT);
        signal sY_ROUTERS : regNport :=   conv_std_logic_vector(Y_ROUTERS,NPORT);
                                         -- ls lt x y
        signal address_router1 : regflit := RouterAddress(0,X_ROUTERS,Y_ROUTERS,STACKS,TIERS);
        signal address_router2 : regflit := RouterAddress(8,X_ROUTERS,Y_ROUTERS,STACKS,TIERS);
        signal address_router3 : regflit := RouterAddress(17,X_ROUTERS,Y_ROUTERS,STACKS,TIERS);
        
        signal localRouterInt : integer := 17 mod (X_ROUTERS*Y_ROUTERS);
        signal localRouterInt2 : integer := 0 mod (X_ROUTERS*Y_ROUTERS);
        signal RouterTierInt : regflit := conv_std_logic_vector(TIERS,QUARTOFLIT) & conv_std_logic_vector(TIERS,QUARTOFLIT) & conv_std_logic_vector(TIERS,QUARTOFLIT) & conv_std_logic_vector(TIERS,QUARTOFLIT) ;

begin



        	--NocHeader <= conv_std_logic_vector(STACKS,QUARTOFLIT) & conv_std_logic_vector(TIER,QUARTOFLIT);
                -- NB_ROUTERS = 25
                -- NB_TIERS
                -- Pos(NB_TIERS,NB_ROUTERS)
        -- FOR GENERATE FOR EACH TIER

        noc: for i in 0 to NB_ROUTERS-1 generate

                router: entity work.RouterCC
                generic map( address =>  RouterAddress(i,X_ROUTERS,Y_ROUTERS,STACKS,TIERS))  -- CONCATENAR ENDEREÇO COM LT LS-- adicionar X_ROUTERS, Y_ROUTERS
                port map(
                        clock    => clock(i),
                        reset    => reset,
                        clock_rx => clock_rx(i),
                        rx       => rx(i),
                        x_routers => sX_ROUTERS,
                        y_routers => sY_ROUTERS,
                        data_in  => data_in(i),
                        credit_o => credit_o(i),
                        clock_tx => clock_tx(i),
                        tx       => tx(i),
                        data_out => data_out(i),
                        credit_i => credit_i(i));         
		
                ------------------------------------------------------------------------------
                --- LOCAL PORT CONNECTIONS ----------------------------------------------------
                ------------------------------------------------------------------------------
                clock_rx(i)(LOCAL)       <= clock_rxLocal(i);
                rx(i)(LOCAL)             <= rxLocal(i);
                data_in(i)(LOCAL)        <= data_inLocal(i);
                credit_oLocal(i)         <= credit_o(i)(LOCAL);     

                clock_txLocal(i)         <= clock_tx(i)(LOCAL);
                txLocal(i)               <= tx(i)(LOCAL) ; 
                data_outLocal(i)         <= data_out(i)(LOCAL);            
                credit_i(i)(LOCAL)       <= credit_iLocal(i);
                    
                
		-- IF ROUTERS ARE AT EDGE
		-- USE GROUNDED VIAS TO CONNECT UP AND DOWN CHANNELS
		
		-- ALTERAR IFS PARA CONTEMPLAR UP DOWN NOS ROUTERS DAS PONTAS
                -- TR (NORTH: UP   EAST: DOWN)
                -- BR (SOUTH: UP   EAST: DOWN)
                -- TL (NORTH: UP   WEST: DOWN)
                -- BL (SOUTH: UP   WEST: DOWN)

                -- ALTERADOS

                -- CONEXOES DOS ELEVADORES
                -- BR E TR
                --      EAST - DOWN
                -- BL E TL
                --      WEST - DOWN
                -- BR - BL
                --      SOUTH - UP
                -- TR or TL
                --      NORTH - UP

                -- 8 EAST - 17 NORTH
                -- i >= TIER-1 * XRT * YRT -- ULTIMO   
                -- i < XRT * YRT -- PRIMEIRO TIER


                -- ########################### TR/TL/BR ROUTER #####################
                -- ###########################################################
                -- FIRST TIER (ground DOWN vias)
                east_FirstTierGround: if (routerPosition(i,X_ROUTERS,Y_ROUTERS)=BR or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TR) and (i < X_ROUTERS*Y_ROUTERS) generate 
                        rx(i)(EAST)             <= '0';
                        clock_rx(i)(EAST)       <= '0';
                        credit_i(i)(EAST)       <= '0';
                        data_in(i)(EAST)        <= (others => '0');
                end generate;

                -- FIRST_TIER to (LAST_TIER-1) (Connect UP vias)
                north_UpConnection_1: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=TL and (i < (TIERS-1)*X_ROUTERS*Y_ROUTERS) generate -- NOT LAST TIER
                        rx(i)(NORTH)             <= tx(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        clock_rx(i)(NORTH)       <= clock_tx(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        credit_i(i)(NORTH)       <= credit_o(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        data_in(i)(NORTH)        <= data_out(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        end generate;  
                north_UpConnection_2: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=TR and (i < (TIERS-1)*X_ROUTERS*Y_ROUTERS) generate -- NOT LAST TIER
                        rx(i)(NORTH)             <= tx(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                        clock_rx(i)(NORTH)       <= clock_tx(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                        credit_i(i)(NORTH)       <= credit_o(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                        data_in(i)(NORTH)        <= data_out(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                end generate;

                --FIRST_TIER+1 TO LAST_TIER
                westDown_Connection_1: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=TL and (i >= X_ROUTERS*Y_ROUTERS) generate 
                        rx(i)(WEST)             <= tx(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                        clock_rx(i)(WEST)       <= clock_tx(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                        credit_i(i)(WEST)       <= credit_o(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                        data_in(i)(WEST)        <= data_out(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                end generate;
                eastDown_Connection_1: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=TR and (i >= X_ROUTERS*Y_ROUTERS) generate 
                        rx(i)(EAST)             <= tx(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                        clock_rx(i)(EAST)       <= clock_tx(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                        credit_i(i)(EAST)       <= credit_o(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                        data_in(i)(EAST)        <= data_out(i-(X_ROUTERS*Y_ROUTERS))(NORTH);
                end generate;    

              

                -- LAST TIER (ground UP vias)
                north_LastTierGrounding: if (routerPosition(i,X_ROUTERS,Y_ROUTERS)=TL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TR) and (i >= (TIERS-1)*X_ROUTERS*Y_ROUTERS) generate -- LAST TIER
                        rx(i)(NORTH)             <= '0';
                        clock_rx(i)(NORTH)       <= '0';
                        credit_i(i)(NORTH)       <= '0';
                        data_in(i)(NORTH)        <= (others => '0');
                end generate;


                -- ########################### BL/TL/BR ROUTER #####################
                -- ###########################################################
                -- FIRST TIER (ground DOWN vias)
                west_FirstTierGround: if (routerPosition(i,X_ROUTERS,Y_ROUTERS)=BL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TL) and (i < X_ROUTERS*Y_ROUTERS) generate 
                        rx(i)(WEST)             <= '0';
                        clock_rx(i)(WEST)       <= '0';
                        credit_i(i)(WEST)       <= '0';
                        data_in(i)(WEST)        <= (others => '0');
                end generate;

                -- FIRST_TIER to (LAST_TIER-1) (Connect UP vias)
                south_UpConnection_1: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=BL and (i < (TIERS-1)*X_ROUTERS*Y_ROUTERS) generate -- NOT LAST TIER
                        rx(i)(SOUTH)             <= tx(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        clock_rx(i)(SOUTH)       <= clock_tx(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        credit_i(i)(SOUTH)       <= credit_o(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                        data_in(i)(SOUTH)        <= data_out(i+(X_ROUTERS*Y_ROUTERS))(WEST);
                end generate;   
                south_UpConnection_2: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=BR and (i < (TIERS-1)*X_ROUTERS*Y_ROUTERS) generate -- NOT LAST TIER
                        rx(i)(SOUTH)             <= tx(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                        clock_rx(i)(SOUTH)       <= clock_tx(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                        credit_i(i)(SOUTH)       <= credit_o(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                        data_in(i)(SOUTH)        <= data_out(i+(X_ROUTERS*Y_ROUTERS))(EAST);
                end generate;

                --FIRST_TIER+1 TO LAST_TIER
                west_DownConnection_1: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=BL and (i >= X_ROUTERS*Y_ROUTERS) generate 
                        rx(i)(WEST)             <= tx(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                        clock_rx(i)(WEST)       <= clock_tx(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                        credit_i(i)(WEST)       <= credit_o(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                        data_in(i)(WEST)        <= data_out(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                end generate;   
                east_DownConnection_1: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=BR and (i >= X_ROUTERS*Y_ROUTERS) generate 
                        rx(i)(EAST)             <= tx(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                        clock_rx(i)(EAST)       <= clock_tx(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                        credit_i(i)(EAST)       <= credit_o(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                        data_in(i)(EAST)        <= data_out(i-(X_ROUTERS*Y_ROUTERS))(SOUTH);
                end generate; 


              

                -- LAST TIER (ground UP vias)
                south_LastTierGrounding: if (routerPosition(i,X_ROUTERS,Y_ROUTERS)=BL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=BR) and (i >= (TIERS-1)*X_ROUTERS*Y_ROUTERS) generate -- LAST TIER
                        rx(i)(SOUTH)             <= '0';
                        clock_rx(i)(SOUTH)       <= '0';
                        credit_i(i)(SOUTH)       <= '0';
                        data_in(i)(SOUTH)        <= (others => '0');
                end generate;




                ------------------------------------------------------------------------------
                --- EAST PORT CONNECTIONS ----------------------------------------------------
                ------------------------------------------------------------------------------
                -- NAO IREMOS MDUAR
                east_grounding: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=CRX generate
                        rx(i)(EAST)             <= '0';
                        clock_rx(i)(EAST)       <= '0';
                        credit_i(i)(EAST)       <= '0';
                        data_in(i)(EAST)        <= (others => '0');
                end generate;

                -- NAO IREMOS MDUAR
                east_connection: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=BL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TL  or routerPosition(i,X_ROUTERS,Y_ROUTERS)=BC or routerPosition(i,X_ROUTERS,Y_ROUTERS)= TC or routerPosition(i,X_ROUTERS,Y_ROUTERS)= CC generate
                        rx(i)(EAST)             <= tx(i+1)(WEST);
                        clock_rx(i)(EAST)       <= clock_tx(i+1)(WEST);
                        credit_i(i)(EAST)       <= credit_o(i+1)(WEST);
                        data_in(i)(EAST)        <= data_out(i+1)(WEST);
                end generate;

                ------------------------------------------------------------------------------
                --- WEST PORT CONNECTIONS ----------------------------------------------------
                ------------------------------------------------------------------------------
                west_grounding: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=CL generate
                        rx(i)(WEST)             <= '0';
                        clock_rx(i)(WEST)       <= '0';
                        credit_i(i)(WEST)       <= '0';
                        data_in(i)(WEST)        <= (others => '0');
                end generate;

                west_connection: if (routerPosition(i,X_ROUTERS,Y_ROUTERS)=BR or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CRX or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TR or  routerPosition(i,X_ROUTERS,Y_ROUTERS)=BC or routerPosition(i,X_ROUTERS,Y_ROUTERS)= TC or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CC) generate
                        rx(i)(WEST)             <= tx(i-1)(EAST);
                        clock_rx(i)(WEST)       <= clock_tx(i-1)(EAST);
                        credit_i(i)(WEST)       <= credit_o(i-1)(EAST);
                        data_in(i)(WEST)        <= data_out(i-1)(EAST);
                end generate;


                -------------------------------------------------------------------------------
                --- NORTH PORT CONNECTIONS ----------------------------------------------------
                -------------------------------------------------------------------------------
                north_grounding: if  routerPosition(i,X_ROUTERS,Y_ROUTERS)=TC generate
                        rx(i)(NORTH)            <= '0';
                        clock_rx(i)(NORTH)      <= '0';
                        credit_i(i)(NORTH)      <= '0';
                        data_in(i)(NORTH)       <= (others => '0');
                end generate;

                north_connection: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=BL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=BC or routerPosition(i,X_ROUTERS,Y_ROUTERS)=BR or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CRX or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CC generate
                        rx(i)(NORTH)            <= tx(i+X_ROUTERS)(SOUTH);
                        clock_rx(i)(NORTH)      <= clock_tx(i+X_ROUTERS)(SOUTH);
                        credit_i(i)(NORTH)      <= credit_o(i+X_ROUTERS)(SOUTH);
                        data_in(i)(NORTH)       <= data_out(i+X_ROUTERS)(SOUTH);
                end generate;

                --------------------------------------------------------------------------------
                --- SOUTH PORT CONNECTIONS -----------------------------------------------------
                ---------------------------------------------------------------------------
                south_grounding: if  routerPosition(i,X_ROUTERS,Y_ROUTERS)=BC generate
                        rx(i)(SOUTH)            <= '0';
                        clock_rx(i)(SOUTH)      <= '0';
                        credit_i(i)(SOUTH)      <= '0';
                        data_in(i)(SOUTH)       <= (others => '0');
                end generate;

                south_connection: if routerPosition(i,X_ROUTERS,Y_ROUTERS)=TL or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TC or routerPosition(i,X_ROUTERS,Y_ROUTERS)=TR or routerPosition(i,X_ROUTERS,Y_ROUTERS)=CL or routerPosition(i,X_ROUTERS,Y_ROUTERS)= CRX or routerPosition(i,X_ROUTERS,Y_ROUTERS)= CC generate
                        rx(i)(SOUTH)            <= tx(i-X_ROUTERS)(NORTH);
                        clock_rx(i)(SOUTH)      <= clock_tx(i-X_ROUTERS)(NORTH);
                        credit_i(i)(SOUTH)      <= credit_o(i-X_ROUTERS)(NORTH);
                        data_in(i)(SOUTH)       <= data_out(i-X_ROUTERS)(NORTH);
                end generate;


        end generate noc;

	

end NOC;
