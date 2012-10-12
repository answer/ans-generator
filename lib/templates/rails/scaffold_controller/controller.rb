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
  respond_path = controller_class_path.map{|m| ":#{m.underscore}"}.join(",").tap{|p| p << ", " if p.present?}
-%>
# -*- coding: utf-8 -*-

class <%= controller_class_name %>Controller < <%= controller_class_path.map{|m| m.camelize}.join("::") %>::ApplicationController
  authorize_resource

  before_filter :set_<%= singular_instance_name %>, only: [:show, :edit, :update, :destroy]
  before_filter :set_meta_sort, only: [:index]

  def index
    @<%= plural_instance_name %>_search = <%= model_name %>.search(params[:search])
    @<%= plural_instance_name %> = @<%= plural_instance_name %>_search.page(params[:page]).per(100)
    respond_with <%= respond_path %>@<%= plural_instance_name %>
  end

  def show
    respond_with <%= respond_path %>@<%= singular_instance_name %>
  end

  def new
    @<%= singular_instance_name %> = <%= orm_class.build(model_name) %>
    respond_with <%= respond_path %>@<%= singular_instance_name %>
  end

  def create
    @<%= singular_instance_name %> = <%= orm_class.build(model_name, "params[:#{singular_instance_name}]") %>
    @<%= orm_instance(singular_instance_name).save %>
    respond_with <%= respond_path %>@<%= singular_instance_name %>
  end

  def edit
    respond_with <%= respond_path %>@<%= singular_instance_name %>
  end

  def update
    @<%= orm_instance(singular_instance_name).update_attributes("params[:#{singular_instance_name}]") %>
    respond_with <%= respond_path %>@<%= singular_instance_name %>
  end

  def destroy
    @<%= orm_instance(singular_instance_name).destroy %>
    respond_with <%= respond_path %>@<%= singular_instance_name %>
  end

  private

  def set_<%= singular_instance_name %>
    @<%= singular_instance_name %> = <%= orm_class.find(model_name, "params[:id]") %>
  end

  def set_meta_sort
    params[:search] ||= {}
    params[:search][:meta_sort] ||= "id.desc"
  end
end
