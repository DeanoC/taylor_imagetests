
-- this is an invalid image saved by PVR texture tool, make sure we fail the load
local bad_ignore, shouldfail = image.load("input/bad_pvtt_ARGB1555_16x16.ktx")
if shouldfail == true then
    print("bad_pvtt_ARGB1555_16x16.ktx is an invalid file, we shouldn't load it but we did!")
end

-- load a png check size etc, save it as a bunch of different formats 
do
    local test, okay = image.load("input/simple.png")
    if okay ~= true then
        print("test_imageload.png unable to be loaded")
    else
        local w = test:width();
        local h = test:height();
        local d = test:depth();
        local s = test:slices();
        local format = test:format();
        local flags = test:flags()

        if w ~= 884 then
            print("simple.png is " .. w .. " wide it should be 884")
        end
        if h ~= 406 then
            print("simple.png is " .. h .. " high it should be 406")
        end
        if d ~= 1 then
            print("simple.png is " .. d .. " depth it should be 1")
        end
        if s ~= 1 then
            print("simple.png is " .. s .. " slices it should be 1")
        end
        if format ~= "R8G8B8A8_UNORM" then
            print("simple.png is " .. format .. " and should be R8G8B8A8_UNORM")
        end
        if flags.Cubemap == true then
            print("simple.png marked as a Cubemaps and shouldn't be")
        end
        if flags.HeaderOnly == true then
            print("simple.png marked as a header only and shouldn't be")
        end

        test:saveAsDDS("artifacts/simple.dds")
        test:saveAsTGA("artifacts/simple.tga")
        test:saveAsBMP("artifacts/simple.bmp")
        test:saveAsPNG("artifacts/simple.png")
        test:saveAsJPG("artifacts/simple.jpg")
        test:saveAsKTX("artifacts/simple.ktx")

        local test, okay = image.load("artifacts/simple.ktx")
        if okay ~= true then
            print("load artifacts/simple.ktx fail")
            test:saveAsKTX("artifacts/simple_load_save.ktx")    
        end
    end
end

-- create a non pow 2 image, check its okay save as png
do
    local test, okay = image.create(88, 46, 1, 1, "R8G8B8A8_UNORM")
    if okay ~= true then
        error("unable to be create image")
    else
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
end