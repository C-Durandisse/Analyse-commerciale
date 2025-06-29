-- Calculer les variables suivantes : prix_unitaire, cout_achat, tx_marge

SELECT
    ID_commande,
    montant,
    profit,
    quantite,
    categorie,
    sous_categorie,
    mode_paiement,
    date_commande,
    nom_client,
    etat,
    ville,
    annee_mois,
    -- Calcul du prix unitaire avec 2 chiffres après la virgule
    CASE
        WHEN quantite != 0 THEN ROUND(montant / quantite, 2)
        ELSE NULL
    END AS prix_unitaire,
    -- Calcul du coût d'achat avec 2 chiffres après la virgule
    CASE
        WHEN quantite != 0 THEN ROUND((montant - profit) / quantite, 2)
        ELSE NULL
    END AS cout_achat,
    -- Calcul du taux de marge avec 2 chiffres après la virgule
    CASE
        WHEN montant != 0 THEN ROUND((profit / montant)*100, 2)
        ELSE NULL
    END AS tx_marge,
    -- Nouvelle colonne : Trimestre et Année
    CONCAT(
        'T',
        CAST(EXTRACT(QUARTER FROM PARSE_DATE('%Y-%m', annee_mois)) AS STRING),
        '-',
        FORMAT_DATE('%Y', PARSE_DATE('%Y-%m', annee_mois))
    ) AS trimestre_annee
FROM
    `caduran2025.Projet2.sales`


-- Calculer la vente totale, le profit total et la quantité totale vendue par catégorie de produit

select
    categorie,
    sum(montant) as total_vente,
    sum(profit) as profit_total,
    sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by categorie
order by profit_total desc

-- Calculer la vente totale, le profit total et la quantité totale vendue par sous-catégorie de produit

select
    sous_categorie,
    sum(montant) as vente_totale,
    sum(profit) as profit_total,
    sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by sous_categorie
order by profit_total desc


-- Calculer la vente totale, le profit total et la quantité totale vendue par état et par catégorie de produit
select
  etat,
  categorie,
  sum(montant) as vente_totale,
  sum(profit) as profit_total,
  sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by etat, categorie
order by profit_total desc

-- Calculer la vente totale, le profit total et la quantité totale vendue par état et par sous_catégorie de produit
select
  etat,
  sous_categorie,
  sum(montant) as vente_totale,
  sum(profit) as profit_total,
  sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by etat, sous_categorie
order by profit_total desc

-- Calculer la vente totale, le profit total et la quantité totale vendue par mois de chaque année
SELECT
    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y-%m', annee_mois)) AS mois,
    SUM(montant) AS vente_totale,
    SUM(profit) AS profit_total,
    SUM(quantite) AS quantite_totale_vendue
FROM
    `caduran2025.Projet2.sales_1`
GROUP BY
    mois
ORDER BY
    mois;

-- Calculer la vente totale, le profit total et la quantité totale vendue par Etat
select
  etat,
   sum(montant) as vente_totale,
  sum(profit) as profit_total,
  sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by etat
order by profit_total desc

-- Calculer la vente totale, le profit total et la quantité totale vendue par Ville
select
  ville,
   sum(montant) as vente_totale,
  sum(profit) as profit_total,
  sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by ville
order by profit_total desc

--Calculer la vente totale, le profit total et la quantité totale vendue par Ville et par catégorie
select
  ville,
  categorie,
  sum(montant) as vente_totale,
  sum(profit) as profit_total,
  sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by ville, categorie
order by profit_total desc


--Calculer la vente totale, le profit total et la quantité totale vendue par Ville et par sous_catégorie
select
  ville,
  sous_categorie,
  sum(montant) as vente_totale,
  sum(profit) as profit_total,
  sum(quantite) as quantite_totale_vendue
from `caduran2025.Projet2.sales_1`
group by ville, sous_categorie
order by profit_total desc

--Calculer la vente totale, le profit total et la quantité totale vendue par Etat pour le 1er trimestre 2023
SELECT
    trimestre_annee, etat,
    SUM(montant) AS vente_totale,
    SUM(profit) AS profit_total,
    SUM(quantite) AS quantite_totale_vendue
FROM
    `caduran2025.Projet2.sales_2`
where trimestre_annee = "T1-2023"
GROUP BY
    trimestre_annee, etat

-- Calculer les CA et profit avec la méthode chronologique
SELECT
    date_commande, etat, ville, categorie, sous_categorie, mode_paiement,
    SUM(montant) AS CA,
    SUM(profit) AS profit_total,
    SUM(quantite) AS quantite_totale_vendue
FROM
    `caduran2025.Projet2.sales_2`
group by date_commande, etat, ville, categorie, sous_categorie, mode_paiement