# Package

version       = "0.1.0"
author        = "jiro4989"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["karax_test.js"]
binDir        = "public"

backend       = "js"

# Dependencies

requires "nim >= 1.0.4"
requires "karax"
