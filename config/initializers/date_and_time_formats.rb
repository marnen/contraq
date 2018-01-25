dmy = '%-d %b %Y'
Date::DATE_FORMATS[:dmy] = dmy
Time::DATE_FORMATS.reverse_merge!(
  datetime: "#{dmy} %-l:%M %p",
  dmy: dmy
)
