module GroupsHelper
  def add_task_link(group)
    link_to 'Add Task', controller: 'groups', action: 'add_task', id: group.id
  end

  def add_task_group(description, due_date, name)
    link_to 'Add Task', controller: 'groups', action: 'add_task_to_group', id: @group.id, description: description, due_date: due_date, name: name
  end

  def join_group_p
    link_to 'Join Group', controller: 'groups', action: 'join_group_p'
  end
  def join_group_link(group)
    link_to 'Join Group', controller: 'groups', action: 'join_group', id: group.id, invite_code: group.invite_code
  end
end
