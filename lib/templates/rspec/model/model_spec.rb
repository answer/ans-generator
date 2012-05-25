<%
fixture_create = case
  when defined? Fabricate
    "Fabricate"
  when defined? FactoryGirl
    "FactoryGirl"
end
-%>
# -*- coding: utf-8 -*-

require 'spec_helper'

describe <%= class_name %>, "db" do
  # 存在するカラムを列挙する
  #it{should have_db_column(:column)}

<% for attribute in attributes -%>
  it{should have_db_column(:<%= attribute.name %>)}
<% end -%>

  # 存在するインデックスを列挙する
  #it{should have_db_index(:column)}
  #it{should have_db_index([:column, :column2])}
  #it{should have_db_index(:column).uniq(true)}
end

describe <%= class_name %>, "mass_assignments" do
  # mass_assignment
  #it{should allow_mass_assignment_of(:column)}           # できる
  #it{should_not allow_mass_assignment_of(:column)}       # できない
  #it{should allow_mass_assignment_of(:column).as(:role)} # as: role ならできる

<% for attribute in attributes -%>
  it{should allow_mass_assignment_of(:<%= attribute.name %>)}
<% end -%>
end

describe <%= class_name %>, "associations" do
  # アソシエーション
  #it{should belong_to(:parent)}
  #it{should have_many(:children)}
  #it{should have_many(:children).through(:relation)}
  #it{should have_one(:partner)}
end

describe <%= class_name %>, "invalid values" do
  subject{<%= class_name %>.new <%= fixture_create %>.attributes_for(:<%= plural_name.singularize %>)}

  # データベースに保存できない値を渡す
  #it{should_not success_persistance_of(:name).values(["a"*256])}  # varchar(255)
  #it{should_not success_persistance_of(:name).values([10**10])}   # int(9)
  #it{should_not success_persistance_of(:name).values([nil])}      # not null カラム
  #it{should_not success_persistance_of(:name).values(["a", "a"])} # unique カラム

<% for attribute in attributes -%>
<% if values = (case attribute.type
  when :integer then '10**10'
  when :string  then '"a"*256'
end) -%>
  it{should_not success_persistance_of(:<%= attribute.name %>).values([<%= values %>])}
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
