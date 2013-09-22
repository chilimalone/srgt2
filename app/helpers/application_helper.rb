module ApplicationHelper
  def link_to_remove_fields(name, f, par)
    index = par.object.rooms.count
    if (index > 1)
      f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
    end
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.rooms.build
    index = f.object.rooms.size
    fields = f.fields_for(association, new_object, :child_index => index.to_s) do |b|
      render(association.to_s.singularize + "_fields", :f => b, :par => f)
    end
    link_to_function(name, "add_fields(this, #{index}, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
