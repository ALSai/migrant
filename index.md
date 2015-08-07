---
title       : The "migrant" app
author      : Simon "ALSimon" Gilliot
framework   : revealjs      # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : pojoaque       # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
revealjs:
  theme: default
  transition: convex
---

# The "migrant" app
### Presentation of the shiny application

<small>Created by Simon "ALSimon" Gilliot.</small>

---
## What the app does?

The "migrant" application shows statistics about refugee's status decisions :

* per migrant profile,
* per destination country (in Europe).

The application can show :

* people askings for a refugee's status with final decision,
* percentage of decision.

---
## How it works?

The "migrant" application collect inputs from the "Migrant's profile" panel. You have to select :

* the sex of the migrant,
* the age of the migrant,
* the origin (citizenship) of the migrant.

Results appears on a stacked bar plot. It shows you :

* people (on the Y axis),
* concerned by a decision (colored bar),
* per countries (on the X axis).

You can see percentage of decision (on the Y axis) by clicking on the "Percentage" tab on the top of the graph.

---
## Where do the data come from?

All data come from [Eurostat](http://ec.europa.eu/eurostat/).

The database used in this application is "migr_asydcfina". Some informations can be found on these [metadata](http://ec.europa.eu/eurostat/cache/metadata/fr/migr_asydec_esms.htm). It can also be explored using eurostat [data explorer](http://ec.europa.eu/eurostat/web/asylum-and-managed-migration/data/database).


```r
library(eurostat)
dataset <- get_eurostat("migr_asydcfina")
```



In this database, there are 9,295,741 rows with :

* 206 different origins,
* 34 different destinations,
* 7 different years (from 2008 to 2014).

Only data from 2014 are used in this application.

---
## Want more?

About the application itself :
* [the application](https://alsai.shinyapps.io/migrant)
* [the source code](https://github.com/ALSai/migrant)

More details about migrants coming to Europe can be found on :
* [UNHCR](http://www.unhcr.org/)
* [ECRE](http://www.ecre.org/)
* [asyliumeurope.org](http://www.asylumineurope.org/)
* [eurostat](http://ec.europa.eu/eurostat)

Coming soon, my website about this subject :
* [migrants.guide](http://migrants.guide)
