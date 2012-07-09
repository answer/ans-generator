<%
  fixture = case
    when defined? Fabricate
      "Fabricate"
    when defined? FactoryGirl
      "FactoryGirl.create"
  end

  model_name = class_name
  plural_instance_name = plural_table_name
  singular_instance_name = singular_table_name
  if model_name =~ /^(.*::)(.*)$/
    model_name = $2
    prefix = $1.gsub(/::/,"_").downcase
    plural_instance_name = plural_instance_name.gsub(/^#{prefix}/,"")
    singular_instance_name = singular_instance_name.gsub(/^#{prefix}/,"")
  end
-%>
# -*- coding: utf-8 -*-

require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= controller_file_path %>/show.html.<%= options[:template_engine] %>", type: :view do
  subject{
    render
    rendered
  }
  before do
    # TODO ここでログインの処理を記述する
    #login

    assign :<%= singular_instance_name %>, <%= model_name %>.find(<%= fixture %>(:<%= singular_instance_name %><%= output_attributes.empty? ? ').id)' : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<%= output_attributes.empty? ? "" : "    ).id)\n" -%>
  end
  it{should be_present}
end
