module ApplicationHelper 
  # Displays full title of website, then page title
  def full_title(page_title = '')
     base_title = "MemoRabble"
     if page_title.empty?
       base_title
     else
       "#{ base_title } | #{ page_title }"
     end
   end




#### TODO: All the mess below is to be taken out of here and put into   ####
####       the MemoParser gem once I figure out exactly how I want it.  ###   


  # Subclassing redcarpet for custom merkdown
  class MemoMarkdown < Redcarpet::Render::HTML
    def header(text, header_level)
      "<p>#" + text + "</p>"
    end

    def raw_html(raw_html)
      nil
    end
  end

  # Processes content of memo and prepares it for view
  def memo_content(input, remote: false)
    # NOTE: Thinking of using gsub? Read these if there's ever trouble:
    # https://github.com/rails/rails/issues/1555
    # https://gist.github.com/CLUSTERfoo/6258984
    renderer = MemoMarkdown.new(filter_html: true, safe_links: true)
    markdown = Redcarpet::Markdown.new( renderer, autolink: true, 
                                        highlight: true, strikethrough: true,
                                        superscript: true, footnotes: true)
    content = markdown.render(input)
    content = content.gsub(/@([a-z0-9A-Z]+)/) do |match|
      link_to "@#{ $1 }", memo_path($1), class: "marker", remote: remote
    end 
    content = raw content
  end
end
