locals {
  tags = {
    "salte:git_commit_short_sha" = var.GIT_COMMIT_SHORT_SHA
    "salte:git_repository"       = var.GIT_REPOSITORY
    "salte:last_updated"         = "${formatdate("M/D/YYYY H:mmAA", timestamp())} UTC"
  }
}
