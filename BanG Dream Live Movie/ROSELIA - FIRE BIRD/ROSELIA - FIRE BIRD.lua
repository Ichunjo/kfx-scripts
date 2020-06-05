-- Bleu 
color_top = "&HE0B06B&"
color_mid = "&H8C2A2B&"
color_bot = "&H6B004F&"

-- Rouge
color_top2 = "&HC960ED&"
color_mid2 = "&H270248&"
color_bot2 = "&H1B025B&"

ms_per_frame = 1000 / 23.976
plume =
    "m -170 326 b -194 241 -144 197 -134 183 b -127 167 -123 151 -122 134 b -134 109 -141 99 -168 97 b -179 97 -188 102 -189 115 b -188 127 -183 126 -175 125 b -188 132 -191 122 -191 115 b -188 97 -178 95 -168 95 b -140 94 -127 118 -120 132 b -119 80 -145 41 -163 37 b -173 37 -183 42 -185 55 b -186 59 -188 62 -187 67 b -181 68 -177 64 -177 56 l -178 55 l -176 53 b -174 55 -172 56 -173 59 b -176 67 -179 71 -187 74 b -199 61 -181 30 -162 31 b -128 47 -122 81 -115 112 b -107 52 -137 9 -201 -1 b -160 -1 -119 25 -106 82 b -85 44 -120 2 -142 -4 b -128 -7 -104 20 -94 44 b -98 -3 -126 -20 -143 -30 b -117 -24 -87 13 -88 66 b -85 -5 -149 -84 -149 -77 b -154 -75 -153 -67 -145 -64 b -144 -63 -142 -61 -143 -60 b -145 -57 -147 -58 -149 -58 b -157 -60 -159 -64 -157 -70 b -157 -77 -153 -80 -150 -81 b -146 -81 -144 -80 -141 -76 b -111 -43 -83 14 -75 72 b -75 24 -96 -19 -105 -58 b -117 -105 -105 -120 -91 -134 b -106 -103 -99 -87 -79 -60 b -90 -90 -87 -122 -82 -152 b -77 -135 -77 -115 -66 -100 b -82 -155 -76 -205 -78 -258 b -85 -273 -84 -290 -86 -305 b -84 -359 -59 -397 -43 -441 b -27 -499 -33 -538 -48 -540 b -54 -540 -55 -536 -57 -532 b -60 -544 -52 -544 -48 -545 b -30 -542 -20 -530 -21 -480 b 23 -566 -31 -639 -49 -644 b -53 -643 -56 -640 -52 -631 b -51 -625 -44 -622 -41 -618 b -41 -617 -40 -616 -41 -615 b -43 -614 -46 -616 -49 -616 b -61 -626 -62 -641 -59 -648 b -51 -653 -45 -649 -38 -646 b -16 -622 12 -603 26 -478 b 34 -506 24 -525 19 -529 b 20 -533 41 -517 41 -487 b 46 -477 28 -456 37 -435 b 36 -448 41 -452 43 -460 b 46 -459 44 -450 45 -443 b 51 -435 56 -424 63 -420 b 62 -442 58 -449 53 -451 b 76 -443 83 -389 102 -342 b 105 -351 103 -360 102 -369 b 111 -353 123 -321 118 -282 b 118 -267 113 -253 111 -239 b 112 -243 114 -247 115 -251 b 122 -224 98 -172 86 -133 b 159 -236 134 -340 106 -409 b 89 -438 73 -450 56 -470 b 45 -493 49 -506 57 -509 b 67 -511 70 -506 73 -498 b 73 -496 74 -494 71 -493 b 65 -495 64 -500 60 -504 b 50 -497 53 -484 64 -469 b 110 -427 135 -375 137 -318 b 143 -273 138 -222 122 -171 b 142 -194 161 -209 181 -211 b 198 -207 186 -182 185 -178 b 173 -154 161 -126 135 -125 b 130 -144 144 -158 150 -161 b 152 -164 155 -163 157 -161 b 155 -153 148 -149 142 -145 b 140 -141 139 -138 139 -134 b 163 -139 167 -161 178 -176 b 183 -187 186 -199 179 -206 b 150 -199 135 -169 115 -151 b 107 -135 98 -118 90 -102 b 92 -83 87 -67 77 -51 b 77 -38 77 -26 68 -16 b 71 -3 63 21 47 37 b 42 49 37 61 27 72 b 24 78 19 85 16 89 b 8 99 0 109 -8 118 b 35 83 97 22 93 -8 b 89 -8 86 -8 82 -2 b 80 1 79 4 80 7 b 80 8 80 10 80 11 b 75 12 74 1 79 -4 b 83 -14 90 -15 96 -16 b 102 -13 101 0 94 12 b 74 39 81 49 14 105 b -25 141 -95 186 -121 182 b -76 189 -27 158 -9 142 b -30 164 -55 179 -91 185 b -37 179 11 163 47 121 b 8 179 -69 194 -124 185 b -155 216 -180 259 -166 325 "

-- euclidean distance between two points
function eucl_dist(x1, x2, y1, y2)
    return math.sqrt(math.abs(x1 - x2) ^ 2 + math.abs(y1 - y2) ^ 2)
end

-- degree to radian
function deg_to_rad(deg) return (math.pi / 180) * deg end

function vardeColorSwap(timing, colorBase, startL, type)
    text = string.format("\\%dc%s", type, colorBase)
    if #timing > 0 then
        for i = 1, #timing do
            if timing[i][1] - 20 - startL == 0 then
                startL = startL + 1
            end
            text = text ..
                       string.format("\\t(%d,%d,\\%dc%s)",
                                     timing[i][1] - 20 - startL,
                                     timing[i][2] - 20 - startL, type,
                                     timing[i][3])
        end
    end
    return text
end

function char_counter(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do compteur = compteur + 1 end
    return compteur
end

function rotate_shape_rand(dessin, rot)
    dessin = shape.filter(dessin, function(x, y)
        local mx = x + 0
        local my = y + 0
        -- set zero-point location
        local zpx = 0
        local zpy = 0
        -- distance to zero-point
        local zpd = eucl_dist(zpx, mx, zpy, my)
        -- rotation angle
        --   local torot = deg_to_rad((i/n)*360*(zpd/400)^0.5)
        local torot = deg_to_rad(rot)
        -- current angle
        local relx = x - zpx
        local rely = y - zpy
        local curot = math.atan2(rely, relx)

        -- new coordinates
        rx = zpd * math.cos(curot + torot) + 0
        ry = zpd * math.sin(curot + torot) + 0

        return rx, ry
    end)
    return dessin
end

t_fad_rom = {5, 7, 14, 18, 20, 22, 37, 60}
t_fad_sub = {}
for i = 1, #t_fad_rom do table.insert(t_fad_sub, t_fad_rom[i] + 63) end

function roumaji(l, line)
    l.effect = "Roselia fx"

    i = 1
    while i <= #t_fad_rom do
        if line.i == t_fad_rom[i] then
            fad = "\\fad(120,0)"
            break
        else
            fad = "\\fad(120,160)"
        end
        i = i + 1
    end

    if line.i > 54 then
        plume_color =
            "\\t(0,1500,\\c&HE0B06B&\\c&H8C2A2B&),\\t(1500,3000,\\c&H8C2A2B&\\c&H6B004F&)"
    else
        plume_color = "\\c&HFFFFFF&"
    end

    if line.i ~= 54 then
        for ci, char in ipairs(line.chars) do
            l.start_time = line.start_time
            l.end_time = line.end_time
            if char.i % 2 == 0 then
                for s, e, i, n in utils.frames(l.start_time, l.end_time,
                                               ms_per_frame * math.random(36,60)) do
                    l.start_time = s
                    l.end_time = s + math.random(2000, 4000)
                    if l.end_time > line.end_time then
                        l.end_time = line.end_time
                    end

                    -- print(char.text)
                    l.layer = 0
                    l.text = string.format(
                                 "{\\an7\\move(%.3f,%.3f,%.3f,%.3f,0,%.3f)\\fscx5\\fscy5\\frz%s\\frx%s\\fry%s\\t(\\frz%s\\frx%s\\fry%s)%s\\blur3\\p1\\fad(%.3f,%.3f)}%s",
                                 char.left + math.random(-50, 50),
                                 char.top - 50 + math.random(-50, 50),
                                 char.left + math.random(-50, 50),
                                 char.top + 1000 + math.random(-50, 50),
                                 math.random(15000, 25000), math.random(0, 360),
                                 math.random(0, 360), math.random(0, 360),
                                 math.random(0, 360), math.random(0, 360),
                                 math.random(0, 360), plume_color,
                                 ms_per_frame * math.random(3,9), ms_per_frame * math.random(3,9), plume)
                    io.write_line(l);
                end
            end
        end
    end

    if line.i == 55 then
        for ci, char in ipairs(line.chars) do
            if char.i % 3 == 0 then
                l.start_time = line.start_time + ms_per_frame * 2
                l.end_time = line.end_time
                -- Vers le haut
                l.layer = 0
                l.text = string.format(
                             "{\\an7\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\fscx5\\fscy5\\c&H6B004F&\\org(%.3f,%.3f))\\blur10\\t(0,%.3f,0.5,\\frx%s\\fad(%.3f,%.3f)\\p1}%s",
                             char.center + math.random(-5, 5),
                             char.middle + math.random(-5, 5),
                             char.center + math.random(-5, 5),
                             char.middle + math.random(-100, -50),
                             ms_per_frame * 1, ms_per_frame * 5,
                             char.center + math.random(-50, 50),
                             char.middle + math.random(100, 300), line.duration,
                             math.random(-10, -5), ms_per_frame * 1,
                             ms_per_frame * 6,
                             rotate_shape_rand(plume, math.random(0, 360)))
                io.write_line(l);
                -- Vers le bas
                l.layer = 0
                l.text = string.format(
                             "{\\an7\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\fscx5\\fscy5\\c&H6B004F&\\org(%.3f,%.3f)\\blur10\\t(0,%.3f,0.5,\\frx%s)\\fad(%.3f,%.3f)\\p1}%s",
                             char.center + math.random(-5, 5),
                             char.middle + math.random(-5, 5),
                             char.center + math.random(-5, 5),
                             char.middle + math.random(50, 100),
                             ms_per_frame * 1, ms_per_frame * 5,
                             char.center + math.random(-50, 50),
                             char.middle + math.random(-300, -100),
                             line.duration, math.random(5, 10),
                             ms_per_frame * 1, ms_per_frame * 6,
                             rotate_shape_rand(plume, math.random(0, 360)))
                io.write_line(l);
            end

            if char.i == 1 then
                -- Vers la gauche
                l.layer = 0
                l.text = string.format(
                             "{\\an7\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\fscx5\\fscy5\\c&H6B004F&\\org(%.3f,%.3f))\\blur10\\t(0,%.3f,0.5,\\fry%s\\fad(%.3f,%.3f)\\p1}%s",
                             char.center + math.random(-5, 5),
                             char.middle + math.random(-5, 5),
                             char.center + math.random(-100, -50),
                             char.middle + math.random(-5, 5), ms_per_frame * 1,
                             ms_per_frame * 5,
                             char.center + math.random(100, 300),
                             char.middle + math.random(-50, 50), line.duration,
                             math.random(5, 10), ms_per_frame * 1,
                             ms_per_frame * 6,
                             rotate_shape_rand(plume, math.random(0, 360)))
                io.write_line(l);
            end

            if char.i == char_counter(line) then
                -- Vers la droite
                l.layer = 0
                l.text = string.format(
                             "{\\an7\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)\\fscx5\\fscy5\\c&H6B004F&\\org(%.3f,%.3f))\\blur10\\t(0,%.3f,0.5,\\fry%s\\fad(%.3f,%.3f)\\p1}%s",
                             char.center + math.random(-5, 5),
                             char.middle + math.random(-5, 5),
                             char.center + math.random(50, 100),
                             char.middle + math.random(-5, 5), ms_per_frame * 1,
                             ms_per_frame * 5,
                             char.center + math.random(-300, -100),
                             char.middle + math.random(-50, 50), line.duration,
                             math.random(-10, -5), ms_per_frame * 1,
                             ms_per_frame * 6,
                             rotate_shape_rand(plume, math.random(0, 360)))
                io.write_line(l);
            end
        end
    end

    l.start_time = line.start_time
    l.end_time = line.end_time

    l.layer = 1
    l.text = string.format(
                 "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                 line.center, line.top, fad, line.text)
    io.write_line(l);

    l.layer = 2
    l.text = string.format("{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\blur5%s}%s",
                           line.center, line.top, fad, line.text)
    io.write_line(l);

    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color_rouge = utils.interpolate(j / line.ascent, color_top2, color_mid2)

        if line.i == 8 then
            t = {{1054, 1345, '&H000000&'}, {1387, 1721, color_rouge}}
            base = color_bleu
        elseif line.i == 9 then
            t = {
                {0, 107, color_bleu}, {190, 357, color_rouge},
                {357, 649, color_bleu}
            }
            base = color_rouge
        elseif line.i == 10 then
            t = {
                {0, 110, color_rouge}, {110, 319, color_bleu},
                {402, 569, color_rouge}
            }
            base = color_bleu
        else
            t = {}
            base = color_bleu
        end

        color = vardeColorSwap(t, base, 0, 1)

        l.layer = 3
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s",
                     line.center, line.top, color, line.left - 10, math.floor(
                         line.top + line.height - line.descent - line.ascent +
                             (j - 1)), line.right + 10, math.floor(
                         line.top + line.height - line.descent - line.ascent + j),
                     fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 5 do
        color_bleu = utils.interpolate(j / (line.descent + 5), color_mid,
                                       color_bot)
        color_rouge = utils.interpolate(j / (line.descent + 5), color_mid2,
                                        color_bot2)

        if line.i == 8 then
            t = {{1054, 1345, '&H000000&'}, {1387, 1721, color_rouge}}
            base = color_bleu
        elseif line.i == 9 then
            t = {
                {0, 107, color_bleu}, {190, 357, color_rouge},
                {357, 649, color_bleu}
            }
            base = color_rouge
        elseif line.i == 10 then
            t = {
                {0, 110, color_rouge}, {110, 319, color_bleu},
                {402, 569, color_rouge}
            }
            base = color_bleu
        else
            t = {}
            base = color_bleu
        end

        color = vardeColorSwap(t, base, 0, 1)

        l.layer = 3
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s",
                     line.center, line.top, color, line.left - 10, math.floor(
                         line.top + line.height - line.descent + (j - 1)),
                     line.right + 10,
                     math.floor(line.top + line.height - line.descent + j), fad,
                     line.text)
        io.write_line(l);
    end
end

function sub(l, line)
    l.effect = "Roselia fx"

    i = 1
    while i <= #t_fad_sub do
        if line.i == t_fad_sub[i] then
            fad = "\\fad(120,0)"
            break
        else
            fad = "\\fad(120,160)"
        end
        i = i + 1
    end

    l.start_time = line.start_time
    l.end_time = line.end_time

    l.layer = 1
    l.text = string.format(
                 "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                 line.center, line.bottom, fad, line.text)
    io.write_line(l);

    l.layer = 2
    l.text = string.format("{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\blur5%s}%s",
                           line.center, line.bottom, fad, line.text)
    io.write_line(l);

    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color_rouge = utils.interpolate(j / line.ascent, color_mid2, color_bot2)

        if line.i == 8 + 63 then
            t = {{1054, 1345, '&H000000&'}, {1387, 1721, color_rouge}}
            base = color_bleu
        elseif line.i == 9 + 63 then
            t = {
                {0, 107, color_bleu}, {190, 357, color_rouge},
                {357, 649, color_bleu}
            }
            base = color_rouge
        elseif line.i == 10 + 63 then
            t = {
                {0, 110, color_rouge}, {110, 319, color_bleu},
                {402, 569, color_rouge}
            }
            base = color_bleu
        else
            t = {}
            base = color_bleu
        end

        color = vardeColorSwap(t, base, 0, 1)

        l.layer = 3
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s",
                     line.center, line.bottom, color, line.left - 10,
                     math.floor(line.top + line.height - line.descent -
                                    line.ascent + (j - 1)), line.right + 10,
                     math.floor(line.top + line.height - line.descent -
                                    line.ascent + j), fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 5 do
        color_bleu = utils.interpolate(j / (line.descent + 5), color_mid,
                                       color_bot)
        color_rouge = utils.interpolate(j / (line.descent + 5), color_mid2,
                                        color_bot2)

        if line.i == 8 + 63 then
            t = {{1054, 1345, '&H000000&'}, {1387, 1721, color_rouge}}
            base = color_bleu
        elseif line.i == 9 + 63 then
            t = {
                {0, 107, color_bleu}, {190, 357, color_rouge},
                {357, 649, color_bleu}
            }
            base = color_rouge
        elseif line.i == 10 + 63 then
            t = {
                {0, 110, color_rouge}, {110, 319, color_bleu},
                {402, 569, color_rouge}
            }
            base = color_bleu
        else
            t = {}
            base = color_bleu
        end

        color = vardeColorSwap(t, base, 0, 1)

        l.layer = 3
        l.text = string.format(
                     "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s",
                     line.center, line.bottom, color, line.left - 10,
                     math.floor(line.top + line.height - line.descent + (j - 1)),
                     line.right + 10,
                     math.floor(line.top + line.height - line.descent + j), fad,
                     line.text)
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
