# Principais colunas e definição dos KPIs

## Colunas usadas no dashboard

| Coluna | Tipo | Descrição |
|---|---|---|
| `ano_compra` | Número | Ano da compra |
| `dt_compra` | Data (AAAAMMDD) | Data da compra |
| `sg_uf` | Texto | Sigla do estado da instituição |
| `no_municipio` | Texto | Município da instituição |
| `ds_esfera` | Texto | Esfera: municipal, estadual, federal ou privada |
| `no_instituicao` / `cnpj_instituicao` | Texto | Instituição compradora |
| `co_catmat` | Número | Código do item no catálogo de materiais (CATMAT) |
| `item_resumo` | Texto | Nome curto do item (criado a partir de `ds_item`) |
| `tp_compra` | Texto | Tipo de compra: administrativa ou judicial |
| `modalidade` | Texto | Modalidade: pregão, dispensa, registro de preços etc. |
| `no_fornecedor` / `cnpj_fornecedor` | Texto | Fornecedor |
| `no_fabricante` | Texto | Fabricante |
| `un_fornecimento` | Texto | Unidade de fornecimento (comprimido, frasco, ampola etc.) |
| `qt_medicamento` | Número | Quantidade comprada |
| `vl_preco_unitario` | Moeda (R$) | Preço por unidade |
| `vl_preco_total` | Moeda (R$) | Valor total do registro (o `preco_total` do enunciado) |
| `preco_suspeito` | Texto (Sim/Não) | "Sim" quando o preço unitário passa de 100 vezes a mediana do mesmo `co_catmat` (itens com 5 ou mais compras) |

## KPIs

| KPI | Fórmula | Agregação | Valor na base completa |
|---|---|---|---:|
| Valor total registrado | `SUM(vl_preco_total)` | Soma | R$ 115,41 bilhões |
| Quantidade total de itens comprados | `SUM(qt_medicamento)` | Soma | 64,9 bilhões de unidades |
| Número de registros de compra | Contagem de linhas (`Record Count`) | Contagem | 368.893 |
| Instituições compradoras | `COUNT_DISTINCT` da instituição | Contagem distinta | 687 |
| Fornecedores | `COUNT_DISTINCT` do fornecedor | Contagem distinta | 3.466 |
| Preço unitário médio ponderado | `SUM(vl_preco_total) / SUM(qt_medicamento)` | Razão entre somas | R$ 1,78 |

## Regras de agregação

- **Preço unitário nunca é somado.** Somar preços unitários de compras diferentes não tem significado.
- **Preço médio ponderado** usa a razão entre as somas (e não a média simples dos preços), para que compras grandes pesem mais do que compras pequenas.
- **Instituições e fornecedores** usam contagem distinta, porque o mesmo comprador ou fornecedor aparece em muitos registros.
- **Comparação de preços** só faz sentido para o mesmo item (`co_catmat`) e a mesma unidade de fornecimento. Por isso a regra de preço suspeito compara cada preço com a **mediana do próprio item**, que é menos afetada por valores extremos do que a média.
- Todos os KPIs respondem aos filtros de UF, ano, modalidade e item.

## Validação

Os valores dos KPIs no Looker Studio foram conferidos com os cálculos em pandas no notebook (ex.: valor total geral = R$ 115.412.346.216; 115,41 bi ÷ 64,9 bi ≈ R$ 1,78).
