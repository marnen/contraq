dmy = '%-d %b %Y'
Time::DATE_FORMATS.reverse_merge!(
  datetime: "#{dmy} %-l:%M %p",
  dmy: dmy
)
