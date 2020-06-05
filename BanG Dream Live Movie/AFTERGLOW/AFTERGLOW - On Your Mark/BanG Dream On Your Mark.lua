script_name = "BanG Dream On Your Mark fx fix"
script_description = "On Your Mark fx fix"
script_version = "0.1"
script_author="Vardë"

function test1(subs, sel)
	for k, i in ipairs(sel) do
		line = subs[i]
		cleantag = line.text:gsub("{[^}]+}", "")

		if cleantag == "Avance les yeux rives devant toi." then
			line.text = line.text:gsub("v({[^}]+})e", "v".."%1".."é")
		end

		if cleantag == "Les reves en lesquels tu crois" then
			line.text = line.text:gsub("r({[^}]+})e", "r".."%1".."ê")
		end

		if cleantag == "Ressens l'instant ou le bonheur culmine !" then
			line.text = line.text:gsub("o({[^}]+})u", "o".."%1".."ù")
		end

		if cleantag == "C'est ca, la force d'une amitie" then
			line.text = line.text:gsub("c({[^}]+})a", "ç".."%1".."a")
			line.text = line.text:gsub("i({[^}]+})e", "i".."%1".."é")
		end

		if cleantag == "Que rien ne pourra ebranler !" then
			line.text = line.text:gsub("e({[^}]+})b", "é".."%1".."b")
		end

		if cleantag == "Parfois, certains mots prononces" then
			line.text = line.text:gsub("e({[^}]+})s", "é".."%1".."s")
		end

		if cleantag == "Et c'est dans ces moments, ecoute bien," then
			line.text = line.text:gsub("e({[^}]+})c", "é".."%1".."c")
		end

		if cleantag == "Qu'il faut lacher tes faiblesses au vent !" then
			line.text = line.text:gsub("a({[^}]+})c", "â".."%1".."c")
		end

		if cleantag == "Fais briller ta personnalite," then
			line.text = line.text:gsub("t({[^}]+})e", "t".."%1".."é")
		end

		if cleantag == "Bats-toi pour que demain reste inchange," then
			line.text = line.text:gsub("g({[^}]+})e", "g".."%1".."é")
		end

		if cleantag == "De mon cote, je veillerai a toutes vous proteger !" then
			line.text = line.text:gsub("c({[^}]+})o", "c".."%1".."ô")
			line.text = line.text:gsub("e({[^}]+})g", "é".."%1".."g")
			line.text = line.text:gsub("e({[^}]+}),", "é".."%1"..",")
			line.text = line.text:gsub(" ({[^}]+})a", " ".."%1".."à")
		end

		if cleantag == "A tes cotes !" then
			line.text = line.text:gsub("A({[^}]+}) ", "À".."%1".." ")
			line.text = line.text:gsub("c({[^}]+})o({[^}]+})t({[^}]+})e", "c".."%1".."ô".."%2".."t".."%3".."é")
		end

		if cleantag == "Get ready ? On relevera tous les defis !" then
			line.text = line.text:gsub("e({[^}]+})v", "è".."%1".."v")
			line.text = line.text:gsub("d({[^}]+})e", "d".."%1".."é")
		end

		if cleantag == "Ce jour-la, le ciel se colorait d'un tel eclat" then
			line.text = line.text:gsub("a({[^}]+}),", "à".."%1"..",")
			line.text = line.text:gsub("e({[^}]+})c", "é".."%1".."c")
		end

		if cleantag == "Et ca, on ne l'oubliera pas !" then
			line.text = line.text:gsub("c({[^}]+})a", "ç".."%1".."a")
		end

		if cleantag == "Never end ! Qui exaucera nos prieres !" then
			line.text = line.text:gsub("i({[^}]+})e", "i".."%1".."è")
		end

		if cleantag == "Les pieges du passe..." then
			line.text = line.text:gsub("i({[^}]+})e", "i".."%1".."è")
			line.text = line.text:gsub("s({[^}]+})e", "s".."%1".."é")
		end

		if cleantag == "Releve-toi... Pour que demain reste inchange." then
			line.text = line.text:gsub("l({[^}]+})e", "l".."%1".."è")
			line.text = line.text:gsub("g({[^}]+})e", "g".."%1".."é")
		end

		if cleantag == "Je serai la pour toutes nous proteger..." then
			line.text = line.text:gsub("l({[^}]+})a", "l".."%1".."à")
			line.text = line.text:gsub("e({[^}]+})g", "é".."%1".."g")
		end

		if cleantag == "Get ready ? Ta passion reveillera chaque nation !" then
			line.text = line.text:gsub("e({[^}]+})v", "é".."%1".."v")
		end

		if cleantag == "On ravira la Terre entiere !" then
			line.text = line.text:gsub("i({[^}]+})e", "i".."%1".."è")
		end

		if cleantag == "Get ready ? Fais exploser l'echo de ta chanson" then
			line.text = line.text:gsub("'({[^}]+})e", "'".."%1".."é")
		end

		if cleantag == "Saisis l'avenir a l'horizon !" then
			line.text = line.text:gsub(" ({[^}]+})a", " ".."%1".."à")
		end

		if cleantag == "On a compris ce que le ciel representait ce jour-la" then
			line.text = line.text:gsub("e({[^}]+})s", "é".."%1".."s")
			line.text = line.text:gsub("l({[^}]+})a", "l".."%1".."à")
		end

		if cleantag == "Avec moi, jamais il ne s'eteindra !" then
			line.text = line.text:gsub("e({[^}]+})t", "é".."%1".."t")
		end

		line.text = line.text:gsub("'", "’")

		subs[i] = line
	end
end

function test(subs, sel)
	test1(subs, sel)
end

aegisub.register_macro(script_name,script_description,test)