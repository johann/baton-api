class JoinGroup
  attr_reader :user_id, :group_id, :errors

  def initialize(user_id:, group_id:)
    @user_id = user_id
    @group_id = group_id
  end

  def execute
    membership = Membership.new(membership_params)
    if membership.save
      @errors = nil
    else
      @errors = membership.errors
    end
  end

  def valid?
    errors.nil?
  end

  def success?
    valid?
  end
end