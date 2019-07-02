-- Used to figure out why a golden image is borked put the broken ones in uncompressed_formats and debug away
local image = require "image"
local os = require "al2o3.os"
local string = require "string"
local table = require "table"

uncompressed_formats = {
	"A8B8G8R8_SINT_PACK32"
}
function approx(a, b )
    d = a - b
    if d > 1e-5 or d < -1e-5 then
        return false
    else
        return true
    end
end

-- format checks
do
    for i,fmt in ipairs(uncompressed_formats) do
        local test, okay = image.create2D(16, 16, fmt)
        if okay ~= true then
            print("unable to be create image 16x16 " .. fmt)
            goto stop
        end

        local fmt_split={}
        for str in string.gmatch(fmt, "([^_]+)") do
            table.insert(fmt_split, str)
        end
        local a = 1.0
        if string.find(fmt_split[1], "A") == nil then 
            a = 0.0
        end

        for y = 0, 15 do
            for x = 0, 15 do
				local i = test:calculateIndex(x, y, 0, 0)

				local r = x / 15.0 
				local g = y / 15.0
				local b = x / 15.0
                test:setPixelAt(i, r, g, b, a)
            end
        end

        test:saveAsKTX("artifacts/borked_fmtcheck_" .. fmt .."_16x16.ktx")
    end
    
    for i,fmt in ipairs(uncompressed_formats) do
        local arti, okaya = image.load("artifacts/borked_fmtcheck_" .. fmt .."_16x16.ktx")
        local golden, okayb = image.load("golden/fmtcheck_" .. fmt .."_16x16.ktx")

        if okaya == false or okayb == false then
            print("** Failed golden image load check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end

        local wi, hi, di, si = arti:dimensions();
        local wg, hg, dg, sg = golden:dimensions();

        local formati = arti:format();
        local flagsi = arti:flags()
        local formatg = golden:format();
        local flagsg = golden:flags()

        if wi ~= wg or hi ~= hg or di ~= dg or si ~= sg then
            print("** Failed golden image dim check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end

        if formati ~= formatg then
            print("** Failed golden image format check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end

        if flagsi.Cubemap ~= flagsg.Cubemap then
            print("** Failed golden image cubemap check for fmtcheck_" .. fmt .."_16x16.ktx")
            goto continue
        end

	    for y = 0, 15 do
	        for x = 0, 15 do
                local i = golden:calculateIndex(x, y, 0, 0)
	            local ri, gi, bi, ai = arti:getPixelAt(i)
	            local rg, gg, bg, ag = golden:getPixelAt(i)

                if approx(ri, rg) == false or approx(gi, gg) == false or approx(bi, bg) == false or approx(ai, ag) == false then 
                    print("** Failed golden image pixel check for fmtcheck_" .. fmt .."_16x16.ktx <" .. x .. "," .. y .. ">")
                    print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
	            end
	        end
	    end
        ::continue::
    end

    ::stop::
end


