load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/example/project
gazelle(name = "gazelle")

go_library(
    name = "project_lib",
    srcs = ["main.go"],
    importpath = "github.com/example/project",
    visibility = ["//visibility:private"],
)

go_binary(
    name = "bazeltest",
    embed = [":project_lib"],
    visibility = ["//visibility:public"],
)
