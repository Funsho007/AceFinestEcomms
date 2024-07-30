ActiveAdmin.register Contact do
  permit_params :title, :content, :pamalink, :description

  form do |f|
    f.inputs "Contact Details" do
      f.input :title, label: "Title"
      f.input :content, label: "Content", as: :text
      f.input :pamalink, label: "Pamalink"
    end
    f.actions
  end
end
