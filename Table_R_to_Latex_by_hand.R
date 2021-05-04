#Write latex table by hand
table_latex_file = file(paste(path_draft_tables,"table_treatment_stats.tex", sep=""))
table_header = c("\\begin{table}[H]",
                 "\\centering",
                 "\\caption{Aggregate statistics by treatment groups}",
                 "\\label{tab:table_treatment_stats}",
                 "\\scalebox{0.7}{",
                 "\\begin{tabular}{lcccccccc}",
                 "\\toprule",
                 "\\toprule")
table_columns = paste("Treatment",
                      "Total",
                      "\\makecell*[c]{Opened  \\\\ website [\\%]}",
                      "Modified [\\%]",
                      "\\makecell*[c]{Increased  \\\\ length [\\%]}",
                      "\\makecell*[c]{Decreased  \\\\ length [\\%]}",
                      "Assigned [\\%]",
                      "\\makecell*[c]{Changed  \\\\ assignment \\\\ state [\\%]}",
                      "\\makecell*[c]{Changed  \\\\ program of \\\\ assignment [\\%]}",
                      sep = " & ")
table_body = paste(table_columns, "\\\\" ," \\midrule")

space = '\\\\[0pt]'
table_stats = table_treatment_stats # Table with the coefficient estimates
table_sterr_stats = table_treatment_stats_stderr # Table with the standard errors
#Fill table body
for(i in 1:nrow(table_stats)){
  row = c()
  for(j in 1:ncol(table_stats)){
    row_stat = table_stats[i,j]
    if(j == 1){
      row = row_stat
    }
    else{
      row = paste(row, "&", row_stat)
    }
  }
  row = paste(row, space)
  table_body = c(table_body, row)
  # Paste row for standard errors
  row = c()
  for(j in 1:ncol(table_sterr_stats)){
    row_stat = table_sterr_stats[i,j]
    if(j != 1){
      row = paste(row, "&", paste("(",row_stat,")",sep=""))
    }
  }
  row = paste(row, space)
  table_body = c(table_body, row)
}

table_footer = c("\\bottomrule",
                 "\\multicolumn{9}{l}{\\textit{Note:} standard errors are computed in parenthesis.}",
                 "\\end{tabular}",
                 "}",
                 "\\end{table}")
table_latex_code = c(table_header, table_body, table_footer)
writeLines(table_latex_code, table_latex_file)
close(table_latex_file)
