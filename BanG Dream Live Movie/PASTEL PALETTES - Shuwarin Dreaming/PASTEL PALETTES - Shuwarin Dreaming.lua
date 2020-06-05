#! by Vardë

ms_per_frame = 1000 / 23.976

logo_pasupare = "m -10 -6 b -7 -8 -3 -5 -2 -1 b -6 0 -11 -2 -10 -6 m 0 -3 b -4 -6 -3 -11 0 -12 b 3 -11 4 -6 0 -3 m 2 -1 b 3 -5 6 -8 10 -6 b 11 -2 8 0 2 -1 m 2 1 b 6 1 11 1 10 6 b 6 9 4 5 2 1 m 0 3 b 2 4 5 10 0 12 b -5 10 -2 4 0 3 m -2 1 b -4 5 -6 9 -10 6 b -11 3 -8 0 -2 1 "

bulle = {"m 0 50 b -65 50 -65 -50 0 -50 b 65 -50 65 50 0 50 l 0 42 b 55 42 55 -42 0 -42 b -5 -42 -11 -42 -12 -39 b -2 -15 -22 -5 -38 -11 b -46 24 -19 43 0 42 m 13 40 b 20 38 27 34 33 27 b 21 28 20 30 13 40 ",
        "m 0 50 b -65 50 -65 -50 0 -50 b 65 -50 65 50 0 50 ",
        "m -26 44 b 29 70 74 15 46 -34 b 72 38 6 61 -26 44 m -30 42 b -96 -13 -18 -93 37 -45 b -12 -83 -92 -24 -30 42 ",
        "m 11 51 b 10 50 23 47 23 50 b 25 53 10 54 11 51 m 9 52 b 8 51 3 52 4 54 b 5 56 10 54 9 52 m 53 12 b 55 17 53 21 50 22 b 48 22 52 12 53 12 m 37 -49 b 40 -52 43 -45 41 -45 b 38 -45 35 -48 37 -49 m 4 -62 b 4 -65 11 -65 12 -62 b 11 -59 5 -60 4 -62 m -17 -62 b -20 -63 -23 -60 -22 -58 b -20 -57 -17 -60 -17 -62 m -16 -62 b -16 -64 -14 -64 -13 -64 b -13 -62 -15 -61 -16 -62 m -53 20 b -51 18 -52 12 -55 14 b -59 15 -56 21 -53 20 m -56 13 b -54 11 -56 8 -58 9 b -59 10 -58 13 -56 13 m -52 21 b -51 20 -50 21 -50 23 b -52 22 -51 23 -52 21 m -39 37 b -38 37 -36 38 -38 39 b -39 39 -40 38 -39 37 "}


function lignes(l, posx, posy, text, tag_opt)
    if tag_opt == nil then
        tag_opt = ""
    end
    l.layer = 5
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord0\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 4
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\1a&HFE&%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 3
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad1\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 2
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad2\\3a&HFF&\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 1
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad3\\3a&HFF&\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 0
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad4\\3a&HFF&\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
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
    l.effect = "PASUPARE fx"
    for si, syl in ipairs(line.syls) do
        if syl.text ~= "" then
            l.start_time = line.start_time - (math.round(ms_per_frame*12)) + (si-1)*ms_per_frame
            l.end_time = l.start_time + (math.round(ms_per_frame*16))

            curve = {{0, math.random(80,120)}, {math.random(-100,100), math.random(50,100)}, {math.random(-100,100), math.random(0,50)}, {0, 0}}

            coef = math.max(syl.width,syl.height)/100
            bulle_new = {}
            for i=1, #bulle do
                bulle_new[i] = shape.filter(bulle[i], function(x, y) return x*coef*1.2, y*coef*1.2 end)
            end

            for s, e, i, n in utils.frames(l.start_time, l.end_time, ms_per_frame) do
                l.start_time = s
                l.end_time = e

                if i < 6 then
                    taille = utils.interpolate(i/5, 0, 100)
                else
                    taille = "100"
                end
                
                taille = string.format("\\fscx%s\\fscy%s", taille, taille)
                point = math.bezier(i/n, curve)

                lignes(l, syl.center + point[1], syl.middle + point[2], syl.text, taille)


                l.layer = 6
                l.text = string.format(
                                "{\\an7\\pos(%.6f,%.6f)\\blur5\\c&HFFFFFF&\\bord0\\p1%s}%s",
                                syl.center + point[1], syl.middle + point[2], taille, bulle_new[1])
                io.write_line(l);
                l.layer = 6
                l.text = string.format(
                                "{\\an7\\pos(%.6f,%.6f)\\blur5\\c&HFFFFFF&\\1a&HB8&\\bord0\\p1%s}%s",
                                syl.center + point[1], syl.middle + point[2], taille, bulle_new[2])
                io.write_line(l);

            end

            l.start_time = l.end_time
            l.end_time = line.end_time - (math.round(ms_per_frame*4))
            lignes(l, syl.center, syl.middle, syl.text)

            l.start_time = l.start_time
            l.end_time = l.start_time + (math.round(ms_per_frame*6))

            movex = syl.center + math.random(-100,100)
            movey = syl.middle + math.random(-100,-50)

            l.layer = 6
            l.text = string.format(
                            "{\\an7\\move(%.6f,%.6f,%.6f,%.6f)\\blur5\\c&HFFFFFF&\\bord0\\p1}%s",
                            syl.center, syl.middle, movex, movey, bulle_new[1])
            io.write_line(l);
            l.layer = 6
            l.text = string.format(
                            "{\\an7\\move(%.6f,%.6f,%.6f,%.6f)\\blur5\\c&HFFFFFF&\\1a&HB8&\\bord0\\p1}%s",
                            syl.center, syl.middle, movex, movey, bulle_new[2])
            io.write_line(l);

            l.start_time = l.end_time
            l.end_time = l.start_time + ms_per_frame
            l.layer = 6
            l.text = string.format(
                            "{\\an7\\pos(%.6f,%.6f)\\blur5\\c&HFFFFFF&\\bord0\\p1}%s",
                            movex, movey, bulle_new[3])
            io.write_line(l);

            l.start_time = l.end_time
            l.end_time = l.start_time + ms_per_frame
            l.layer = 6
            l.text = string.format(
                            "{\\an7\\pos(%.6f,%.6f)\\blur5\\c&HFFFFFF&\\bord0\\p1}%s",
                            movex, movey, bulle_new[4])
            io.write_line(l);
        end
    end

    for wo, word in ipairs(line.words) do
        l.start_time = line.end_time - (math.round(ms_per_frame*4))
        l.end_time = line.end_time
        lignes(l, word.center, word.middle, word.text, "\\t(\\fscx0\\alpha&HFF&)")
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
