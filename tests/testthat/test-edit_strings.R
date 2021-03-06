context("suffix_match")


test_that("tags a vector", {
  actual <- suffix_match(
    c("tag1", "tag2"),
    c("dead", "whatever"),
    "dead",
    ".d"
  )
  expected <- c("tag1.d", "tag2")
  expect_equal(actual, expected)
})

test_that("with numeric `tag` does not abort -- only warns (#13)", {
  expect_warning(
    suffix_match(
      as.numeric(c("000", "001")),
      c("dead", "whatever"),
      "dead",
      ".d"
    )
  )
})


test_that("warns if no stem is dead", {
  expect_warning(
    suffix_match(
      c("tag1", "tag2"),
      c("not-dead", "not-dead"),
      "dead",
      ".d"
    )
  )
})

test_that("fails if x, status, and suffix are not character vectors", {
  # Passes
  expect_equal(
    suffix_match(
      c("tag1", "tag2"),
      c("dead", "whatever"),
      "dead",
      "_suffix"
    ),
    c("tag1_suffix", "tag2")
  )

  # Warn
  expect_warning(
    suffix_match(
      1,
      c("dead", "whatever"),
      "dead",
      "_suffix"
    )
  )
  expect_error(
    suffix_match(
      c("tag1", "tag2"),
      1,
      "dead",
      "_suffix"
    )
  )
  expect_error(
    suffix_match(
      c("tag1", "tag2"),
      c("dead", "whatever"),
      "dead",
      suffix = 1
    )
  )

  expect_warning(
    suffix_match(
      c("tag1", "tag2"),
      c("dead", "whatever"),
      "D",
      "_suffix"
    )
  )
})



context("to_tidy_names")

test_that("works as unnamed character string", {
  skip_if_not_installed("fgeo.tool")

  string <- "Hi mE"
  expect_equal(fgeo.tool::nms_tidy(string), to_tidy_names(string))
  expect_equal(to_tidy_names(string), "hi_me")
})



context("anchor")

test_that("outputs the expected string", {
  expect_equal(anchor(letters[1:3]), c("^a$", "^b$", "^c$"))
})
