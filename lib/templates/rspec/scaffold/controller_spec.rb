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

describe <%= controller_class_name %>Controller do
  before do
    # ここでログインの処理を記述する
    <%= controller_class_path.map{|m| m.underscore}.join("_").tap{|p| p << "_" if p.present?} %>login
  end

  let(:valid_params){{
    # TODO 保存できるパラメータを指定する
    #name: 'name',
  }}
  let(:invalid_params){{
    # TODO 保存できないパラメータを指定する
    #name: 'a'*256,
  }}

<% unless options[:singleton] -%>
  describe "GET index" do
    subject{get :index}
    it{should render_template :index}
  end

<% end -%>
  describe "GET show" do
    subject{get :show, id: id}
    let(:id){<%= singular_instance_name %>.id}
    let(:<%= singular_instance_name %>){<%= fixture %>(:<%= singular_instance_name %>)}

    it{should render_template :show}
  end

  describe "GET new" do
    subject{get :new}
    it{should render_template :new}
  end

  describe "GET edit" do
    subject{get :edit, id: id}
    let(:id){<%= singular_instance_name %>.id}
    let(:<%= singular_instance_name %>){<%= fixture %>(:<%= singular_instance_name %>)}

    it{should render_template :edit}
  end

  describe "POST create" do
    subject{post :create, <%= singular_instance_name %>: create_params}
    context "保存可能なパラメータを指定した場合" do
      let(:create_params){valid_params}
      it{subject.should redirect_to [<%= controller_class_path.map{|m| ":#{m.underscore}"}.join(",").tap{|p| p << ", " if p.present?} %><%= model_name %>.last]}
    end
    context "保存不可能なパラメータを指定した場合" do
      let(:create_params){invalid_params}
      it{should render_template :new}
    end
  end

  describe "PUT update" do
    subject{put :update, id: id, <%= singular_instance_name %>: update_params}
    let(:id){<%= singular_instance_name %>.id}
    let(:<%= singular_instance_name %>){<%= fixture %>(:<%= singular_instance_name %>)}

    context "保存可能なパラメータを指定した場合" do
      let(:update_params){valid_params}
      it{should redirect_to [<%= controller_class_path.map{|m| ":#{m.underscore}"}.join(",").tap{|p| p << ", " if p.present?} %><%= singular_instance_name %>]}
    end
    context "保存不可能なパラメータを指定した場合" do
      let(:update_params){invalid_params}
      it{should render_template :edit}
    end
  end

  describe "DELETE destroy" do
    subject{delete :destroy, id: id}
    let(:id){<%= singular_instance_name %>.id}
    let(:<%= singular_instance_name %>){<%= fixture %>(:<%= singular_instance_name %>)}

    it{should redirect_to <%= index_helper %>_url}
  end

end
