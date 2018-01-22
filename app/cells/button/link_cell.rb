module Button
  class LinkCell < BaseCell
    private

    attr_reader :link_options

    def icon_name
      icon_names[action]
    end

    def icon_names
      @icon_names ||= {edit: 'pencil', new: 'plus-circle'}
    end

    def link_options
      result = link_info[action]
      result = result.respond_to?(:call) ? result.call : result
    end

    def link_info
      @link_info ||= {
        edit: -> { edit_gig_path model },
        new: {action: 'new'}
      }
    end
  end
end
