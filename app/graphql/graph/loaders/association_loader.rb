class Graph::Loaders::AssociationLoader < GraphQL::Batch::Loader
  def initialize(model, association)
    @model = model
    @association = association
  end

  def perform(values)
    ActiveRecord::Associations::Preloader.new.preload(values, @association)
    values.each { |value| fulfill(value, value.send(@association)) }
  end
end
