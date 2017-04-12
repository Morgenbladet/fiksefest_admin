module ApplicationHelper
  def nav_li_active?(text, path, icon=nil)
    content_tag(:li, class: current_page?(path) ? 'active' : 'inactive') do

      link_to path do
        icon = 'angle-right' unless icon
        content_tag(:i, nil, class: "pe-7s-#{icon}") + content_tag(:p, text)
      end
    end
  end
end
