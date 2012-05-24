# -*- coding: utf-8 -*-

require 'spec_helper'
require "ans-model-helpers/shared_examples/sql"
<%
fixture_create = case
  when defined? Fabricate
    "Fabricate"
  when defined? FactoryGirl
    "FactoryGirl"
end
-%>

# 取得可能な属性のテスト
describe <%= class_name %>, "#attributes" do
  let(:attributes) { [
    # <%= class_name %> の属性メソッド名、初期化用の値、取得するメソッド名、期待する戻り値をリストアップ
    # メソッド名が属性名と異なる場合は opts[:method] を指定する
    # 期待する値が初期化時の値と異なる場合は opts[:expected] を指定する
    #[:name, "value"],
    #[:name, "value", method: "method", expected: "expected"],
<% for attribute in attributes -%>
    [:<%= attribute.name %>, <%= attribute.default.inspect %>],
<% end -%>
  ] }
  it "は、属性を取得できる" do
    attributes.each do |name,value,opts={}|
      opts[:method] ||= name
      opts[:expected] ||= value

      attr = <%= fixture_create %>.attributes_for(:<%= plural_name.singularize %>, name => value)
      item = <%= class_name %>.create! attr
      item = <%= class_name %>.find item.id

      item.send(opts[:method]).should == opts[:expected]
    end
  end
end

# mysql でエラーが発生するような値を渡すテスト
# (エラーにならないようにバリデーションを書いてあるかどうかのテスト)
# * not null カラムに nil を渡す
# * unique カラムに同じ値を渡す
# * 長い文字列を渡す
# * 大きな数値を渡す
#
# バリデーションのテストは、メッセージの表示も関連するので、 feature に書くこと
describe <%= class_name %>, ".create" do
  # <%= class_name %> の属性名、エラーを引き起こす値を指定する
  let(:attributes) { [
    #[:not_null, [nil]],
    #[:unique,   ["a","a"]],
    #[:string,   ["a"*256]],
    #[:integer,  [10**10]],
<% for attribute in attributes -%>
<% if values = (case attribute.type
  when :integer then '10**10'
  when :string  then '"a"*256'
  end)
-%>
    [:<%= attribute.name %>, [<%= values %>]],
<% end -%>
<% end -%>
  ] }
  it "は、 create で mysql 例外を発生させない" do
    attributes.each do |name,values|
      values.each do |value|
        attr = <%= fixture_create %>.attributes_for(:<%= plural_name.singularize %>, name => value)
        <%= class_name %>.create attr
      end
    end
  end
end

# スコープのテスト
describe <%= class_name %>, "スコープ" do
  include Ans::Model::Helpers::SqlSpecHelper
  def model
    # it_should_behave_like "Ans::Model::Helpers::Sql" を実行するために必要
    <%= class_name %>
  end


#  describe ".SCOPE_NAME" do
#    before do
#      scope_is :SCOPE_NAME
#    end
#
#    context "<CASE>の場合" do
#      before do
#        # スコープに渡すパラメータを可変長パラメータで渡す
#        scope_param_is "params"
#
#        sql_should_be do |sql|
#          # sql に期待する sql の内容を詰める
#          sql <<  "SELECT `<%= plural_name %>`.* FROM `<%= plural_name %>`"
#          sql << " WHERE `<%= plural_name %>`.`column` = 'value'"
#        end
#      end
#
#      # 指定した sql を返すこと
#      # 実行してエラーにならないこと
#      it_should_behave_like "Ans::Model::Helpers::Sql"
#    end
#  end


end
