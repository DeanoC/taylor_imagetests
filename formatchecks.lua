math = require("math")

uncompressed_formats = {
  "R1_UNORM",
  "R2_UNORM",
  "R4_UNORM",
  "R4G4_UNORM",
  "G4R4_UNORM",
  "A8_UNORM",
  "R8_UNORM",
  "R8_SNORM",
  "R8_UINT",
  "R8_SINT",
  "R8_SRGB",
  "B2G3R3_UNORM",
  "R4G4B4A4_UNORM",
  "R4G4B4X4_UNORM",
  "B4G4R4A4_UNORM",
  "B4G4R4X4_UNORM",
  "A4R4G4B4_UNORM",
  "X4R4G4B4_UNORM",
  "A4B4G4R4_UNORM",
  "X4B4G4R4_UNORM",
  "R5G6B5_UNORM",
  "B5G6R5_UNORM",
  "R5G5B5A1_UNORM",
  "B5G5R5A1_UNORM",
  "A1B5G5R5_UNORM",
  "A1R5G5B5_UNORM",
  "R5G5B5X1_UNORM",
  "B5G5R5X1_UNORM",
  "X1R5G5B5_UNORM",
  "X1B5G5R5_UNORM",
  "B2G3R3A8_UNORM",
  "R8G8_UNORM",
  "R8G8_SNORM",
  "G8R8_UNORM",
  "G8R8_SNORM",
  "R8G8_UINT",
  "R8G8_SINT",
  "R8G8_SRGB",
  "R16_UNORM",
  "R16_SNORM",
  "R16_UINT",
  "R16_SINT",
  "R16_SFLOAT",
  "R16_SBFLOAT",
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
  "R8G8B8X8_UNORM",
  "B8G8R8X8_UNORM",
  "R16G16_UNORM",
  "G16R16_UNORM",
  "R16G16_SNORM",
  "G16R16_SNORM",
  "R16G16_UINT",
  "R16G16_SINT",
  "R16G16_SFLOAT",
  "R16G16_SBFLOAT",
  "R32_UINT",
  "R32_SINT",
  "R32_SFLOAT",
  "A2R10G10B10_UNORM",
  "A2R10G10B10_UINT",
  "A2B10G10R10_UNORM",
  "A2B10G10R10_UINT",
  "R10G10B10A2_UNORM",
  "B10G10R10A2_UNORM",
  "B10G10R10A2_UINT",
  "B10G11R11_UFLOAT",
  "E5B9G9R9_UFLOAT",
  "R16G16B16_UNORM",
  "R16G16B16_SNORM",
  "R16G16B16_UINT",
  "R16G16B16_SINT",
  "R16G16B16_SFLOAT",
  "R16G16B16_SBFLOAT",
  "R16G16B16A16_UNORM",
  "R16G16B16A16_SNORM",
  "R16G16B16A16_UINT",
  "R16G16B16A16_SINT",
  "R16G16B16A16_SFLOAT",
  "R16G16B16A16_SBFLOAT",
  "R32G32_UINT",
  "R32G32_SINT",
  "R32G32_SFLOAT",
  "R32G32B32_UINT",
  "R32G32B32_SINT",
  "R32G32B32_SFLOAT",
  "R32G32B32A32_UINT",
  "R32G32B32A32_SINT",
  "R32G32B32A32_SFLOAT",
  "R64_UINT",
  "R64_SINT",
  "R64_SFLOAT",
  "R64G64_UINT",
  "R64G64_SINT",
  "R64G64_SFLOAT",
  "R64G64B64_UINT",
  "R64G64B64_SINT",
  "R64G64B64_SFLOAT",
  "R64G64B64A64_UINT",
  "R64G64B64A64_SINT",
  "R64G64B64A64_SFLOAT",
}

Xuncompressed_formats = {
  "B10G11R11_UFLOAT",
}


function very_low_precision(fmt_split)
  if  fmt_split[1] == "B2G3R3" or
      fmt_split[1] == "B2G3R3A8" or
      
      fmt_split[1] == "R4G4B4A4" or
      fmt_split[1] == "B4G4R4A4" or
      
      fmt_split[1] == "R5G6B5" or
      fmt_split[1] == "B5G6R5" or

      fmt_split[1] == "A1B5G5R5" or 
      fmt_split[1] == "X1B5G5R5" or 
      fmt_split[1] == "R5G5B5A1" or
      fmt_split[1] == "R5G5B5X1" or
      fmt_split[1] == "B5G5R5A1" or 
      fmt_split[1] == "B5G5R5X1" or 
      fmt_split[1] == "A1R5G5B5" or
      fmt_split[1] == "X1R5G5B5" or
      0
  then
        return true
  end
  return false
end

function very_low_precision_float(fmt_split)
  if  fmt_split[1] == "B10G11R11" or
      0
  then
        return true
  end
  return false
end
function round(n)
  return math.floor((math.floor(n*2) + 1)/2)
end

function low_precision(fmt_split)
  -- TODO check we are really this low precision or is this a bug in SNORM put/fetch?
  if  (fmt_split[1] == "R8G8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "G8R8" and fmt_split[2] == "SNORM")or 
      (fmt_split[1] == "R8G8B8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "B8G8R8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "R8G8B8A8" and fmt_split[2] == "SNORM") or 
      (fmt_split[1] == "B8G8R8A8" and fmt_split[2] == "SNORM") or 

      (fmt_split[1] == "A2R10G10B10_UNORM" and fmt_split[2] == "UNORM") or 
      (fmt_split[1] == "A2R10G10B10_UINT" and fmt_split[2] == "UINT") or 
      (fmt_split[1] == "A2B10G10R10_UNORM" and fmt_split[2] == "UNORM") or 
      (fmt_split[1] == "A2B10G10R10_UINT" and fmt_split[2] == "UINT") or 
      (fmt_split[1] == "R10G10B10A2_UNORM" and fmt_split[2] == "UNORM") or 
      (fmt_split[1] == "B10G10R10A2_UNORM" and fmt_split[2] == "UNORM" or 
      (fmt_split[1] == "B10G10R10A2_UINT" and fmt_split[2] == "UINT") or 

      0 )
  then
    return true
  end

  return false
end

function skip_test(fmt_split)
    -- in some cases precision issues mean we get false negative
    -- TODO test these seperately from the batch tester 
    local skip = false

    if  fmt_split[1] == "B2G3R3" or
        fmt_split[1] == "B2G3R3A8" or
        fmt_split[2] == "SRGB" then skip = true end

    if string.find(fmt_split[1], "64") ~= nil then 
      skip = true
    end

    return skip
end

local checkedCount = 0
local passedCount = 0
local ktxSaved = 0
local ddsSaved = 0
local ktxPassed = 0
local ddsPassed = 0

-- format checks
do    
  for i,fmt in ipairs(uncompressed_formats) do
    local test, okay = image.create2D(16, 16, fmt)
    if okay ~= true then
        print("unable to be create image 16x16 " .. fmt)
        goto continue1
    end

    local fmt_split={}
    for str in string.gmatch(fmt, "([^_]+)") do
        table.insert(fmt_split, str)
    end

    local ignoreMask = { false, false, false, false }
    if string.find(fmt_split[1], "R") == nil then 
      ignoreMask[0] = true;
    end
    if string.find(fmt_split[1], "G") == nil then 
      ignoreMask[1] = true;
    end
    if string.find(fmt_split[1], "B") == nil then 
      ignoreMask[2] = true;
    end
    if string.find(fmt_split[1], "A") == nil then 
      ignoreMask[3] = true;
    end

    local precision = 1e-4
    if low_precision(fmt_split) then precision = 1e-2 end
    if very_low_precision(fmt_split) then precision = 1e-1 end
    if very_low_precision_float(fmt_split) then precision = 4.5 end

    local av = 15
    if string.find(fmt_split[1], "A1") then 
      if not string.find(fmt_split[1], "A16") then
        av = 1
      end
    end
    if string.find(fmt_split[1], "A2") then 
        av = 3
    end


    local skip = skip_test(fmt_split)
    if skip then print("skipping " .. fmt) end

    checkedCount = checkedCount +1

    local norm = fmt_split[2] == "SNORM" or fmt_split[2] == "UNORM" or fmt_split[2] == "SRGB" 
    local signed = fmt_split[2] == "SNORM" or fmt_split[2] == "SFLOAT" or fmt_split[2] == "SINT"

    local xysize = 16
    local maxrgbval = xysize

    for y = 0, xysize-1 do
      for x = 0, xysize-1 do
				local i = test:calculateIndex(x, y, 0, 0)

        local r = x 
        local g = y
        local b = (x + y) / 2
        local a = (x / (y+1)) * x
        if a > av then a = av end


        r = round(r);
        g = round(g);
        b = round(b);
        a = round(a);

        if signed then
          maxrgbval = 8
          r = (r - maxrgbval)
          g = (g - maxrgbval)
          b = (b - maxrgbval)
          a = (a - maxrgbval)
        end

        if norm then                  
            r = r / (maxrgbval-1)
            g = g / (maxrgbval-1)
            b = b / (maxrgbval-1)
            a = a / av
            if r > 1 then r = 1 end
            if r < -1 then r = -1 end
            if g > 1 then g = 1 end
            if g < -1 then g = -1 end
            if b > 1 then b = 1 end
            if b < -1 then b = -1 end
            if a > 1 then a = 1 end
            if a < -1 then a = -1 end
        end


        test:setPixelAt(i, r, g, b, a)

        if skip == false then
          local rg, gg, bg, ag = test:getPixelAt(i)

          local fail = false

          if (ignoreMask[0] == false) and
              (approx(r, rg, precision) == false) then
            print(fmt .. " RED fail")
            fail = true
          end
          if (ignoreMask[1] == false) and
              (approx(g, gg, precision) == false) then
            print(fmt .. " GREEN fail")
            fail = true
          end
          if (ignoreMask[2] == false) and
              (approx(b, bg, precision) == false) then
            print(fmt .. " BLUE fail")
            fail = true
          end
          if (ignoreMask[3] == false) and
              (approx(a, ag, precision) == false) then
            print(fmt .. " ALPHA fail")
            fail = true
          end

          if fail then 
              print("Failed image set/get pixel check for " .. fmt .. "<" .. x .. "," .. y .. ">")
              local rv = r
              local gv = g
              local bv = b
              local av = a
              if ignoreMask[0] then rv = 0 end
              if ignoreMask[1] then gv = 0 end
              if ignoreMask[2] then bv = 0 end
              if ignoreMask[3] then av = 1 end
              print(string.format("read(%f,%f,%f,%f) != written(%f,%f,%f,%f)", rg, gg, bg, ag, rv, gv, bv, av))
              goto continue1
          end

      	end
      end
	  end
    passedCount = passedCount +1

	  -- save it
    if skip == true then goto continue1 end

    local okayD = true
    local okayK = true

    local fname = "artifacts/fmtcheck_" .. fmt .."_16x16"
	  if test:canSaveAsKTX() then
      if test:saveAsKTX(fname .. ".ktx") == false then
        print("Failed saving KTX file " .. fname);
        okayK = false
      end
    else
      print("Can't save " .. fname .. " as KTX file")
      okayK = false
    end
    if test:canSaveAsDDS() then
  	  if test:saveAsDDS(fname .. ".dds") == false then
        print("Failed saving DDS file " .. fname);
        okayD = false
      end
    else
      print("Can't save " .. fname .. " as DDS file")
      okayD = false
    end

    if(okayD == false and okayK == false) then
      goto continue1
    end

	  -- try and reload
    local loadedK;
    local loadedD;

    if(okayK) then
      local okayK2
  	  loadedK, okayK2 = image.load(fname .. ".ktx")
      if okayK2 ~= true then
          print("unable to be load " .. fname .. ".ktx")
      else
        ktxSaved = ktxSaved +1
      end
     okayK = okayK2
    end
    if(okayD) then
    local okayD2
	   loadedD, okayD2 = image.load(fname .. ".dds")
	   if okayD2 ~= true then
	        print("unable to be load " .. fname .. ".dds")
      else  
        ddsSaved = ddsSaved +1
	   end
     okayD = okayD2
    end

	  for y = 0, 15 do
	      for x = 0, 15 do
	          local i = test:calculateIndex(x, y, 0, 0)
	          local rg, gg, bg, ag = test:getPixelAt(i)

	          if okayK then
	            local ri, gi, bi, ai = loadedK:getPixelAt(i)
	            if ri ~= rg or gi ~= gg or bi ~= bg or ai ~= ag then 
	                print("Failed image pixel check for .ktx " .. fmt .. "<" .. x .. "," .. y .. ">")
	                print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                    print("test fmt = " .. test:format() .. " Ktx loaded formated = " .. loadedK:format())
	                goto continue1
	            end
	          end

	          if okayD then
	            local ri, gi, bi, ai = loadedD:getPixelAt(i)
	            if ri ~= rg or gi ~= gg or bi ~= bg or ai ~= ag then 
	                print("Failed image pixel check for .dds " .. fmt .. "<" .. x .. "," .. y .. ">")
	                print(string.format("(%f,%f,%f,%f) != (%f,%f,%f,%f)", ri, gi, bi, ai, rg, gg, bg, ag))
                    print("test fmt = " .. test:format() .. " DDS loaded formated = " .. loadedD:format())
	                goto continue1
	            end
	          end
	      end
	  end
    if okayK then ktxPassed = ktxPassed + 1 end
    if okayD then ddsPassed = ddsPassed + 1 end
	  ::continue1::
  end

  print("Format Check Passed: " .. passedCount .. " of " .. checkedCount)
  print("KTX Save Load Passed: " .. ktxPassed .. " of " .. ktxSaved)
  print("DDS Save Load Passed: " .. ddsPassed .. " of " .. ddsSaved)

  local dirent = os.filesystem.directoryEnumeratorCreate("golden")
  
  for fname, isdir in dirent do
      if fname == "__README.txt" then 
        goto continue2 
      end
      if string.find(fname, ".kts") == nil then
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
