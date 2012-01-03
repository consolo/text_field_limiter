gem 'actionpack', '~> 2.3'
require 'action_view'

module Consolo
  module TextFieldLimiter
    # Restrict text fields.
    def to_input_field_tag(field_type, options = {})
      options = options.stringify_keys
      options["size"] ||= options["maxlength"] || DEFAULT_FIELD_OPTIONS["size"]
      if field_type == 'text'
        # next three lines are a total hack for rails 2.1.1 since it is totally
        # un-rad and thinks that an integer column has a limit of 4. wtg rails.
        cfa = object.column_for_attribute(@method_name) rescue nil
        lim = cfa.limit rescue '255'
        lim = $1 if cfa and cfa.number? and cfa.sql_type =~ /\((\d+)\)/
        options["maxlength"] ||= lim
        options['x-webkit-speech'] = true unless options['class'].to_s =~ /datepicker|time_input/
      end
      options = DEFAULT_FIELD_OPTIONS.merge(options)
      if field_type == "hidden"
        options.delete("size")
      end
      options["type"] = field_type
      options["value"] ||= value(object) unless field_type == "file"
      add_default_name_and_id(options)
      tag("input", options)
    end
    
    # Restrict text areas.
    def to_text_area_tag(options = {})
      if (object.column_for_attribute(@method_name).limit rescue false)
        options["onkeypress"] ||= "limit = #{object.column_for_attribute(@method_name).limit rescue 'NULL'}; if( limit != null && this.value.length > limit ) { this.value = this.value.substring( 0, limit ); return false; }"
      end
      options['x-webkit-speech'] = true
      options.stringify_keys!
      options = DEFAULT_TEXT_AREA_OPTIONS.merge(options)
      add_default_name_and_id(options)
      content_tag("textarea", html_escape(value(object)), options)
    end
  end
end

ActionView::Helpers::InstanceTag.send :include, Consolo::TextFieldLimiter
