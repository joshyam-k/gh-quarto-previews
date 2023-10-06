library(gh)
library(curl)
library(openssl)
library(stringr)

# start from entire files and work our way to permalinks

# figure out how to get sha from here
a <- curl("https://api.github.com/repos/joshyam-k/mas3/contents/R/utils.R", open = "r")
lines <- readLines(a)
close(a)

blob_sha_raw <- str_extract(lines, "(?<=sha\":)(\"[:alnum:]*\")")
blob_sha <- str_remove_all(blob_sha_raw, "\"")

blob <- gh("GET /repos/{owner}/{repo}/git/blobs/{file_sha}",
           owner = "joshyam-k",
           repo = "mas3",
           file_sha = blob_sha)

step1 <- base64_decode(blob[["content"]]) 

paste0(sapply(step1, rawToChar), collapse = '') |> cat()


# eventually use this permalink:
# permalink <- "https://github.com/joshyam-k/mas3/blob/517aa69dfc5abf65c1d296e07937c64d6fd0d54d/R/utils.R#L20-L22"
