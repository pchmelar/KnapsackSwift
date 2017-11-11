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

## Naměřené výsledky

## Grafy

## Závěr
