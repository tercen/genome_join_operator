library(tercen)
library(dplyr)
library(fuzzyjoin)
library(IRanges)

options("tercen.workflowId" = "f1d15aa887a970f0a9c3f66d6400766a")
options("tercen.stepId"     = "4bc96129-d225-4818-986d-6f28c29d8fbc")

ctx = tercenCtx()

documentId <- ctx$cselect()[[1]]
client = ctx$client
schema = client$tableSchemaService$get(documentId)

columns <- "chromosome, start, end"
if(!is.null(ctx$op.value('columns'))) columns <- ctx$op.value('columns')
columns <- trimws(strsplit(columns, ",")[[1]])

right_table <- as_tibble(client$tableSchemaService$select(schema$id, as.list(columns), 0, schema$nRows))
colnames(right_table) <- c("chromosome", "start", "end")

chromosome <- ctx$rselect(ctx$rnames[[1]])[[1]] %>% as_tibble
names(chromosome) <- "chromosome"
start <- ctx$rselect(ctx$rnames[[2]])[[1]] %>% as.numeric() %>% as_tibble
names(start) <- "start"
end <- ctx$rselect(ctx$rnames[[3]])[[1]] %>% as.numeric() %>% as_tibble
names(end) <- "end"
left_keys <- bind_cols(chromosome, start, end) %>% mutate(.ri = 1:nrow(.) - 1)

df_joined <- genome_left_join(left_keys, right_table, by = c("chromosome", "start", "end"))
df_joined %>% 
  ctx$addNamespace() %>%
  ctx$save()
