# Fuze App

## Ferramentas:
- Swift Package Manager: Para gerenciador de dependências terceiras e modularização do app;
- Target min iOS 15: Usei o AsyncImage | ControlSize modifier | ...;
- Projeto criado pelo Xcode 14.1 (swift-tools-version: 5.7);
- Swifgen para gerar código (Assets, Fonts, Strings);

## Bibliotecas terceiras utilizadas:
- [Combine Schedulers](https://github.com/pointfreeco/combine-schedulers): Utilizada apenas para os Unit Tests mockando os schedulers do Combine.

## Para rodar o projeto:
- Caso não tenha o Swifgen basta rodar 'make environment' para instalar;
- Após instalado rodar 'make all' para gerar os arquivos com Swifgen ;
- Abrir o arquivo Workspace.xcworkspace;
- Esperar o SPM indexar e baixar as dependencias;

## Observações (utilizei o projeto para aprender algumas coisas e relembrar de outras)
- Foi adicionado estrutura para Localização;
- Foi adicionado cadastro de fontes customizadas;
- Foi adicionado estrutura para design system;
- Foi adicionado tests unitários em controladores lógicos;
- Foi adicionado estrutura para dark/light mode;

## O que ficou pendente?
- Logger (queria aprender)
- Dependency Injection (poderia ter feito com closures passando no environment das features mas queria algo tipo ServiceLocator)

## Explicação dos Targets do SPM:
### Core
- Core-DesignSystem: Valores estáticos para padronizar a view + Fontes;
- Core-UI: Componentes compartilhados | Modifiers | Templates | Styles e Extensions;
- Core-Resources: Assets | Strings | Fonts | Código gerado pelo Swiftgen;
- Core-Networking: Target concreto da camada de rede apenas pode ser propagada nos Repositories-Live das features;
- Core-Networking-Interface: Target de interface da camada de para ser propagada entre os Repositories das features;

### Feature
- Feature-LaunchScreen: Lógica inicial do app, cadastra as fontes e direciona para Home;
- Feature-Home: Feature principal, lista os matchs do CSGO;
- Feature-Home-Repository: Modelo view | interface do serviço e endpoint;
- Feature-Home-Repository-Live: Modelo DTO | Implementação concreta do serviço;
- Feature-MatchDetails: Feature do detalhe do match, contem a lista dos jogadores;
- Feature-MatchDetails-Repository: Modelo view | interface do serviço e endpoint;
- Feature-MatchDetails-Repository-Live: Modelo DTO | Implementação concreta do serviço;

### Root
- Root-Extensions: Extensões base para utilizar nas Features;
- Root-Elements: Componentes base para utilizar nas Features;