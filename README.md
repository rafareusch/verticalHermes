# verticalHermes
### Alterações Hermes_switchcontrol.vhd:
<p align="center">
  <img src="/Fotos/Imagem1.png" width="350" title="hover text">
</p>
- Foi alterado o tamanho do “address” para receber as informações de tier e stack;
- Inserimos os sinais x_router e y_router com o intuito de armazenar a posição x e y da matriz (NoC).
<p align="center">
  <img src="/Fotos/Imagem2.png" title="hover text">
</p>
- Inserimos quatro sinais para obter as informações de tier e stack;
<p align="center">
  <img src="/Fotos/Imagem3.png" title="hover text">
</p>
- Acrescentamos as condições de subida e descida quando os dados estão nos elevadores;
<p align="center">
  <img src="/Fotos/Imagem4.png" title="hover text">
</p>
- No estado “S3” acrescentamos a condição para os dados irem para o elevador mais próximo quando a mensagem está no tier e/ou stak diferente do atual.
<p align="center">
  <img src="/Fotos/Imagem5.png" title="hover text">
</p>
### Alterações NoC.vhd:
<p align="center">
  <img src="/Fotos/Imagem6.png" title="hover text">
</p>
- Alteramos a variável que testa as condições da função “RouterPosition()” para funcionar com um número genérico de tier;
<p align="center">
  <img src="/Fotos/Imagem7.png" title="hover text">
</p>
- Foi alterada a função “RouterAddress()” para inserir as informações de tier e stack;
<p align="center">
  <img src="/Fotos/Imagem8.png" title="hover text">
</p>
- Inserimos as conexões EAST-WEST-NORTH para os roteadores TR/TL/BR de modo a funcionarem genericamente com o número de tier;
<p align="center">
  <img src="/Fotos/Imagem9.png" title="hover text">
</p>
- Inserimos as conexões EAST-WEST-SOUTH para os roteadores BL/TL/BR de modo a funcionarem genericamente com o número de tier;
<p align="center">
  <img src="/Fotos/Imagem10.png" title="hover text">
</p>
### Test BenchMark:
- Teste Bench comprovando que os dados conseguem transitar de um tier inferior para um superior dentro da NoC continua funcionando o direcionamento por XY;
--Dados saem do roteador 04 no primeiro tier e vão até o roteador 26 no terceiro tier.
<p align="center">
  <img src="/Fotos/Imagem11.png" title="hover text">
</p>
<p align="center">
  <img src="/Fotos/Imagem12.png" title="hover text">
</p>
- Teste Bench comprovando que os dados conseguem transitar de um tier superior para um inferior dentro da NoC continua funcionando o direcionamento por XY;
-- Dados saem do roteador 26 no terceiro tier e vão até o roteador 00 no primeiro tier.
<p align="center">
  <img src="/Fotos/Imagem13.png" title="hover text">
</p>
<p align="center">
  <img src="/Fotos/Imagem14.png" title="hover text">
</p>
