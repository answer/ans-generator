<%
fixture = case
  when defined? Fabricate
    "Fabricate.attributes_for"
  when defined? FactoryGirl
    "FactoryGirl.attributes_for"
end
-%>
# -*- coding: utf-8 -*-

require 'spec_helper'

describe <%= class_name %>, "db" do
  # 存在するカラムを列挙する
  #it{should have_db_column(:column)}
<% for attribute in attributes -%>
  it{should have_db_column(:<%= (case attribute.type
when :belongs_to,:resources then "#{attribute.name}_id"
else
  attribute.name
end) %>)}
<% end -%>

  # 存在するインデックスを列挙する
  #it{should have_db_index(:column)}
  #it{should have_db_index([:column, :column2])}
  #it{should have_db_index(:column).uniq(true)}
<% for attribute in attributes -%>
<% if values = (case attribute.type
  when :belongs_to,:resources then true
end) -%>
  it{should have_db_index(:<%= attribute.name %>_id)}
<% end -%>
<% end -%>
end

describe <%= class_name %>, "mass_assignments" do
  # mass_assignment
  #it{should allow_mass_assignment_of(:column)}           # できる
  #it{should_not allow_mass_assignment_of(:column)}       # できない
  #it{should allow_mass_assignment_of(:column).as(:role)} # as: role ならできる
<% for attribute in attributes -%>
<% if (case attribute.type
when :belongs_to,:resources then false
else
  true
end) -%>
  it{should allow_mass_assignment_of(:<%= attribute.name %>)}
<% end -%>
<% end -%>
end

describe <%= class_name %>, "associations" do
  # アソシエーション
  #it{should belong_to(:parent)}
  #it{should have_many(:children)}
  #it{should have_many(:children).through(:relation)}
  #it{should have_one(:partner)}
<% for attribute in attributes -%>
<% if values = (case attribute.type
  when :belongs_to,:resources then true
end) -%>
  it{should belong_to(:<%= attribute.name %>)}
<% end -%>
<% end -%>
end

describe <%= class_name %>, "invalid values" do
  #subject{<%= class_name %>.new <%= fixture %>(:<%= plural_name.singularize %>)}

  # データベースに保存できない値を渡す
  #it{should_not success_persistance_of(:name).values(["a"*256])}  # varchar(255)
  #it{should_not success_persistance_of(:name).values([10**10])}   # int(9)
  #it{should_not success_persistance_of(:name).values([nil])}      # not null カラム
  #it{should_not success_persistance_of(:name).values(["a", "a"])} # unique カラム
<% for attribute in attributes -%>
<% name, values = (case attribute.type
  when :integer then [nil, '10**10']
  when :belongs_to,:resources then ["#{attribute.name}_id", '10**10']
  when :string then [nil, '"a"*256']
end) -%>
<% if values -%>
  it{should_not success_persistance_of(:<%= name || attribute.name %>).values([<%= values %>])}
<% end -%>
<% end -%>
end

describe <%= class_name %>, "scope" do
  subject{<%= class_name %>}

#  it{should have_executable_scope(:scope).by_sql(<<__SQL)}
#    SELECT `<%= plural_name %>`.* FROM `<%= plural_name %>`
#    WHERE `<%= plural_name %>`.`number` = 'value'
#__SQL

end

#describe <%= class_name %>, "METHOD" do
#  subject{item.METHOD}
#  let(:item){<%= class_name %>.create <%= fixture %>(:<%= plural_name.singularize %>,
#    COLUMN: value,
#  )}
#  let(:value){nil}
#
#  context "COLUMN が value の場合" do
#    let(:value){"value"}
#    it{should == "METHOD VALUE"}
#  end
#  context "COLUMN が nil の場合" do
#    it{should == "METHOD"}
#  end
#
#end
