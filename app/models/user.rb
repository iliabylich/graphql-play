# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  name            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password validations: false

  has_many :posts

  has_and_belongs_to_many :followers,
    join_table: :follow_relations,
    foreign_key: :following_id,
    association_foreign_key: :follower_id,
    class_name: 'User'

  has_and_belongs_to_many :followings,
    join_table: :follow_relations,
    foreign_key: :follower_id,
    association_foreign_key: :following_id,
    class_name: 'User'
end
