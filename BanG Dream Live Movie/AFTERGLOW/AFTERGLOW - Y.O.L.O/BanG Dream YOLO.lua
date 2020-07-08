script_name = "BanG Dream YOLO FX fix"
script_description = "YOLO FX fix"
script_version = "0.1"
script_author="Vardë"

function test1(subs, sel)
	for k, i in ipairs(sel) do
		line = subs[i]
		cleantag = line.text:gsub("{[^}]+}", "")

		if cleantag == "Je n'avais jamais pense au monde qui nous entourait," then
			line.text = line.text:gsub("s({[^}]+})e", "s".."%1".."é")
		end

		if cleantag == "Son etendue m'a montre qu'on etait insignifiants," then
			line.text = line.text:gsub("e({[^}]+})t", "é".."%1".."t")
			line.text = line.text:gsub("r({[^}]+})e", "r".."%1".."é")
		end

		if cleantag == "Voila pourquoi" then
			line.text = line.text:gsub("l({[^}]+})a", "l".."%1".."à")
		end

		if cleantag == "Cette voute dont l'éclat est tien" then
			line.text = line.text:gsub("o({[^}]+})u", "o".."%1".."û")
		end

		if cleantag == "M'a appris a suivre mon instinct" then
			line.text = line.text:gsub(" ({[^}]+})a({[^}]+}) ", " ".."%1".."à".."%2".." ")
		end

		if cleantag == "Qu'importe la largeur du fosse" then
			line.text = line.text:gsub("s({[^}]+})e", "s".."%1".."é")
		end

		if cleantag == "Aucun tresor ne pourra jamais acheter" then
			line.text = line.text:gsub("r({[^}]+})e", "r".."%1".."é")
		end

		if cleantag == "L'instant que je vis a vos cotes." then
			line.text = line.text:gsub(" ({[^}]+})a({[^}]+}) ", " ".."%1".."à".."%2".." ")
			line.text = line.text:gsub("c({[^}]+})o", "c".."%1".."ô")
			line.text = line.text:gsub("t({[^}]+})e", "t".."%1".."é")
		end

		if cleantag == "Laisse ta personnalite rayonner," then
			line.text = line.text:gsub("t({[^}]+})e", "t".."%1".."é")
		end

		if cleantag == "Inutile d'avoir peur, tu seras a la hauteur !" then
			line.text = line.text:gsub(" ({[^}]+})a({[^}]+}) ", " ".."%1".."à".."%2".." ")
		end

		if cleantag == "Il faut l'avoir, partons chercher la premiere etoile du soir !" then
			line.text = line.text:gsub("e({[^}]+})t", "é".."%1".."t")
			line.text = line.text:gsub("i({[^}]+})e", "i".."%1".."è")
		end

		line.text = line.text:gsub("'", "’")

		subs[i] = line
	end
end

function test(subs, sel)
	test1(subs, sel)
end

aegisub.register_macro(script_name,script_description,test)