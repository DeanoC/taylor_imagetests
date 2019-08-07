image = require "image"
os = require "al2o3.os"
string = require "string"
table = require "table"

local inputDirExists = os.filesystem.dirExists("input")
if inputDirExists ~= true then
    error("input directory does not exist")
end
local inputDirExists = os.filesystem.dirExists("golden")
if inputDirExists ~= true then
    error("golden directory does not exist")
end

local inputDirExists = os.filesystem.dirExists("artifacts")
if inputDirExists ~= true then
	os.filesystem.dirCreate("artifacts")
    print("creating artifacts folder")
end
local inputDirExists = os.filesystem.dirExists("artifacts/testimages")
if inputDirExists ~= true then
    os.filesystem.dirCreate("artifacts/testimages")
    print("creating artifacts/testimages folder")
end

function approx(a, b, precision)
    d = a - b + 1e-10
    if d > precision or d < -precision then
        return false
    else
        return true
    end
end

function ImageLoadAndSimpleCheck(prefix, fname, expected_width, expected_height, expected_depth, expected_slices, expected_cubemap, expected_format)
    local filename = prefix .. fname

    local test, okay = image.load(filename)
    if okay ~= true then
        error("Could not load " .. filename)
        return nil
    end


    if test:width() ~= expected_width then
        print(filename .. " load failed with width = " .. test:width() .. " it should be " .. expected_width)
        return nil
    end

    if test:height() ~= expected_height then
        print(filename .. " load failed with height = " .. test:height() .. " it should be " .. expected_height)
        return nil
    end
    if test:depth() ~= expected_depth then
        print(filename .. " load failed with depth = " .. test:depth() .. " it should be " .. expected_depth)
        return nil
    end
    if test:slices() ~= expected_slices then
        print(filename .. " load failed with slices = " .. test:slices() .. " it should be " .. expected_slices)
        return nil
    end
    if test:isCubemap() ~= expected_cubemap then
        print(filename .. " load failed as cubemap = ", test:isCubemap(), " it should be ", expected_cubemap)
        return nil
    end

    if test:format() ~= expected_format then
        print(filename .. " load failed with format = " .. test:format() .. " it should be " .. expected_format)
        return nil
    end

    return test
end
--[[
local fname = "DDS_x4r4g4b4"
local loadpath = "input/openil-dds-testimages/" .. fname
local savepath = "artifacts/" .. fname
local test, okay = image.load(loadpath .. ".dds")
if okay then
    test:saveAsKTX(savepath .. ".ktx")
    test:saveAsDDS(savepath .. ".dds")
else
    print("Failed to load " .. loadpath .. ".dds")
end
]]--
require "ddsimagetests"
--[[
require "ktximagechecks"
require "miscchecks"
require "setpixelchecks"
require "formatchecks"
]]--
