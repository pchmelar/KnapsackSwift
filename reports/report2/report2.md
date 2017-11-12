# KnapsackSwift - 2nd report

- Knapsack problem solver written in Swift 4.0
- MI-PAA semestral project @ CTU FIT university
- Below is the report for the 2nd part (in Czech language)
- All measurements was made on MacBook Pro (13-inch Mid 2017)   
(CPU: Intel Core i5-7360U, RAM: 16 GB, OS: macOS High Sierra)
- Author: Petr Chmelar
- Date: 11/11/2017

## Úloha
- Cílem úlohy je implementace a analýza řešení problému batohu metodami větví a hranic, dynamickým programováním a aproximativním algoritmem FPTAS.

## Popis řešení

### Metoda větví a hranic  
- Metoda solveBranchAndBound vychází z rekurzivní metody solveBruteForce (viz report1). Má navíc čtvrtý vstupní parametr reprezentující nejlepší zatím dosažené řešení. Při větvení rekurze je pak vždy provedena kontrola, zda u nově vytvářené větve je potenciál pro nalezení lepšího řešení než nejlepšího zatím dosaženého. V negativním případě je tato větěv odříznuta. Metoda větví a hranic výpočet často značně urychlí, ale asymptotická složitost zůstavá 2^n.

### Metoda dynamického programování
- Tato metoda může využívat dekompozici problému podle ceny, nebo podle váhy. Vzhledem k následné implementaci FPTAS algoritmu jsem zvolil dekompozici podle ceny. Řešení podproblémů jsou v tomto případě uložené v tabulce o rozměrech n (počet věcí) x maxValue (suma cen všech věcí) - asymptotická složitost je n \* maxValue. 
- Algoritmus začíná ve sloupci 0 a postupně plní tabulku doprava dle následujících pravidel:
```swift
table[0][0] = 0
table[0][j] = Int.max ... pro všechna j > 0
table[i][j] = min(table[i-1][j], table[i-1][j-items[i-1].value] + items[i-1].weight) ... pro všechna i > 0
```
- Výsledné řešení poté nalezneme v posledním sloupci, jeho hodnota je menší než maxWeight a má maximální index v rámci sloupce.

### Aproximativní algoritmus FPTAS
- Zde využijeme metody dynamického programování nad zjednodušeným modelem. Zjednodušení dosáhneme vydělením cen konstantou, čímž se sníží hodnota maxValue (suma cen všech věcí) a tedy i složitost metody dynamického programování.
- Pro zvolenou maximální relativní chybu epsilon má konstanta hodnotu:
```swift
coeff = (eps * maxValue) / n
```
- Ceny modifikujeme vydělením získanou konstantou:
```swift
item.value = floor(item.value / coeff)
```
- Pro spočítání relativní chyby algoritmu jsou potom použité původní ceny řešení, které vzniklo z upravených cen.

## Naměřené výsledky

## Grafy

## Závěr
