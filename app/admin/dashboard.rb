# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome to PrettyHub Admin Dashboard"
        small "You can add, edit and destroy."
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Products" do
          ul do
            Product.last(10).map do |product|
              li link_to(product.name, edit_admin_product_path(product))
            end
          end
        end
      end
      column do
        panel "Recent Categories" do
          ul do
            ProductCategory.last(10).map do |category|
              li link_to(category.name, edit_admin_product_category_path(category))
            end
          end
        end
      end
    end
  end # content
end
