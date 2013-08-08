module ApplicationHelper 
  def full_title(page_title = '')
     base_title = "MemoRabble"
     if page_title.empty?
       base_title
     else
       "#{ base_title } | #{ page_title }"
     end
   end

  # processes content of memo and prepares it for view
  def memo_content(input, remote: false)
    content = input.gsub(/@([a-z0-9A-Z]+)/) do |match|
      link_to "@#{ $1 }", memo_path($1), class: "marker", remote: remote
    end 

    simple_format content, {  }, sanitize: false
  end
end
