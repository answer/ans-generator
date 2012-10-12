<%
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
describe "<%= controller_file_path %>/index.html.<%= options[:template_engine] %>", type: :view do
  subject{render;rendered}
  before do
    # ここでログインの処理を記述する
    <%= controller_class_path.map{|m| m.underscore}.join("_").tap{|p| p << "_" if p.present?} %>login

    assign :<%= plural_instance_name %>_search, <%= model_name %>.search
    assign :<%= plural_instance_name %>, <%= model_name %>.page
  end
  it{should be_present}
end
