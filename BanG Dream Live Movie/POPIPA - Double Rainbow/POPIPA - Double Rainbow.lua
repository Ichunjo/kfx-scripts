#! by Vardë


ms_per_frame = 1000 / 23.976

-- By tsukuri
function convert.hsv_to_ass(h, s, v, a)
    if type(h) ~= "number" or type(s) ~= "number" or type(v) ~= "number" then
      error("number, number and number expected", 2)
    elseif h < 0 or h > 360 or s < 0 or s > 1 or v < 0 or v > 1 then
      return nil
    end
  
    h = h / 360
  
    local r, g, b
  
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
  
    i = i % 6
  
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
  
    local red = r * 255
    local green = g * 255
    local blue = b * 255
  
    local bgr = string.format("&H%02x%02x%02x&", blue, green, red)
  
    return bgr
  
end

function char_counter(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            compteur = compteur + 1
        end
    end
    return compteur
end

function sub(line, l)
    l.effect = "Popipa fx"

    total_char = char_counter(line)

    leadin = 400 / total_char
    leadout = 300 / total_char

    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            l.start_time = line.start_time + (ci-1) * leadin
            l.end_time = line.end_time + (ci-1) * leadout

            l.layer = 1
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fad(%d,%d)}%s",
                            char.center, line.middle, ms_per_frame * 4, ms_per_frame * 4,
                            char.text)
            io.write_line(l);

            l.layer = 2
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\3c&H8D37E6&\\bord8\\blur0.6\\fad(%d,%d)}%s",
                            char.center, line.middle, ms_per_frame * 4, ms_per_frame * 4,
                            char.text)
            io.write_line(l);

            l.layer = 3
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fad(%d,%d)}%s",
                            char.center, line.middle, ms_per_frame * 4, ms_per_frame * 4,
                            char.text)
            io.write_line(l);

            l.layer = 4
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\bord0\\blur0.8\\fad(%d,%d)}%s",
                            char.center, line.middle, ms_per_frame * 4, ms_per_frame * 4,
                            char.text)
            io.write_line(l);

            -- By tsukuri
            for s, e, i, n in utils.frames(l.start_time, l.end_time, ms_per_frame) do
                l.start_time = s
                l.end_time = e

                l.layer = 0
                if i < 7 then
                    alf = utils.interpolate(i/6, 255, 80)
                elseif i > n-6 then
                    alf = utils.interpolate((i-(n-6))/6, 80, 255)
                else
                    alf = 80
                end
                color = convert.hsv_to_ass((s/16+ci*16)%360, 1, 1)

                l.text = string.format(
                    "{\\an5\\pos(%.3f,%.3f)\\bord16\\blur15\\c%s\\3c%s\\alpha&H%02X&}%s", 
                    char.center, line.middle, color, color, alf, char.text)
                io.write_line(l);
            end
        end
    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        if line.styleref.alignment == 8 or line.styleref.alignment == 2 then 
            sub(line, table.copy(line))
        end
    end
    io.progressbar(li / #lines)
end
