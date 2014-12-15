---
title       : Developing Data Products - Course Project
subtitle    : Milano  City. Historic population surveys - population by age (1881-2011)
author      : abasaglia
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [shiny]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
ext_widgets: {rCharts: [libraries/nvd3]}
---

## Data

The data has been downloaded from http://dati.comune.milano.it/dato/item/300-300%20-%20Popolazione:%20censimenti%20storici%20-%20popolazione%20per%20et%C3%A0%20(1881-2011).html

This dataset contains the Italian historic population surveys for the Milano City.

Every row contains:
- Year of the survey (no survey for 1891 and 1941)
- Age
- Sex
- How many people with that age and sex

--- 

## Milano - Graph whith the Age distribution by Year
<div class="row-fluid">
  <div class="span4">
    <form class="well">
      <div>
        <label class="control-label" for="YYYY">Year</label>
        <input id="YYYY" type="slider" name="YYYY" value="1881" class="jslider" data-from="1881" data-to="2011" data-step="10" data-skin="plastic" data-round="FALSE" data-locale="us" data-format="#,##0.#####" data-scale="|;|;|;|;|;|;|;|;|;|;|;|;|;|" data-smooth="FALSE"/>
      </div>
    </form>
  </div>
  <div class="span8">
    <div id="nvd3plot" class="shiny-html-output nvd3 rChart"></div>
  </div>
</div>

--- 



Milano - Total population by Year

<div id = 'chart1' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart1()
    });
    function drawchart1(){  
      var opts = {
 "dom": "chart1",
"width":    600,
"height":    400,
"x": "Group.1",
"y": "x",
"group": "Group.2",
"type": "lineChart",
"id": "chart1" 
},
        data = [
 {
 "Group.1":           1881,
"Group.2": "Donne",
"x":         157756 
},
{
 "Group.1":           1901,
"Group.2": "Donne",
"x":         247093 
},
{
 "Group.1":           1911,
"Group.2": "Donne",
"x":         301323 
},
{
 "Group.1":           1921,
"Group.2": "Donne",
"x":         371640 
},
{
 "Group.1":           1931,
"Group.2": "Donne",
"x":         517348 
},
{
 "Group.1":           1951,
"Group.2": "Donne",
"x":         678879 
},
{
 "Group.1":           1961,
"Group.2": "Donne",
"x":         840888 
},
{
 "Group.1":           1971,
"Group.2": "Donne",
"x":         916216 
},
{
 "Group.1":           1981,
"Group.2": "Donne",
"x":         851390 
},
{
 "Group.1":           1991,
"Group.2": "Donne",
"x":         728920 
},
{
 "Group.1":           2001,
"Group.2": "Donne",
"x":         670083 
},
{
 "Group.1":           2011,
"Group.2": "Donne",
"x":         661145 
},
{
 "Group.1":           1881,
"Group.2": "Uomini",
"x":         162536 
},
{
 "Group.1":           1901,
"Group.2": "Uomini",
"x":         242991 
},
{
 "Group.1":           1911,
"Group.2": "Uomini",
"x":         297877 
},
{
 "Group.1":           1921,
"Group.2": "Uomini",
"x":         346581 
},
{
 "Group.1":           1931,
"Group.2": "Uomini",
"x":         474580 
},
{
 "Group.1":           1951,
"Group.2": "Uomini",
"x":         595366 
},
{
 "Group.1":           1961,
"Group.2": "Uomini",
"x":         741646 
},
{
 "Group.1":           1971,
"Group.2": "Uomini",
"x":         812580 
},
{
 "Group.1":           1981,
"Group.2": "Uomini",
"x":         753259 
},
{
 "Group.1":           1991,
"Group.2": "Uomini",
"x":         640311 
},
{
 "Group.1":           2001,
"Group.2": "Uomini",
"x":         586128 
},
{
 "Group.1":           2011,
"Group.2": "Uomini",
"x":         580978 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>

---

Milano - Mean Age by Year

<div id = 'chart2' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart2()
    });
    function drawchart2(){  
      var opts = {
 "dom": "chart2",
"width":    600,
"height":    400,
"x": "Year",
"y": "wmean",
"group": "Sex",
"type": "lineChart",
"id": "chart2" 
},
        data = [
 {
 "Year":           1881,
"Sex": "Donne",
"mean":             50,
"wmean": 29.74740738863 
},
{
 "Year":           1881,
"Sex": "Uomini",
"mean":             50,
"wmean":  29.2758773441 
},
{
 "Year":           1901,
"Sex": "Donne",
"mean":             50,
"wmean": 29.55349605209 
},
{
 "Year":           1901,
"Sex": "Uomini",
"mean":             50,
"wmean":  28.3835203773 
},
{
 "Year":           1911,
"Sex": "Donne",
"mean":             50,
"wmean": 30.14443968764 
},
{
 "Year":           1911,
"Sex": "Uomini",
"mean":             50,
"wmean": 28.79242774702 
},
{
 "Year":           1921,
"Sex": "Donne",
"mean":             50,
"wmean": 31.91334490367 
},
{
 "Year":           1921,
"Sex": "Uomini",
"mean":             50,
"wmean": 30.53400503778 
},
{
 "Year":           1931,
"Sex": "Donne",
"mean":             50,
"wmean": 32.79208385845 
},
{
 "Year":           1931,
"Sex": "Uomini",
"mean":             50,
"wmean": 31.75110202706 
},
{
 "Year":           1951,
"Sex": "Donne",
"mean":             50,
"wmean": 36.54079298373 
},
{
 "Year":           1951,
"Sex": "Uomini",
"mean":             50,
"wmean":  35.0927043197 
},
{
 "Year":           1961,
"Sex": "Donne",
"mean":             50,
"wmean": 37.64101878015 
},
{
 "Year":           1961,
"Sex": "Uomini",
"mean":             50,
"wmean": 35.22796050946 
},
{
 "Year":           1971,
"Sex": "Donne",
"mean":           47.5,
"wmean": 38.00351554655 
},
{
 "Year":           1971,
"Sex": "Uomini",
"mean":           47.5,
"wmean":  34.6583708681 
},
{
 "Year":           1981,
"Sex": "Donne",
"mean":           49.5,
"wmean": 40.84927471547 
},
{
 "Year":           1981,
"Sex": "Uomini",
"mean":           49.5,
"wmean": 36.80095159832 
},
{
 "Year":           1991,
"Sex": "Donne",
"mean":             50,
"wmean":  44.5937921857 
},
{
 "Year":           1991,
"Sex": "Uomini",
"mean":             50,
"wmean": 40.19610782885 
},
{
 "Year":           2001,
"Sex": "Donne",
"mean":             50,
"wmean": 47.05866437441 
},
{
 "Year":           2001,
"Sex": "Uomini",
"mean":             50,
"wmean": 42.60575505692 
},
{
 "Year":           2011,
"Sex": "Donne",
"mean":             50,
"wmean": 47.62909649169 
},
{
 "Year":           2011,
"Sex": "Uomini",
"mean":             50,
"wmean": 43.39912182561 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>

