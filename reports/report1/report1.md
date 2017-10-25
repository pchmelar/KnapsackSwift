# KnapsackSwift - 1st report

- Knapsack problem solver written in Swift
- MI-PAA semestral project @ CTU FIT university
- Author: Petr Chmelar
- Date: 25/10/2017

## Úloha
- Cílem úlohy je implementace a analýza řešení problému batohu hrubou silou a heuristikou.

## Varianty řešení
- Při řešení hrubou silou je nutné vyzkoušet všechny možnosti naplnění batohu.   
- Za heuristiku je možné zvolit například poměr ceny a váhy.

## Popis řešení
- Instance problému je reprezentována třídou ProblemInstance. Každá instance má definované metody solveBruteForce a solveHeuristic, které vyřeší instanci zvolenou metodou.   
- Metoda solveBruteForce je implementovaná rekurzivně a má tři vstupní parametry: velikost problému, aktuální váhu batohu a aktuální hodnotu batohu. Rekurze se vždy větví na další dva případy, dle toho zda přidáme nebo nepřidáme aktuální předmět do batohu.
- Metoda solveHeuristic zohledňuje poměr ceny a váhy jednotlivých předmětů. Iterativně prochází předměty, které jsou seřazené sestupně dle poměru ceny a váhy. Pokud je součet aktuální hmotnosti batohu a váhy aktuálního předmětu menší nebo rovný kapacitě batohu, tak objekt přidá do batohu.
