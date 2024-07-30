ActiveAdmin.register About do
  permit_params :title, :content, :pamalink, :description

  form do |f|
    f.inputs "About Details" do
      f.input :title, label: "Title"
      f.input :content, label: "Content", as: :text
      f.input :pamalink, label: "Pamalink"
    end
    f.actions
  end
end
