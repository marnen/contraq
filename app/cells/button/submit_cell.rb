module Button
  class SubmitCell < BaseCell
    private

    def icon_name
      'check-circle'
    end

    def form
      model
    end
  end
end
