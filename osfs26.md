Open science FS26
================
Marcel Miché
2026-02-24

- [Misstrauen](#misstrauen)
  - [Was ist das hier?](#was-ist-das-hier)
    - [Transparenz](#transparenz)
    - [Orientierung, Kompass](#orientierung-kompass)
    - [Checklisten, Regelsammlungen](#checklisten-regelsammlungen)
    - [emmeans](#emmeans)
    - [marginaleffects](#marginaleffects)
  - [Estimated marginal means](#estimated-marginal-means)
- [Literaturverzeichnis](#literaturverzeichnis)

# Misstrauen

Gebe niemals die Kontrolle ab, an von anderen Menschen oder von dir
selbst aufgestellte Regeln. Das heisst, dass Misstrauen wesentlich
besser ist als Vertrauen, im Rahmen von Regelsammlungen, z.B.
Checklisten, weil **Misstrauen** Wachsamkeit fördert (und fordert),
während Vertrauen erschreckend häufig Unachtsamkeit fördert (nicht
zwingend fordert).

Nachdem dies nun geschrieben ist, sei betont, dass Checklisten und
Regelsammlungen dann sehr gut sein können, wenn man mit ihrer Hilfe ein
bewusstes sowie gut begründetes Ziel verfolgt, das von einer gesunden
Portion Misstrauen begleitet wird.

## Was ist das hier?

Eine während des FS26 produzierte Sammlung von hoffentlich relevanten
Hinweisen als auch konkreten Anleitungen, zu Umsetzungsmöglichkeiten von
[open
science](https://poldrack.github.io/psych-open-science-guide/README.html).

### Transparenz

Transparenz ist **das** Synonym schlechthin für open science. Beginnen
wir also mit dem Dokumenttyp dieses Dokuments:
[rmarkdown](https://rmarkdown.rstudio.com/index.html) (bzw. [weitere
rmarkdown Quelle](https://yihui.org/rmarkdown/)). Wie bei jedem
Dokumenttyp, stellt sich auch hier die Frage nach dem Ziel, d.h. was
soll in welcher Form und auf welchem Weg an wen gelangen?

**Was?** Informationen unterschiedlicher Art, z.B. Weblinks, Text,
Codebeispiele, Graphiken.

**In welcher Form?** Nach keinen rigiden Vorgaben sowie unmittelbar,
d.h. Weblinks zum Anklicken, Text zum Lesen, Codebeispiele entweder mit
Ergebnis-Output oder ohne, jedenfalls zum Kopieren und ins eigene
R-Skript Einfügen, Graphiken zum Betrachten.

**Auf welchem Weg?** Online (GitHub) und uneingeschränkt frei
zugänglich.

**An wen?** In erster Linie an Studierende dieses open science Seminars,
zudem aber auch an jede Person, der der Weblink weitergeleitet wird.

### Orientierung, Kompass

Wer verstehen will, braucht Orientierung. Beides geht optimal mit
Einfachheit, als erstem Schritt bzw. sobald man anfängt, den Wald vor
lauter Bäumen nicht mehr zu sehen.

<div class="figure">

<img src="osfs26_files/figure-gfm/chunk2-1.png" alt="Maximal einfache Darstellung einer Schwierigkeit und deren (teilweiser) Lösung bzw. Behebung." width="580" />
<p class="caption">

Maximal einfache Darstellung einer Schwierigkeit und deren (teilweiser)
Lösung bzw. Behebung.
</p>

</div>

Obige Graphik kann ähnlich wie ein Kompass verwendet werden. Jede/r
Wissenschaftler/in beschäftigt sich in einem gegebenen Augenblick
ausschliesslich mit <ins>einer</ins> **S**chwierigkeit, d.h. etwas das
er/sie (noch nicht völlig) versteht. Beim **W**arum geht es darum,
mögliche Erklärungsfaktoren zu finden. Beim **D**arum prüft man
empirisch, ob ein identifizierter Erklärungsfaktor die **S**chwierigkeit
tatsächlich (teilweise) produziert (wenn es ein RF ist) oder unterdrückt
(wenn es ein PF ist). Zuletzt versucht man den Erklärungsfaktor so gut
es geht zu eliminieren (wenn es ein RF ist) oder zu verstärken (wenn es
ein PF ist), wodurch im besten, nämlich in einem monokausalen, Fall die
**S**chwierigkeit künftig ausbleibt (KS), wenigstens aber geringer als
zuvor ausgeprägt ist (GS).

### Checklisten, Regelsammlungen

Im Seminar zu open science (Bereich: empirische Psychologie) geht es -
aufgrund der quasi-Gleichsetzung von empirisch und datengestützt - um
das Planen, Durchführen und Analysieren von messbaren Konstrukten bzw.
deren vermuteter Zusammenhänge.

In der empirischen Psychologie ist mit Zusammenhang fast immer ein
linearer Zusammenhang gemeint. Ein **linearer Zusammenhang** ist immer
nur dann vorhanden, wenn ein **bedingter Unterschied** in den Daten
vorhanden ist. Dies ist am einfachsten an einem sogenannten Scatterplot
demonstriert, wobei hier ein positiver Zusammenhang gezeigt wird.

``` r
library(correlatio)
library(ggplot2)
set.seed(1) # set.seed to ensure reproducibility
# Simulate two continuous variables x1 and x2
dat <- correlatio::simcor(obs=40, rhos=.7)[[1]]
# Scatterplot and slope of the linear model (lm)
ggplot(data=dat, aes(x=x1, y=x2)) +
    geom_point() +
    geom_smooth(method="lm", se=FALSE)
```

<figure>
<img src="osfs26_files/figure-gfm/chunk1-1.png"
alt="Scatterplot und slope aus der einfachen linearen Regression." />
<figcaption aria-hidden="true">Scatterplot und slope aus der einfachen
linearen Regression.</figcaption>
</figure>

Man sieht, wenn man x1 von links nach rechts abläuft, dass man dann
tendenziell auf höhere x2 Werte stösst (Englisch: slope = rise over
run). Anders gesagt, es macht einen Unterschied auf Ebene x2, ob man auf
Ebene x1 zwischen -2 und 0 liegt oder ob man x1-Werte grösser als 0 hat.
Ein linearer Zusammenhang ist somit die Verallgemeinerung des Konzepts
Unterschied, den man gewöhnlich nur mit einer Gruppenzugehörigkeit
verbindet, z.B. die Experimentalgruppe habe durchschnittlich höhere
Werte als die Kontrollgruppe. Ein **Unterschied** wird in der Statistik
häufig als **Effekt** bezeichnet (Vorsicht vor Kausalitätsillusionen!).
Der vermutete **Effekt** bezieht sich dabei immer auf die sogenannten
**Erwartungswerte**, die auf theoretischer Populationsebene existieren
(laut Theorie). Die konkrete Schätzung geschieht jedoch anhand von
**Mittelwerten** einer konkreten Stichprobe, die aus der Zielpopulation
stammen soll.

### emmeans

Vor diesem Hintergrund, d.h. der bewussten und gut begründeten Analyse
des Zusammenhangs gemessener psychologischer Konstrukte, empfehle ich
das R Paket [emmeans](https://rvlenth.github.io/emmeans/). Insbesondere
empfehle ich, dass der Text unterhalb der Überschrift [‘Tidyness can be
dangerous’](https://rvlenth.github.io/emmeans/#tidiness-can-be-dangerous)
so oft gelesen wird, bis er in Mark und Bein übergegangen ist.

### marginaleffects

Eine von emmeans unabhängige, jedoch ähnliche Absicht steckt hinter der
Onlinequelle [marginaleffects](https://marginaleffects.com/). Auch hier
stösst man auf der Titelseite auf ähnliche Hinweise wie bei emmeans,
nämlich dass allem Anschein nach viele Forscher/innen (nicht nur
Psycholog/innen) in der Vergangenheit und Gegenwart ihr Verständnis
komplexer statistischer Modelle sehr häufig überschätzt haben. Mit
anderen Worten, sie haben sich auffällig häufig gegen das
[Misstrauen](#2026-02-23), d.h. für das Vertrauen entschieden, z.B. in
beliebte, doch leider lückenhafte Fachbücher und in
‘anwenderfreundliche’ Software, die bei genauem Hinsehen eher als
anwenderfeindlich gelten sollte. Grund: Diese Software verletzt den
Grundsatz ‘Hilfe zur Selbsthilfe’, d.h. diese Software suggeriert, dass
sie, d.h. die Softwarefirmen, den Forscher/innen mühsame (Denk-)Arbeit
abnehmen kann, worauf leider die grosse Mehrzahl aller Forscher/innen
seither eingestiegen ist. Der Grad an vertrauensvoller Naivität ist
hierbei maximal. Die Quittung ist, dass Softwarefirmen zwar viele
zufriedene ‘Kund/innen’ haben, die jedoch leider Forschung betreiben,
die viel zu wünschen übrig lässt (M. Park, Leahey, and Funk 2023).
Beispiele gibt es zu viele um sie hier alle aufzuzählen, deshalb seien
stellvertretend nur drei Beispiele genannt:

1.  Der hybride p-Wert. Eine Mischung aus dem p-Wert von Fisher und von
    Neyman-Pearson, die über kein wissenschaftliches Fundament verfügt
    (Goodman 1993)!
2.  Die völlig einseitige sowie fehlerhafte Anwendung der
    frequentistischen Inferenzstatistik, die Denkfaulheit fördert, weil
    sie suggeriert, dass der Forschungsprozess fast vollständig
    mechanisch (objektiv) abläuft (Nuzzo 2014), dass dies sogar gut so
    sei, weil ‘subjektive’ Einschätzungen den wissenschaftlichen Erfolg
    gefährden, was blödsinnig erscheint, es sei denn, man hat sich
    vollkommen dem Positivismus verschrieben (Y. S. Park, Konge, and
    Artino Jr 2020) .
3.  Korrektur für multiples Testen (Greenland and Hofman 2019; Hooper
    2025). Die Menge sowie die Titel der Publikationen zu diesem Thema
    zeigen an, dass eine grosse Mehrheit an Forscher/innen allem
    Anschein nach sich nicht mit ‘subjektiven’ Überlegungen hierzu
    aufhält. Dies zeigt eine beträchtliche Unsicherheit an.

## Estimated marginal means

Die ‘population marginal means’ wurden von Searle, Speed, and Milliken
(1980) als Alternative zu den oberflächlichen least squares means
vorgeschlagen. Das heisst lediglich, dass ein etwas genaueres, zugleich
also ein etwas längeres bzw. intensiveres Hinsehen auf die Ergebnisse
einer empirischen Datenanalyse vorgeschlagen wurde. Um einigermassen
nachvollziehen zu können, warum diese doch scheinbar so
selbstverständliche Angelegenheit (genau(er) hinzusehen) als
‘Alternativvorschlag’ bezeichnet wird, der ausgerechnet an
Forscher/innen gerichtet war bzw. ist, braucht es Hintergrundwissen zu
Forschungsparadigmen (Pandey et al. 2025). Die Tatsache, dass sehr
viele, leider vor allem Nachwuchsforscher/innen, so gut wie nichts zu
Forschungsparadigmen wissen, zeigt überdeutlich an, wie es in der
Forschung zugeht. Es muss in erster Linie der äusserliche Schein gewahrt
werden, obwohl genau das eigentlich par excellence als
unwissenschaftlich gilt. Der eigentliche Kern der Wissenschaft besteht
doch gerade darin, die Wahrung des äusserlichen Scheins durch
genaue(re)s Hinsehen zu durchbrechen.

Schauen wir uns einmal ein Beispiel zu ‘population marginal means’ an.

# Literaturverzeichnis

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-goodman1993p" class="csl-entry">

Goodman, Steven N. 1993. “P Values, Hypothesis Tests, and Likelihood:
Implications for Epidemiology of a Neglected Historical Debate.”
*American Journal of Epidemiology* 137 (5): 485–96.

</div>

<div id="ref-greenland2019multiple" class="csl-entry">

Greenland, Sander, and Albert Hofman. 2019. “Multiple Comparisons
Controversies Are about Context and Costs, Not Frequentism Versus
Bayesianism.” *European Journal of Epidemiology* 34 (9): 801.

</div>

<div id="ref-hooper2025adjust" class="csl-entry">

Hooper, Richard. 2025. “To Adjust, or Not to Adjust, for Multiple
Comparisons.” *Journal of Clinical Epidemiology* 180: 111688.

</div>

<div id="ref-nuzzo2014scientific" class="csl-entry">

Nuzzo, Regina. 2014. “Scientific Method: Statistical Errors.” *Nature*
506 (7487).

</div>

<div id="ref-pandey2025research" class="csl-entry">

Pandey, Chandra Shekhar, Patanjali Mishra, Shri Ram Pandey, Ratan Deep
Singh, and Shweta Pandey. 2025. “Research Paradigms: A Systematic
Literature Review of Methodological Shifts and Interdisciplinary
Approaches in Research.” *Quality & Quantity*, 1–29.

</div>

<div id="ref-park2023papers" class="csl-entry">

Park, Michael, Erin Leahey, and Russell J Funk. 2023. “Papers and
Patents Are Becoming Less Disruptive over Time.” *Nature* 613 (7942):
138–44.

</div>

<div id="ref-park2020positivism" class="csl-entry">

Park, Yoon Soo, Lars Konge, and Anthony R Artino Jr. 2020. “The
Positivism Paradigm of Research.” *Academic Medicine* 95 (5): 690–94.

</div>

<div id="ref-searle1980population" class="csl-entry">

Searle, Shayle R, F Michael Speed, and George A Milliken. 1980.
“Population Marginal Means in the Linear Model: An Alternative to Least
Squares Means.” *The American Statistician* 34 (4): 216–21.

</div>

</div>
