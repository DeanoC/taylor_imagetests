local image = require "image"
local os = require "al2o3.os"
local string = require "string"
local table = require "table"

local inputDirExists = os.filesystem.dirExists("input")
if inputDirExists ~= true then
    error("input directory does not exist")
end
local inputDirExists = os.filesystem.dirExists("artifacts")
if inputDirExists ~= true then
	os.filesystem.dirCreate("artifacts")
end
local inputDirExists = os.filesystem.dirExists("golden")
if inputDirExists ~= true then
    error("golden directory does not exist")
end

-- this is an invalid image saved by PVR texture tool, make sure we fail the load
local bad_ignore, shouldfail = image.load("input/bad_pvtt_ARGB1555_16x16.ktx")
if shouldfail == true then
    print("bad_pvtt_ARGB1555_16x16.ktx is an invalid file, we shouldn't load it but we did!")
end


-- load a png check size etc, save it as a bunch of different formats 
do
    local test, okay = image.load("input/simple.png")
    if okay ~= true then
        error("test_imageload.png unable to be loaded")
    end
    local w = test:width();
    local h = test:height();
    local d = test:depth();
    local s = test:slices();
    local format = test:format();
    local flags = test:flags()

    if w ~= 884 then
        error("simple.png is " .. w .. " wide it should be 884")
    end
    if h ~= 406 then
        error("simple.png is " .. h .. " high it should be 406")
    end
    if d ~= 1 then
        error("simple.png is " .. d .. " depth it should be 1")
    end
    if s ~= 1 then
        error("simple.png is " .. s .. " slices it should be 1")
    end
    if format ~= "R8G8B8A8_UNORM" then
        error("simple.png is " .. format .. " and should be R8G8B8A8_UNORM")
    end
    if flags.Cubemap == true then
        error("simple.png marked as a Cubemaps and shouldn't be")
    end
    if flags.HeaderOnly == true then
        error("simple.png marked as a header only and shouldn't be")
    end

    --image.saveAsDDS("test_savedds.dds", test)
    test:saveAsTGA("artifacts/simple.tga")
    test:saveAsBMP("artifacts/simple.bmp")
    test:saveAsPNG("artifacts/simple.png")
    test:saveAsJPG("artifacts/simple.jpg")
    test:saveAsKTX("artifacts/simple.ktx")

    local test, okay = image.load("artifacts/simple.ktx")
    if okay ~= true then
        error("load artifacts/simple.ktx fail")
    end
    test:saveAsKTX("artifacts/simple_load_save.ktx")    
end

-- create a non pow 2 image, check its okay save as png
do
    local test, okay = image.create(88, 46, 1, 1, "R8G8B8A8_UNORM")
    if okay ~= true then
        error("unable to be create image")
    end
    local w = test:width();
    local h = test:height();
    local d = test:depth();
    local s = test:slices();
    local format = test:format();
    local flags = test:flags()

    if w ~= 88 then
        print("create image is " .. w .. " wide it should be 88")
    end
    if h ~= 46 then
        print("create image is " .. h .. " high it should be 46")
    end
    if d ~= 1 then
        print("create image is " .. d .. " depth it should be 1")
    end
    if s ~= 1 then
        print("create image is " .. s .. " slices it should be 1")
    end
    if format ~= "R8G8B8A8_UNORM" then
        print("create image is " .. format .. " and should be R8G8B8A8_UNORM")
    end
    if flags.Cubemap == true then
        print("create image marked as a Cubemaps and shouldn't be")
    end
    if flags.HeaderOnly == true then
        print("create image marked as a header only  and shouldn't be")
    end
    -- should be a completely black with 0 alpha image
    test:saveAsPNG("artifacts/create_rgba8_88x46.png")
end

-- create a pow2 2D texture fill with set pixels save as ktx 
do
    local test, okay = image.create2D(16, 16, "R8G8B8A8_UNORM")
    if okay ~= true then
        error("create2D fail")
    end
    for y = 1, 16 do
        for x = 1, 16 do
            local i = (y-1) * 16 + (x-1)
            test:setPixelAt(i, (x-1.0)/15.0, (y-1.0)/15.0, (x-1.0)/15.0, 1.0)
        end
    end

    for y = 0, 15 do
        for x = 0, 15 do
            local i = y * 16 + x
            local r, g, b , a = test:getPixelAt(i)
            if r ~= x/15.0 or g ~= y/15.0 or b ~= x/15.0 or a ~= 1.0 then 
                print("create2D get pixel failed <" .. x .. "," .. y .. ">")
            end
        end
    end
    test:saveAsKTX("artifacts/setpixel_rgba8_16x16.ktx")
end

-- load 16x16 ktx with mipmaps from PVR Texture Tool, save as png and ktx
do
    local test, okay = image.load("input/pvtt_rgba8_mm_16x16.ktx")
    if okay ~= true then
        print("pvtt_rgba8_mm_16x16.ktx unable to be loaded")
    end

    test:saveAsPNG("artifacts/pvtt_rgba8_mm_16x16.png")
    test:saveAsKTX("artifacts/pvtt_rgba8_mm_16x16.ktx")
end

-- create a 256x256 image, set pixels save as png, reload and check every pixel was set and saved correctly
-- checks manual index calculations and calculateIndex function
do
    local test, okay = image.createNoClear(256, 256, 1, 1, "R8G8B8A8_UNORM")
    if test == nil then
        print("unable to be create image")
    end

    for y = 1, 256 do
        for x = 1, 256 do
            local i = (y-1) * 256 + (x-1)
            test:setPixelAt(i, (x-1.0)/255.0, (y-1.0)/255.0, (x-1.0)/255.0, (y-1.0)/255.0)
        end
    end
    test:saveAsPNG("artifacts/setpixel_rgba8_256x256.png")

    local loadtest, okay = image.load("artifacts/setpixel_rgba8_256x256.png")
    for y = 1, 256 do
        for x = 1, 256 do
            local i = (y-1) * 256 + (x-1)
            local r, g, b, a = loadtest:getPixelAt(i)
            if(r ~= (x-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. r .. " red incorrect in setpixel_rgba8_256x256.png")
            end
            if(g ~= (y-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. g .. " green incorrect in setpixel_rgba8_256x256.png")
            end
            if(b ~= (x-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. b .. " blue incorrect in setpixel_rgba8_256x256.png")
            end
            if(a ~= (y-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. a .. " alpha incorrect in setpixel_rgba8_256x256.png")
            end
        end
    end

    for y = 1, 256 do
        for x = 1, 256 do
            local i = loadtest:calculateIndex(x-1,y-1, 0, 0)

            local r, g, b, a = loadtest:getPixelAt(i)
            if(r ~= (x-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. r .. " red incorrect in calculateIndex test")
            end
            if(g ~= (y-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. g .. " green incorrect in calculateIndex test")
            end
            if(b ~= (x-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. b .. " blue incorrect in calculateIndex test")
            end
            if(a ~= (y-1.0)/255.0) then
                print( x .. ", " .. y .. ": " .. a .. " alpha incorrect in calculateIndex test")
            end
        end
    end
end

uncompressed_formats = {
--  "R4G4_UNORM_PACK8",
  "R4G4B4A4_UNORM_PACK16",
  "B4G4R4A4_UNORM_PACK16",
  "R5G6B5_UNORM_PACK16",
  "B5G6R5_UNORM_PACK16",
  "R5G5B5A1_UNORM_PACK16",
  "B5G5R5A1_UNORM_PACK16",
  "A1R5G5B5_UNORM_PACK16",
  "R8_UNORM",
  "R8_SNORM",
  "R8_UINT",
  "R8_SINT",
  "R8_SRGB",
  "R8G8_UNORM",
  "R8G8_SNORM",
  "R8G8_UINT",
  "R8G8_SINT",
  "R8G8_SRGB",
  "R8G8B8_UNORM",
  "R8G8B8_SNORM",
  "R8G8B8_UINT",
  "R8G8B8_SINT",
  "R8G8B8_SRGB",
  "B8G8R8_UNORM",
  "B8G8R8_SNORM",
  "B8G8R8_UINT",
  "B8G8R8_SINT",
  "B8G8R8_SRGB",
  "R8G8B8A8_UNORM",
  "R8G8B8A8_SNORM",
  "R8G8B8A8_UINT",
  "R8G8B8A8_SINT",
  "R8G8B8A8_SRGB",
  "B8G8R8A8_UNORM",
  "B8G8R8A8_SNORM",
  "B8G8R8A8_UINT",
  "B8G8R8A8_SINT",
  "B8G8R8A8_SRGB",
  "A8B8G8R8_UNORM_PACK32",
  "A8B8G8R8_SNORM_PACK32",
  "A8B8G8R8_UINT_PACK32",
  "A8B8G8R8_SINT_PACK32",
  "A8B8G8R8_SRGB_PACK32",
  "A2R10G10B10_UNORM_PACK32",
  "A2R10G10B10_UINT_PACK32",
  "A2B10G10R10_UNORM_PACK32",
  "A2B10G10R10_UINT_PACK32",
  "R16_UNORM",
  "R16_SNORM",
  "R16_UINT",
  "R16_SINT",
  "R16_SFLOAT",
  "R16G16_UNORM",
  "R16G16_SNORM",
  "R16G16_UINT",
  "R16G16_SINT",
  "R16G16_SFLOAT",
  "R16G16B16_UNORM",
  "R16G16B16_SNORM",
  "R16G16B16_UINT",
  "R16G16B16_SINT",
  "R16G16B16_SFLOAT",
  "R16G16B16A16_UNORM",
  "R16G16B16A16_SNORM",
  "R16G16B16A16_UINT",
  "R16G16B16A16_SINT",
  "R16G16B16A16_SFLOAT",
  "R32_UINT",
  "R32_SINT",
  "R32_SFLOAT",
  "R32G32_UINT",
  "R32G32_SINT",
  "R32G32_SFLOAT",
  "R32G32B32_UINT",
  "R32G32B32_SINT",
  "R32G32B32_SFLOAT",
  "R32G32B32A32_UINT",
  "R32G32B32A32_SINT",
  "R32G32B32A32_SFLOAT",
}

function approx(a, b )
    d = a - b
    if d > 1e-5 or d < -1e-5 then
        return false
    else
        return true
    end
end

function skip_test(fmt_split)
         -- in some cases precision issues mean we get false negative
        -- TODO test these seperately from the batch tester 
        local skip = false
end

-- format checks
do    
    for i,fmt in ipairs(uncompressed_formats) do
        local fname = "artifacts/fmtcheck_" .. fmt .."_16x16.ktx"
        local test, okay = image.create2D(16, 16, fmt)
        if okay ~= true then
            print("unable to be create image 16x16 " .. fmt)
            goto continue1
        end

        local fmt_split={}
        for str in string.gmatch(fmt, "([^_]+)") do
            table.insert(fmt_split, str)
        end
        local a = 1.0
        if string.find(fmt_split[1], "A") == nil then 
            a = 0.0
        end

        local skip = skip_test(fmt_split)

        for y = 0, 15 do
            for x = 0, 15 do
                local i = test:calculateIndex(x, y, 0, 0)

                local r = x / 15.0 
                local g = y / 15.0
                local b = x / 15.0

                test:setPixelAt(i, r, g, b, a)
                if skip == false then 
                    local rg, gg, bg, ag = test:getPixelAt(i)
                    if approx(r,rg) == false or approx(g, gg)  == false or approx(b, bg) == false or approx(a,ag) == false then
                        print("Failed image set/get pixel check for " .. fmt .. "<" .. x .. "," .. y .. ">")
                        print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", rg, gg, bg, ag, r, g, b, a))
                        goto save_partial
                    end
                end
            end
        end

        -- save it
        ::save_partial::
        test:saveAsKTX(fname)
        -- try and reload
        local loaded, okay = image.load(fname)
        if okay ~= true then
            print("unable to be load " .. fname)
            goto continue1
        end

        for y = 0, 15 do
            for x = 0, 15 do
                local i = test:calculateIndex(x, y, 0, 0)
                local ri, gi, bi, ai = loaded:getPixelAt(i)
                local rg, gg, bg, ag = test:getPixelAt(i)
                if ri ~= rg or gi ~= gg or bi ~= bg or ai ~= ag then 
                    print("Failed image pixel check for " .. fmt .. "<" .. x .. "," .. y .. ">")
                    print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                    goto continue1
                end
            end
        end
        ::continue1::
    end

    local dirent = os.filesystem.directoryEnumeratorCreate("golden")
    
    for fname, isdir in dirent do
        if fname == "__README.txt" then 
            goto continue2 
        end
        local t={}
        for str in string.gmatch(fname, "([^_]+)") do
                table.insert(t, str)
        end
        local fmt = t[2] .. "_" .. t[3]
        if t[4] ~= "16x16.ktx" then 
            fmt = fmt .. "_" .. t[4]
        end
        local arti, okaya = image.load("artifacts/fmtcheck_" .. fmt .."_16x16.ktx")
        local golden, okayb = image.load("golden/fmtcheck_" .. fmt .."_16x16.ktx")
        if okaya == false or okayb == false then
            print("Failed golden image load check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue2
        end

        local wi, hi, di, si = arti:dimensions();
        local wg, hg, dg, sg = golden:dimensions();

        local formati = arti:format();
        local flagsi = arti:flags()
        local formatg = golden:format();
        local flagsg = golden:flags()

        if wi ~= wg or hi ~= hg or di ~= dg or si ~= sg then
            print("Failed golden image dim check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue2
        end

        if formati ~= formatg then
            print("Failed golden image format check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue2
        end
        if flagsi.Cubemap ~= flagsg.Cubemap then
            print("Failed golden image cubemap check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue2
        end

        for y = 0, 15 do
            for x = 0, 15 do
                local i = golden:calculateIndex(x, y, 0, 0)
                local ri, gi, bi, ai = arti:getPixelAt(i)
                local rg, gg, bg, ag = golden:getPixelAt(i)

                if approx(ri, rg) == false or approx(gi, gg) == false or approx(bi, bg) == false or approx(ai, ag) == false then 
                    print("Failed golden image pixel check for fmtcheck_" .. fmt .."_16x16.ktx <" .. x .. "," .. y .. ">")
                    print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                    goto continue2
                end
            end
        end
        ::continue2::
    end
    ::stop::
end


