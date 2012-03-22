class Report
  counts:
    relevant: 0,
    used:     0,
    missed:   0
  source: null
  colors:
    reset:  '\033[0m',
    red:    '\033[41m',
    green:  '\033[42m',
    yellow: '\033[43m'
  constructor: ->
    @source = _$jscoverage['agility.js'].source
    @lines  = _$jscoverage['agility.js']
    @analyze()
  analyze: ->
    _.each @lines, (line, index) =>
      @counts.relevant++
      if line == 0
        @counts.missed++
      else
        @counts.used++
  shortReport: ->
    console.log "Relevant lines: " + @counts.relevant +
                " Used: " + @counts.used +
                " Missed "+ @counts.missed
    console.log "Coverage: " + Math.floor((@counts.used / @counts.relevant)*100) + '%'
  coverageListing: ->
    _.each @source, (line, index) =>
      ind = index + 1
      if @lines[ind] == 0
        console.log @colors.red + line + @colors.reset
      else
        console.log @colors.green + line + @colors.reset

exports.Report = Report
