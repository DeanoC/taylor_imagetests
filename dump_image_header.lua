-- dumps the header
local image = require "image"
local os = require "al2o3.os"
local string = require "string"
local table = require "table"

local test, okay = image.load("input/pvtt_ARGB1555_16x16.ktx")
if okay == false then
    print("failed to to load the image")
    goto continue
end

local w, h, d, s = test:dimensions();
local format = test:format();
local flags = test:flags()

print(string.format("%i x %i x %i x %i of %s", w, h, d, s, format))

::continue::
