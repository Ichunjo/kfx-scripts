#! by Vardë

-- Bleu 
color_top = "&HE0B06B&"
color_mid = "&H8C2A2B&"
color_bot = "&H6B004F&"

-- Rouge
color_top2 = "&HC960ED&"
color_mid2 = "&H270248&"
color_bot2 = "&H1B025B&"


ms_from_frame = 1000 / 23.976

function autotags(interval,tags1,tags2,duration) 
    local result = "" 
    local tags = 0 
    local tab = 0 
    local count = math.ceil(duration/interval) 
    tab = {tags1,tags2} 
    for i = 1, count do 
        if tags1 and tags2 then 
            if  i%2 == 0 then 
                tags = tab[1] 
            else tags = tab[2] 
            end 
        end 
        result = result.."\\t("..(i-1)*interval..","..i*interval..","..tags..")".."" 
    end 
    return result 
end


function roumaji(line, l)
    l.effect = "Roselia fx"
    fad = "\\fad(120,160)"

    l.start_time = line.start_time
    l.end_time = line.end_time

    blurtext = ""
    glowtext = ""

    for ci, char in ipairs(line.chars) do
        interval = math.random(ms_from_frame*3, ms_from_frame*6)
        bordtag1 = "\\bord4.5\\blur30"
        bordtag2 = "\\bord1.5\\blur15"
        texttag = "{" .. autotags(interval, bordtag1, bordtag2, line.duration) .. "}"
        glowtext = glowtext .. texttag .. char.text

        bordtag1 = "\\bord4.5\\blur10"
        bordtag2 = "\\bord1.5\\blur5"
        texttag = "{" .. autotags(interval, bordtag1, bordtag2, line.duration) .. "}"
        blurtext = blurtext .. texttag .. char.text
    end

    glowtext = glowtext:gsub(" ", "{\\fscx50} {\\fscx100}")
    blurtext = blurtext:gsub(" ", "{\\fscx50} {\\fscx100}")
    line.text = line.text:gsub(" ", "{\\fscx50} {\\fscx100}")

    l.layer = 1
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                    line.center, line.top, fad, glowtext)
    io.write_line(l);

    l.layer = 2
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\blur5%s}%s",
                    line.center, line.top, fad, blurtext)
    io.write_line(l);


    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.top, color, 
                        line.left - 10, math.round(line.top + line.height - line.descent - line.ascent + (j - 1)), 
                        line.right + 10, math.round(line.top + line.height - line.descent - line.ascent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 5  do
        color_bleu = utils.interpolate(j / (line.descent + 5), color_mid, color_bot)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.top, color, 
                        line.left - 10, math.round(line.top + line.height - line.descent + (j - 1)), 
                        line.right + 10, math.round(line.top  + line.height - line.descent + j), 
                        fad, line.text)
        io.write_line(l);
    end
end


function sub(line, l)
    l.effect = "Roselia fx"

    fad = "\\fad(120,160)"

    l.start_time = line.start_time
    l.end_time = line.end_time

    blurtext = ""
    glowtext = ""

    for ci, char in ipairs(line.chars) do
        interval = math.random(ms_from_frame*3, ms_from_frame*6)
        bordtag1 = "\\bord4.5\\blur30"
        bordtag2 = "\\bord1.5\\blur15"
        texttag = "{" .. autotags(interval, bordtag1, bordtag2, line.duration) .. "}"
        glowtext = glowtext .. texttag .. char.text

        bordtag1 = "\\bord4.5\\blur10"
        bordtag2 = "\\bord1.5\\blur5"
        texttag = "{" .. autotags(interval, bordtag1, bordtag2, line.duration) .. "}"
        blurtext = blurtext .. texttag .. char.text
    end

    glowtext = glowtext:gsub(" ", "{\\fscx50} {\\fscx100}")
    blurtext = blurtext:gsub(" ", "{\\fscx50} {\\fscx100}")
    line.text = line.text:gsub(" ", "{\\fscx50} {\\fscx100}")

    l.layer = 1
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                    line.center, line.bottom, fad, glowtext)
    io.write_line(l);

    l.layer = 2
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\blur5%s}%s",
                    line.center, line.bottom, fad, blurtext)
    io.write_line(l);

    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.bottom, color, 
                        line.left - 10, math.round(line.top + line.height - line.descent - line.ascent + (j - 1)), 
                        line.right + 10, math.round(line.top + line.height - line.descent - line.ascent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 10  do
        color_bleu = utils.interpolate(j / (line.descent + 10), color_mid, color_bot)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.bottom, color, 
                        line.left - 10, math.round(line.top + line.height - line.descent + (j - 1)), 
                        line.right + 10, math.round(line.top  + line.height - line.descent + j), 
                        fad, line.text)
        io.write_line(l);
    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        if line.styleref.alignment == 8 then 
            roumaji(line, table.copy(line))
        else 
            sub(line, table.copy(line))
        end
    end
    io.progressbar(li / #lines)
end
