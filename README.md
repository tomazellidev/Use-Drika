# Use Drika

Loja de moda feminina desenvolvida para a Use Drika, em Forquilhinhas, São José, SC. A logo original está em `public/logo-use-drika.jpeg`, sem alteração de proporções ou conteúdo.

**A entrega está em modo de demonstração.** As oito peças, imagens vetoriais, preços e estoques são exemplos identificados. Contas e pedidos funcionam no servidor local; pagamentos da demonstração são simulados. Não há vendas, fretes ou avaliações fictícias apresentados como reais.

## Abrir a loja

Requisito: **Node.js 24 ou superior**. Não é necessário instalar um banco separado.

No Windows, abra `INICIAR-LOJA.cmd` para a loja, **ACESSAR-ADMIN.cmd** para o painel ou **VER-SENHA-ADMIN.cmd** para consultar a senha inicial sem Bloco de Notas. Os atalhos usam o endereço HTTP correto e atualizam a compilação quando necessário. Alternativamente, execute na pasta do projeto:

```powershell
npm install
npm run build
npm start
```

Acesse **http://localhost:5173**. Mantenha o terminal aberto. `Ctrl+C` encerra o servidor.

Para editar com atualização automática: `npm run dev`. Se o ambiente impedir o processo auxiliar do Vite, use `npm run build` seguido de `npm start`. Alterações em `src/` exigem uma nova compilação ao usar `npm start`.

Copie `.env.example` para `.env` somente quando precisar mudar a configuração. Os valores padrão já abrem a demonstração. Use o endereço definido em `APP_URL`, inclusive o mesmo host e porta, para que a proteção de origem funcione. O servidor escuta apenas o computador local por padrão.

## Painel administrativo

Abra **http://localhost:5173/admin**. Conta da proprietária: **adricc10**. O painel possui produtos/mídias/promoções, estoque compartilhado, caixa presencial, pedidos, pagamentos, clientes, avaliações, conteúdo, avisos e relatórios/CSV. A senha inicial é criada com segurança e sua troca é obrigatória. Consulte [acesso e operação do painel](docs/ADMIN.md) e [evidências da entrega](docs/PLANO-ADMIN.md).

## Site público

- Início, catálogo, categorias, busca sem acentos, filtros por tamanho/cor/preço e ordenação com estado na URL.
- Página de produto, cor e tamanho obrigatórios, indisponibilidade, quantidade e consulta inicial de CEP.
- Sacola persistida neste navegador, edição, remoção com opção de desfazer e preservação após login.
- Cadastro com e-mail e senha, login, logout, sessões em cookie HttpOnly e pedidos restritos à proprietária da conta.
- Retirada gratuita e consulta de entrega manual com endereço, aprovação pela loja, validade e valor total antes de pagar.
- Checkout que recalcula preços, frete e estoque no servidor; chave de idempotência e reservas em transação SQLite.
- Pagamentos locais de teste: pendente, aprovado, recusado, cancelado e expirado. Liberação de reservas e baixa de estoque idempotente.
- Pedido com itens, variações, valores, modalidade e WhatsApp com o número preenchido.
- Avaliação somente após compra aprovada, bloqueio básico de dados pessoais/links e moderação antes da publicação.
- Contatos, mapa, página da loja e estrutura de políticas com pendências visíveis.

Experimente com um e-mail fictício terminado em `@example.test` e senha exclusiva de pelo menos 12 caracteres. Depois de criar um pedido, use **Simular resultado** na página do pedido. Isso não cobra nem envia produtos.

## O que depende de configuração

**Google:** siga [ACESSO-SOCIAL.md](docs/ACESSO-SOCIAL.md) e execute `npm run auth:status` para ver os campos pendentes. Google aceita a prévia localhost autorizada. O botão Apple foi removido da interface; a implementação opcional do servidor está preservada.

Google e Apple têm fluxos oficiais preparados no servidor e ficam indisponíveis até receber credenciais. O adaptador Mercado Pago Checkout Pro cria a preferência no servidor e valida notificações assinadas consultando o pagamento oficial. **Essas integrações externas ainda precisam ser homologadas com as contas da loja.** A simulação local não representa homologação do provedor.

O frete automático do Uber não está ativado: a documentação oficial prevê Uber Direct, mas elegibilidade da operação, cobertura local, contratação e acesso à API precisam de confirmação. O fluxo manual já permite informar um frete confirmado antes de liberar o checkout.

**As pendências ficam centralizadas em `config/store.json`.** Veja [a lista de lançamento](docs/LANCAMENTO.md), [a configuração das integrações](docs/INTEGRACOES.md) e [a operação do catálogo e estoque](docs/OPERACAO.md).

## Estrutura

Veja o [mapa dos módulos e suas responsabilidades](docs/ESTRUTURA.md). As páginas, componentes compartilhados, formulário de acesso e rotas de autenticação foram separados para facilitar a manutenção. A tela de entrada oferece e-mail/senha e Google.

| Local                | Conteúdo                                                         |
| -------------------- | ---------------------------------------------------------------- |
| `src/`               | Interface React, rotas, sacola, conta e estilos responsivos      |
| `server/`            | HTTP, autenticação, banco, pedidos, reservas, frete e pagamentos |
| `data/catalog.json`  | Cadastro inicial de produtos e variações                         |
| `config/store.json`  | Dados da loja, políticas, área atendida e pendências             |
| `public/`            | Logo original e arquivos públicos                                |
| `scripts/manage.mjs` | Procedimentos locais e confirmação de cotações fora do painel    |
| `tests/`             | Testes de servidor e fluxos de navegador                         |
| `docs/`              | Configuração, operação, fontes oficiais e verificação            |
| `dist/`              | Interface compilada; deve ser servida pelo servidor do projeto   |

`data/drika.sqlite` é criado no primeiro início e preserva os dados entre reinícios. Não fica dentro de `public/` ou `dist/`. O navegador armazena somente identificadores de variação e quantidade da sacola; credenciais e pedidos ficam no servidor. O ZIP não inclui banco, contas, `.env`, backups ou `node_modules`.

## Verificar e compactar

```powershell
npm test
npm run test:remote
npx playwright install chromium
npm run test:browser
npm run build
npm run package
```

Os testes usam bancos temporários, sem alterar os pedidos da demonstração. O teste de navegador inicia seu próprio servidor na porta 5188; deixe essa porta livre. As capturas e o resultado do axe são gravados em `test-results/`. O pacote fica em **`artifacts/use-drika-projeto.zip`**. Consulte os resultados e limites em [VERIFICACAO.md](docs/VERIFICACAO.md).

`test:remote` verifica o adaptador HTTP e a função usando um simulador local do protocolo Turso; não acessa o provedor real. Para gerar o pacote de publicação com caminhos POSIX, use `npm run package:vercel` (Python 3): **`artifacts/use-drika-vercel.zip`**.

## Hospedar depois

**Para publicar diretamente na Vercel, sem usar créditos do v0, siga [VERCEL.md](docs/VERCEL.md).** O projeto inclui `api/index.js`, `vercel.json`, banco remoto Turso por HTTP, manutenção autenticada e limites de tentativas compartilhados no banco. Configure as credenciais na hospedagem; não envie `.env` ao repositório. Sem banco, a prévia demo mostra o catálogo e mantém contas indisponíveis. A conexão com o provedor real e o deploy ainda precisam ser validados na conta da loja.

Também é possível usar uma instância Node 24 com disco persistente para o SQLite local, HTTPS e backups. Publicar apenas `dist/` em hospedagem estática não disponibiliza conta, estoque ou pagamentos. Nenhum serviço foi contratado ou publicado.

Custos e a adequação ao orçamento de R$ 200 dependem da periodicidade, hospedagem, domínio, taxas da conta de pagamentos e operação de entrega. Veja [INTEGRACOES.md](docs/INTEGRACOES.md). As dependências do projeto não exigiram contratação de serviços.
