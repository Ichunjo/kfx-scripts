script_name = "BanG Dream Scarlet FX fix"
script_description = "Scarlet FX fix"
script_version = "0.1"
script_author="Vardë"

function test1(subs, sel)
	for k, i in ipairs(sel) do
		line = subs[i]
		cleantag = line.text:gsub("{[^}]+}", "")

		if cleantag == "Je me sens connectee" then
			line.text = line.text:gsub("e({[^}]+})e", "é".."%1".."e")
		end

		if cleantag == "Comme si ce lien etait inne..." then
			line.text = line.text:gsub("e({[^}]+})t", "é".."%1".."t")
			line.text = line.text:gsub("n({[^}]+})e", "n".."%1".."é")
		end

		if cleantag == "Pas une fois, je n'ai ete esseulee..." then
			line.text = line.text:gsub("e({[^}]+})t({[^}]+})e", "é".."%1".."t".."%2".."é")
			line.text = line.text:gsub("e({[^}]+})e", "é".."%1".."e")
		end

		if cleantag == "Que tout etait peut-etre ecrit." then
			line.text = line.text:gsub("e({[^}]+})t({[^}]+})a", "é".."%1".."t".."%2".."a")
			line.text = line.text:gsub("-({[^}]+})e", "-".."%1".."ê")
			line.text = line.text:gsub("e({[^}]+})c", "é".."%1".."c")
		end
		
		if cleantag == "Cette pensee ne m'a jamais quittee" then
			line.text = line.text:gsub("e({[^}]+})e", "é".."%1".."e")
		end

		if cleantag == "Tout ce que je desire voir, c'est ton sourire..." then
			line.text = line.text:gsub("e({[^}]+})s({[^}]+})i", "é".."%1".."s".."%2".."i")
		end

		if cleantag == "Pour ca, j'enfile ma tenue de combat," then
			line.text = line.text:gsub("c({[^}]+})a", "ç".."%1".."a")
		end

		if cleantag == "En observant les autres classes defiler a cote," then
			line.text = line.text:gsub("e({[^}]+})f", "é".."%1".."f")
			line.text = line.text:gsub("a({[^}]+}) ", "à".."%1".." ")
			line.text = line.text:gsub("o({[^}]+})t", "ô".."%1".."t")
			line.text = line.text:gsub("e({[^}]+}),", "é".."%1"..",")
		end


		if cleantag == "Il nous garde soudees chaque instant," then
			line.text = line.text:gsub("e({[^}]+})e", "é".."%1".."e")
		end

		if cleantag == "A tout moment, n'importe quand !" then
			line.text = line.text:gsub("A({[^}]+}) ", "À".."%1".." ")
		end

		line.text = line.text:gsub("'", "’")

		subs[i] = line
	end
end

function test(subs, sel)
	test1(subs, sel)
end

aegisub.register_macro(script_name,script_description,test)