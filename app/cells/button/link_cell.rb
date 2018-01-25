module Button
  class LinkCell < BaseCell
    private

    attr_reader :link_options

    def icon_name
      super || icon_names[action]
    end

    def icon_names
      @icon_names ||= {edit: 'pencil', new: 'plus-circle'}
    end

    def link_options
      polymorphic_path model, action: action
    end
  end
end
