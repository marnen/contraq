Then 'show me the page' do
  begin
    save_and_open_page
  rescue Launchy::CommandNotFoundError
    saved_page_path = Pathname.new save_page
    relative_path = saved_page_path.relative_path_from(Rails.root)
    warn <<-EOT.strip_heredoc
      Launchy couldn't find a browser, so page was saved to #{relative_path}. To see the page, try:
      open #{relative_path}
    EOT
  end
end
