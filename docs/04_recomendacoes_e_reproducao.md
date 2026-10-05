# Recomendações e instruções para reprodução

## Recomendações baseadas nos dados

1. **Revisar os registros com preço suspeito antes de usar os totais.** 902 registros (0,24% das linhas) somam 56,8% do valor total. Os 10 maiores registros sozinhos somam 54,5%. O caso mais extremo (penicilamina, PR, 2025, R$ 294.400 por unidade) indica provável erro de digitação na origem.
2. **Usar a mediana do item como referência de preço** nas negociações, em vez da média, porque poucos valores extremos distorcem a média.
3. **Validação na entrada dos dados do BPS:** um alerta quando o preço unitário informado ficar muito acima da mediana do mesmo item evitaria boa parte dos erros.
4. **Comparar preços entre estados para o mesmo item:** PR e SP têm o maior número de registros e, por isso, o maior histórico de preços para servir de referência a outras UFs.
5. **Acompanhar a queda de registros a partir de 2023** (de cerca de 85 mil por ano para cerca de 30 mil), para entender se houve menos compras ou menos instituições informando ao BPS.
6. **Olhar as compras judiciais separadamente** (6.096 registros), porque seguem regras e preços diferentes das compras administrativas.

## Instruções para reprodução

1. Baixe os CSVs anuais de 2020 a 2026 no portal de dados abertos do Ministério da Saúde: https://dadosabertos.saude.gov.br/dataset/bps
2. Abra o notebook `BPS_20_26_Jandir_limpeza.ipynb` no Google Colab e envie os 7 arquivos para a pasta da sessão (nomes `2020.csv` a `2026.csv`).
3. Execute as células em ordem. O notebook:
   - lê e concatena os arquivos (separador `;`, UTF-8 ou Latin-1);
   - confere colunas, duplicados, vazios e tipos;
   - corrige encoding, datas, CNPJs e códigos;
   - cria `ano_mes`, `razao_mediana` e `preco_suspeito`;
   - gera `BPS_20_26_Jandir.zip` (base completa) e `BPS_20_26_Jandir_dashboard.csv` (versão enxuta).
4. No Looker Studio, crie uma fonte de dados com o upload do `BPS_20_26_Jandir_dashboard.csv` (ou a partir do Google Drive).
5. Configure `dt_compra` como data (AAAAMMDD), `vl_preco_total` e `vl_preco_unitario` como moeda (R$) e crie os campos calculados descritos em [03_colunas_e_kpis.md](03_colunas_e_kpis.md).
6. Monte as 3 páginas e os filtros de UF, ano, modalidade e item.

Se preferir pular a limpeza, a base completa já tratada está na release **v1.0** deste repositório.
