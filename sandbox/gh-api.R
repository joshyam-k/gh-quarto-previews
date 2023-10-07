library(gh)
library(curl)
library(openssl)
library(stringr)

# start from entire files and work our way to permalinks
# the sha in a permalink is to a commit (I think always the most recent one...)
# is it worth tracing down the actual file through that or should we not even use the api

a <- curl("https://api.github.com/repos/joshyam-k/mas3/contents/R/utils.R", open = "r")
lines <- readLines(a)
close(a)

blob_sha_raw <- str_extract(lines, "(?<=sha\":)(\"[:alnum:]*\")")
blob_sha <- str_remove_all(blob_sha_raw, "\"")

blob <- gh("GET /repos/{owner}/{repo}/git/blobs/{file_sha}",
           owner = "joshyam-k",
           repo = "mas3",
           file_sha = blob_sha)

tt <- gh("GET /repos/{owner}/{repo}/commits/{ref}",
   owner = "joshyam-k",
   repo = "adv-of-code22",
   ref = "65d1cb66632842f9f7a94e48d5dd42fb7fe0e026")

step1 <- base64_decode(blob[["content"]]) 

s <- paste0(sapply(step1, rawToChar), collapse = '') |> cat()


