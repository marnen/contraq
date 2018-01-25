Given 'today is $date' do |date_text|
  Timecop.freeze Date.parse(date_text)
end
