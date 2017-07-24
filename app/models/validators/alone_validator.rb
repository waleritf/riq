class AloneValidator < ActiveModel::Validator
  def validate(record)
    if record.class.where(options[:attribute] => options[:value]).count > 1
      record.errors[:base] << 'Record is not alone.'
    end
  end
end
