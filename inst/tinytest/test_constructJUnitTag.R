

testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/empty_tests", package = "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(targ$attributes$tests, 0L)
expect_equal(attr(targ, "names"), c("name", "attributes", "content"))
expect_equal(attr(targ, "class"), "XMLtag")
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 0L)
expect_equal(targ$attributes$name, "tinytest results")

# if tested folder is empty, Jenkins pipeline failes with 
#  > "Error in setwd(dir) :cannot change working directory"

# testresults <- tinytest::run_test_dir(
#  dir = file.path(system.file("example_tests", package = "tinytest2JUnit"), "empty_test_folder"), 
#  verbose = FALSE
# )
testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/empty_test_folder", package = "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(targ$attributes$tests, 0L)
expect_equal(attr(targ, "names"), c("name", "attributes", "content"))
expect_equal(attr(targ, "class"), "XMLtag")
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 0L)
expect_equal(targ$attributes$name, "tinytest results")

testResults <- tinytest::run_test_dir(
  system.file("example_tests/heavy_calculations", package = "tinytest2JUnit"), verbose = F)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 1L)
expect_true(targ$attributes$failures == 0L)
expect_equal(targ$content[[1]]$name, "testsuite")
expect_equal(
  targ$content[[1]]$attributes, 
  list(name = "test_heavy_calculation.R", tests = 1L, failures = 0L)
)
expect_equal(
  targ$content[[1]]$content[[1]]$attributes, 
  list(name = "test_heavy_calculation.R: L16", status = "PASSED")
)

testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/multi_line_except_statement", package = "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 1L)
expect_true(targ$attributes$failures == 1L)
expect_equal(targ$content[[1]]$name, "testsuite")
expect_equal(
  targ$content[[1]]$attributes, list(name = "test_multiline_except.R", tests = 1L, failures = 1L)
)
expect_equal(
  targ$content[[1]]$content[[1]]$attributes,
  list(name = "test_multiline_except.R: L9-L15", status = "FAILED")
)

testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/multiple_files", package = "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 3L)
expect_true(targ$attributes$failures == 1L)
expect_equal(targ$content[[1]]$name, "testsuite")
expect_equal(targ$content[[1]]$attributes, list(name = "test_file1.R", tests = 2L, failures = 0L))
expect_equal(targ$content[[2]]$attributes, list(name = "test_file2.R", tests = 1L, failures = 1L))
expect_equal(
  targ$content[[1]]$content[[1]]$attributes, 
  list(name = "test_file1.R: L9", status = "PASSED")
)
expect_equal(
  targ$content[[1]]$content[[2]]$attributes, 
  list(name = "test_file1.R: L10", status = "PASSED")
)
expect_equal(
  targ$content[[2]]$content[[1]]$attributes, 
  list(name = "test_file2.R: L9-L15", status = "FAILED")
)

testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/simple_tests", package = "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 4L)
expect_true(targ$attributes$failures == 1L)
expect_equal(targ$content[[1]]$name, "testsuite")
expect_equal(
  targ$content[[1]]$attributes, 
  list(name = "test_addition.R", tests = 4L, failures = 1L)
)

testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/skips", package = "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 1L)
expect_equal(targ$content[[1]]$name, "testsuite")
expect_equal(
  targ$content[[1]]$attributes, 
  list(name = "test_partial_skipped.R", tests = 1L, failures = 0L)
)


testResults <- tinytest::run_test_dir(
  dir = system.file("example_tests/side_effects", package =  "tinytest2JUnit"), 
  verbose = FALSE
)
targ <- tinytest2JUnit:::constructTestsuitesTag(testResults)
expect_equal(names(targ$attributes), c("name", "tests", "failures", "duration"))
expect_true(!is.na(targ$attributes$duration))
expect_true(targ$attributes$tests == 3L)


