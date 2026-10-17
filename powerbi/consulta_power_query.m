// Consulta "BPS" (Power Query / M) usada no Power BI Desktop
// Lê o CSV do dashboard (separador vírgula, decimal com ponto, UTF-8)
let
    Fonte = Csv.Document(File.Contents("C:\Users\ronia\Downloads\BPS_20_26_SeuNome_dashboard (2).csv"), [Delimiter=",", Columns=19, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    Cabecalhos = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    // "en-US" garante que 0.15 seja lido como 0,15 (o Power BI em português leria como 15)
    Tipos = Table.TransformColumnTypes(Cabecalhos, {{"ano_compra", Int64.Type}, {"co_catmat", Int64.Type}, {"qt_medicamento", Int64.Type}, {"vl_preco_unitario", type number}, {"vl_preco_total", type number}}, "en-US"),
    // dt_compra vem como AAAAMMDD
    Datas = Table.TransformColumns(Tipos, {{"dt_compra", each #date(Number.FromText(Text.Start(_, 4)), Number.FromText(Text.Middle(_, 4, 2)), Number.FromText(Text.End(_, 2))), type date}}),
    // Etapa gravada pelo Power BI Desktop ao renomear as colunas no painel Dados
    #"Colunas Renomeadas" = Table.RenameColumns(Datas,{{"sg_uf", "UF"}, {"ano_compra", "Ano"}, {"modalidade", "Modalidade"}, {"item_resumo", "Item"}, {"no_fabricante", "Fabricante"}, {"no_fornecedor", "Fornecedor"}, {"preco_suspeito", "Preço suspeito"}, {"vl_preco_unitario", "Preço unitário"}})
in
    #"Colunas Renomeadas"
