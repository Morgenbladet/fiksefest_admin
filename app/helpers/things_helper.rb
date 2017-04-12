module ThingsHelper
  def thing_accepted_table_class(thing)
    case thing.status
    when "accepted"
      "success"
    when "denied"
      "danger"
    when "in_queue"
      "warning"
    end
  end
end
