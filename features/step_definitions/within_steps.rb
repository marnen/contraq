When /^(.+) within (.+)$/ do |step_text, container|
  within selector_for(container) do
    step step_text
  end
end
