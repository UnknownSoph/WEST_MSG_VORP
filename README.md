# Sistema de Mensagens Privadas para RedM

Este projeto implementa um sistema de envio de mensagens privadas para trabalhos específicos (como médicos e policiais) no RedM utilizando o framework VORP.

https://streamable.com/ny7nhs

## Funcionalidades

- **Comando /msg:** Permite que jogadores enviem mensagens privadas para outros jogadores do mesmo trabalho (médico ou policial).
- **Animações de Interação:** Quando o jogador abre o input para escrever a mensagem, uma animação de escrita é reproduzida.
- **Sistema de Autorização:** Apenas jogadores com os trabalhos "médico" ou "policial" podem utilizar o comando /msg.

## Arquivos Principais

### 1. `cl_msg.lua`
Este arquivo contém toda a lógica do lado do cliente, responsável por:

- Registrar o comando `/msg` que abre a interface de input.
- Gerenciar a interface NUI para captura de mensagens.
- Iniciar e parar animações relacionadas à interação do jogador com o sistema de mensagens.

### 2. `sv_msg.lua`
Este arquivo contém a lógica do lado do servidor, responsável por:

- Verificar o trabalho do jogador ao tentar utilizar o comando `/msg`.
- Enviar a mensagem para todos os jogadores que possuem o mesmo trabalho.
- Configurar as cores e prefixos das mensagens baseadas no trabalho do jogador (médico ou policial).

### 3. `index.html`
Arquivo HTML que define a interface do input de mensagens. Este arquivo é carregado como parte do NUI e é exibido quando o jogador abre o input para escrever a mensagem.

### 4. `fxmanifest.lua`
Arquivo de manifesto que define as dependências e os scripts utilizados no recurso. É necessário para que o RedM reconheça e carregue corretamente os scripts e arquivos do recurso.

## Instalação

1. **Copiar os Arquivos:** Copie todos os arquivos do projeto para a pasta de recursos do seu servidor RedM.
2. **Configurar `fxmanifest.lua`:** Certifique-se de que o `fxmanifest.lua` está configurado corretamente para carregar os scripts e arquivos necessários.
3. **Iniciar o Recurso:** Adicione o recurso à lista de recursos que são iniciados com o servidor (`server.cfg`).

## Utilização

- **/msg:** Jogadores que possuem o trabalho de "médico" ou "policial" podem utilizar o comando `/msg` para enviar mensagens privadas para outros jogadores do mesmo trabalho.

## Depuração

- **Logs:** O código contém várias linhas de `print` para auxiliar na depuração, exibindo informações no console sobre as ações realizadas e eventos disparados.
- **Erros Comuns:** Se as mensagens não estiverem sendo exibidas no chat, verifique se o evento `msg:sendMessage` está sendo corretamente disparado e se a interface NUI está corretamente carregada.

## Contribuição

Sinta-se à vontade para contribuir com melhorias, sugestões ou correções para este projeto. Para isso, faça um fork do repositório e envie um pull request com as suas modificações.

## Licença

Este projeto é de código aberto sob a licença MIT.

## Autor

Criado por **uira182**.
