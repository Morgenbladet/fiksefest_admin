module ApplicationHelper
  def nav_li_active?(text, path, options={})
    defaults = { icon: 'angle-right', badge: nil }
    options = defaults.merge(options)

    addtxt = if options[:badge]
               content_tag :span, options[:badge], class: 'badge'
             else
               ""
             end
    text = content_tag(:p, text + " " + addtxt, {}, false)

    content_tag(:li, class: current_page?(path) ? 'active' : 'inactive') do

      link_to path do
        content_tag(:i, nil, class: "pe-7s-#{options[:icon]}") + text
      end
    end
  end
end
