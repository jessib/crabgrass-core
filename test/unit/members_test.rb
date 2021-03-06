require_relative 'test_helper'

class MembersTest < ActiveSupport::TestCase
  fixtures :groups, :users, :memberships, :castle_gates_keys

  # this is used when sharing with a group to only notify
  # the members which allow the current user to pester them
  #
  # This was broken because the assocation group.users sets a
  # select_value for the relation that is included with the
  # DISTINCT select of with_access.
  # We work around that by defining a custom with_access for the
  # association now.
  def test_pestering_all_members
    group = groups(:rainbow)
    users = group.users.with_access(public: :pester)
    assert users.all
  end
end
