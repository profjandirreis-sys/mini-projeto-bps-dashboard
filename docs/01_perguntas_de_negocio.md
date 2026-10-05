# Perguntas de negócio

Perguntas definidas na Sprint 1, antes de construir o dashboard. Cada uma está ligada às colunas do BPS que permitem respondê-la e ao visual que a responde.

| # | Pergunta | Colunas usadas | Onde é respondida |
|---|---|---|---|
| 1 | Como o valor registrado em compras evoluiu de 2020 a 2026? | `ano_compra`, `dt_compra`, `vl_preco_total` | Página 2: Valor registrado por ano |
| 2 | Quais estados e municípios concentram o maior volume financeiro? | `sg_uf`, `no_municipio`, `vl_preco_total` | Página 2: Estados com maior valor + filtro de UF |
| 3 | Quais instituições compram mais? | `no_instituicao`, `cnpj_instituicao`, `vl_preco_total` | KPI Instituições compradoras + filtros |
| 4 | Quais medicamentos e dispositivos têm maior valor e maior quantidade comprada? | `item_resumo`, `co_catmat`, `qt_medicamento`, `vl_preco_total` | Página 2: Itens com maior valor registrado |
| 5 | Quais fornecedores e fabricantes têm maior participação? | `no_fornecedor`, `no_fabricante`, `vl_preco_total` | Página 3: Fornecedores e Fabricantes com maior valor |
| 6 | Quais modalidades de compra são mais usadas? | `modalidade`, contagem de registros | Página 2: Modalidades de compra mais registradas |
| 7 | O preço unitário do mesmo item varia muito entre instituições, fornecedores e anos? | `co_catmat`, `vl_preco_unitario`, `sg_uf`, `no_fornecedor`, `ano_compra` | Página 3: Tabela "Oportunidade de investigação" + filtro de item |
| 8 | Quais registros merecem investigação por preço fora do padrão? | `vl_preco_unitario`, mediana por `co_catmat`, `preco_suspeito` | Página 3: marcação de preço suspeito |

> Diferença de preço não é prova de sobrepreço ou irregularidade. Ela pode vir de apresentação, unidade de fornecimento, quantidade, local, modalidade ou período diferentes.
