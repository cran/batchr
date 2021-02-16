## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
path <- file.path(tempdir(), "demo")
unlink(path)
dir.create(path)

writeLines("the contents of file.txt", file.path(path, "file.txt"))
writeLines("the contents of file2.txt", file.path(path, "file2.txt"))
writeLines("the contents of file3.txt", file.path(path, "file3.txt"))
writeLines("the contents of file4.txt", file.path(path, "file4.txt"))

## -----------------------------------------------------------------------------
fun <- function(file) {
  if(grepl("file3[.]txt$", file)) return(FALSE)
  if(grepl("file4[.]txt$", file)) stop("Uh, Houston, we've had a problem.", call. = FALSE)
  txt <- readLines(file)
  txt <- gsub("contents", "modified contents", txt)
  writeLines(txt, file)
}

## -----------------------------------------------------------------------------
library(batchr)
print(batch_config(fun, path = path, regexp = "file\\d[.]txt$"))

## -----------------------------------------------------------------------------
batch_config_read(path)

## -----------------------------------------------------------------------------
print(batch_run(path, ask = FALSE))

## -----------------------------------------------------------------------------
batch_log_read(path)

## -----------------------------------------------------------------------------
batch_report(path)

## -----------------------------------------------------------------------------
readLines(file.path(path, "file2.txt"))

## -----------------------------------------------------------------------------
batch_reconfig_fileset(path, regexp = "[.]txt$")

fun <- function(file) {
  txt <- readLines(file)
  txt <- gsub("contents", "modified contents", txt)
  writeLines(txt, file)
}

batch_reconfig_fun(path, fun)

## -----------------------------------------------------------------------------
batch_run(path, ask = FALSE)

## -----------------------------------------------------------------------------
batch_report(path)

## -----------------------------------------------------------------------------
batch_run(path, failed = TRUE, ask = FALSE)

## -----------------------------------------------------------------------------
batch_report(path)

## -----------------------------------------------------------------------------
list.files(path, all.files = TRUE)
print(batch_cleanup(path))
list.files(path, all.files = TRUE)

