class ChatroomPolicy < ApplicationPolicy
  def show?
    user.present? && user.chatrooms.include?(record)
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(user: user)
      #scope.all # If users can see all restaurants
      # scope.where(user: user) # If users can only see their restaurants
      # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
      # ...
    end
  end
end
