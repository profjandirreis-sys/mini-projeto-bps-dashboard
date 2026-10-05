# Mapeamento de discrepâncias entre os anos (2020 a 2026)

Conferência feita no notebook `BPS_20_26_Jandir_limpeza.ipynb` antes da concatenação.

## Estrutura e nomes de colunas

| Verificação | Resultado | Solução |
|---|---|---|
| Nomes e ordem das colunas | As 36 colunas são iguais nos 7 arquivos | Concatenação direta com `pd.concat` |
| Separador | `;` em todos os anos | `sep=";"` na leitura |
| Codificação dos arquivos | Leitura em UTF-8, com Latin-1 como alternativa | `try/except` na leitura |
| Cabeçalhos repetidos | Apareceram na primeira junção manual (Google Planilhas) | Removidos; a junção final foi feita em Python |
| Origem de cada linha | Não existia | Coluna auxiliar `arquivo_origem` para conferência (removida no final, `ano_compra` identifica o ano) |

## Volume por ano

| Ano | Registros | Observação |
|---|---:|---|
| 2020 | 84.920 | |
| 2021 | 85.147 | |
| 2022 | 89.659 | |
| 2023 | 33.874 | Queda forte no volume a partir de 2023 |
| 2024 | 28.972 | |
| 2025 | 34.797 | |
| 2026 | 11.524 | Ano parcial |

Total consolidado: **368.893 registros**, igual à soma dos 7 arquivos (nenhuma linha perdida).

## Formatos e conteúdo

| Problema encontrado | Colunas | Solução |
|---|---|---|
| Caracteres corrompidos (`nÂº`, `nÂ°`) em 7.329 linhas | `nu_processo_compra` | Remoção do `Â` indevido |
| Datas como texto `dd/mm/aaaa` | `dt_compra`, `dt_insercao` | Conversão para data; `ano_compra` conferido com o ano da data (0 divergências) |
| CNPJs lidos como número, perdendo o zero à esquerda | `cnpj_instituicao`, `cnpj_fornecedor`, `cnpj_fabricante` | Conversão para texto com 14 dígitos (`zfill`) |
| Códigos lidos como decimal (sufixo `.0`) | `co_pdm`, `co_grupo`, `co_classe`, `registro_anvisa` | Conversão para inteiro |
| Campos de texto vazios | `fg_generico`, `sg_unidade_medida`, `no_instituicao`, `ds_observacao`, `nu_ata` e outros | Preenchidos com "Não informado" |
| Vazios que não devem ser inventados | `dt_insercao` (2.142), `co_pdm`/`co_grupo`/`co_classe` (401), `registro_anvisa`, `vl_capacidade` | Mantidos vazios |
| Registros duplicados | Todas | 0 linhas duplicadas e 0 `co_seq_bps` repetidos |
| Valores zerados ou negativos | `vl_preco_total` | Nenhum preço menor ou igual a zero |
| Total diferente de unitário × quantidade | `vl_preco_total` | 0 linhas com diferença acima de 1% |
