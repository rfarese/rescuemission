module ApplicationHelper
  def use_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :no_intra_emphasis => true)
    markdown.render(text).html_safe
  end
end
