module Button
  class SubmitCell < BaseCell
    private

    def effective_model
      form.object
    end

    def icon_name
      super || 'check-circle'
    end

    def form
      model
    end
  end
end
