class Operations::Posts::Create < Operations::Base
  attr_reader :post

  def call
    Auth.require!

    schema = PostSchema.call(params)

    if schema.success?
      @post = RequestStore[:current_user].posts.create(schema.output)
    else
      @errors = schema.errors
    end
  end

  def payload
    super.merge(post: post)
  end
end
