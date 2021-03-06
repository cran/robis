use_cache <- function() {
  getOption("robis_use_cache", FALSE)
}

api_url <- function() {
  getOption("robis_api_url", "https://api.obis.org/")
}

page_size <- function() {
  getOption("robis_page_size", 5000)
}

handle_date <- function(date) {
  if (!is.null(date) && class(date) == "Date") {
    return(as.character(date))
  } else {
    return(date)
  }
}

handle_logical <- function(b) {
  if (!is.null(b)) {
    return(tolower(as.character(b)))
  } else {
    return(NULL)
  }
}

handle_vector <- function(x) {
  if (!is.null(x)) {
    return(paste0(x, collapse = ","))
  } else {
    return(x)
  }
}

handle_fields <- function(x) {
  if (!is.null(x)) {
    if (!("id" %in% x)) {
      x <- c("id", x)
    }
    return(paste0(x, collapse = ","))
  } else {
    return(x)
  }
}

handle_request_error <- function(e) {
  message("Error: Failed to connect to the OBIS API. If the problem persists, please contact helpdesk@obis.org.")
  return(invisible(NULL))
}

http_request <- function(method, path, query, verbose=FALSE) {
  if (!curl::has_internet()) {
    message("Error: No internet connection.")
    return(invisible(NULL))
  }
  if (use_cache()) {
    get <- httpcache::GET
    post <- httpcache::POST
  } else {
    get <- httr::GET
    post <- httr::POST
  }
  url <- paste0(api_url(), path)
  if (method == "GET") {
    result <- tryCatch(get(url, user_agent("robis - https://github.com/iobis/robis"), query = query), error = handle_request_error)
  } else if (method == "POST") {
    result <- tryCatch(post(url, user_agent("robis - https://github.com/iobis/robis"), body = query), error = handle_request_error)
  }
  if (httr::http_error(result)) {
    message("Error: The OBIS API was not able to process your request. If the problem persists, please contact helpdesk@obis.org.")
    return(invisible(NULL))
  }
  if (verbose) {
    log_request(result)
  }
  return(result)
}

log_request <- function(result) {
  message(paste0("URL: ", result$request$url))
  message(paste0("Status: ", result$status_code))
  message(paste0("Age: ", result$headers$age))
  message(paste0("Time: ", result$times[["total"]]))
}

empty_cols <- function(df) {
  return(sapply(df, function(k) {
    all(is.na(k))
  }))
}

log_progress <- function(count, total) {
  if (total > 0) {
    pct <- floor(count / total * 100)
    if (pct > 100) pct <- 100
  } else {
    pct <- 100
  }
  message(paste0("\rRetrieved ", count, " records of approximately ", total, " (", pct, "%)", sep = ""), appendLF = FALSE)
}
