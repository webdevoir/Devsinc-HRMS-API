# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
print 'Creating Companies...'
companies = [
    { name: 'Devsinc', custom_domain: 'devsinc.com', subdomain: 'devsinc' }
].map { |c| print '.'; Company.find_or_create_by(c) }
puts "\n"

print 'Creating Departments...'
company = Company.first
departments = [
    { name: 'Account Owner', description: 'Account Owner' },
    { name: 'Administration', description: 'Department for Admins' },
    { name: 'Management', description: 'Department for Management' },
    { name: 'Software Engineering', description: 'Department of Software Engineering' },
    { name: 'Accounts Office', description: 'Department for Accounts' },
    { name: 'Human Resource', description: 'Department for Human Resource' },
    { name: 'Event Operations', description: 'Department for Event Operations' }
].map { |u| print '.'; company.departments.find_or_create_by!(u) { |m| m.assign_attributes(u) } }

print 'Creating Users'
pass = { password: 'pass1234', password_confirmation: 'pass1234' }
users = [
    { first_name: 'Account',last_name: 'Owner', email: 'admin@devsinc.com', company_id: companies[0].id, reporting_to: 1, buddy_id: 1, join_date: Date.new , confirmed_at: Time.now, title: "Account Owner"},
    # { first_name: 'Jawad',last_name: 'Firdous', email: 'jawad.firdous@devsinc.com', company_id: companies[0].id, reporting_to: 1, buddy_id: 1, join_date: Date.new, confirmed_at: Time.now},
    # { first_name: 'Faisal',last_name: 'Waleed', email: 'faisal.waleed@devsinc.com', company_id: companies[0].id,reporting_to: 1, buddy_id: 1, join_date: Date.new, confirmed_at: Time.now },
    # { first_name: 'Salman',last_name: 'Ali', email: 'salman.ali@devsinc.com', company_id: companies[0].id , reporting_to: 1, buddy_id: 1, join_date: Date.new, confirmed_at: Time.now},
    # { first_name: 'Usama',last_name: 'Kamran', email: 'usama.kamran@devsinc.com', company_id: companies[0].id,reporting_to: 2, buddy_id: 2, join_date: Date.new, confirmed_at: Time.now},
    # { first_name: 'Aqib',last_name: 'Butt', email: 'aqib.butt@devsinc.com', company_id: companies[0].id ,reporting_to: 2, buddy_id: 2, join_date: Date.new, confirmed_at: Time.now},
    # { first_name: 'Usman',last_name: 'Asif', email: 'usman.asif@devsinc.com', company_id: companies[0].id ,reporting_to: 1, buddy_id: 1, join_date: Date.new , confirmed_at: Time.now }
].map do |u|
  print '.'
  User.find_or_create_by!(u) { |u| u.assign_attributes(pass) }
end

############   Configurations

#VALUES SPECIFIED IN DAYS
Configuration.find_or_create_by(key: "ANNUAL_LEAVES", value: "14")
Configuration.find_or_create_by(key: "SICK_LEAVES_PAID", value: "10")
Configuration.find_or_create_by(key: "SICK_LEAVES_HALF_PAID", value: "20")
Configuration.find_or_create_by(key: "SICK_LEAVES_UNPAID", value: "30")
Configuration.find_or_create_by(key: "COMPENSATION_LEAVE", value: "3")


############   Module UsersController/Devise Permissions
Permission.find_or_create_by(name: "users_index", description: "Manage Users Index Page", group: "Users", display_name: "View all People" )
Permission.find_or_create_by(name: "users_update", description: "Update User", group: "Users", display_name: "Update Profile" )
Permission.find_or_create_by(name: "users_show", description: "View User Profile", group: "Users", display_name: "View Profiles")
Permission.find_or_create_by(name: "users_create", description: "Create New User ", group: "Users", display_name: "Invite New Users")
Permission.find_or_create_by(name: "users_update_all", description: "Update Other Users", group: "Users", display_name: "Update Other Users' Profiles")
Permission.find_or_create_by(name: "users_destroy", description: "Destroy User", group: "Users" , display_name: "Block Users" )
Permission.find_or_create_by(name: "users_restore_user", description: "Unblock Users", group: "Users", display_name: "Unblock Users")


############   Module DepartmentsController Permissions
Permission.find_or_create_by(name: "departments_index", description: "Departments Index Page", group: "Department", display_name: "View Departments")
Permission.find_or_create_by(name: "departments_create", description: "Create New Department", group: "Department", display_name: "Create Departments")
Permission.find_or_create_by(name: "departments_update", description: "Update Department", group: "Department", display_name: "Update Departments")
Permission.find_or_create_by(name: "departments_show", description: "Show Department", group: "Department", display_name: "Show Departments")
Permission.find_or_create_by(name: "departments_destroy", description: "Delete Department", group: "Department", display_name: "Delete Departments")


############   Module RolesController Permissions
Permission.find_or_create_by(name: "roles_index", description: "Roles Index Page", group: "Roles", display_name: "View Roles")
Permission.find_or_create_by(name: "roles_create", description: "Create New Role", group: "Roles", display_name: "Create Role")
Permission.find_or_create_by(name: "roles_edit", description: "Edit Role", group: "Roles", display_name: "Edit Roles")
Permission.find_or_create_by(name: "roles_update", description: "Update Role", group: "Roles", display_name: "Update Roles")
Permission.find_or_create_by(name: "roles_destroy", description: "Delete Role", group: "Roles", display_name: "Delete Roles")
Permission.find_or_create_by(name: "roles_show", description: "show Role", group: "Roles", display_name: "Show Roles")
Permission.find_or_create_by(name: "roles_assignable_users", description: "Get Assignable Users", group: "Roles", display_name: "Show Assignable Users for role")
Permission.find_or_create_by(name: "roles_add_users", description: "Add User to Role", group: "Roles", display_name: "Assign Roles to Users")
Permission.find_or_create_by(name: "roles_remove_user", description: "Remove User from Role", group: "Roles", display_name: "Revoke Roles from Users")
############   Sub-Module RolesController  Permissions
Permission.find_or_create_by(name: "roles_allow_permission", description: "Can allow Permission", group: "Permissions" , display_name: "Give Permission to Roles")
Permission.find_or_create_by(name: "roles_revoke_permission", description: "Can revoke Permission", group: "Permissions" , display_name: "Revoke Permission from Roles")


############   Module CommentsController Permissions
Permission.find_or_create_by(name: "comments_index", description: "Load Ticket Comments", group: "Comments" , display_name: "View Ticket Comments")
Permission.find_or_create_by(name: "comments_create", description: "Create Ticket Comments", group: "Comments" , display_name: "Create Ticket Comments")


############   Leaves LeavesStatusesController Permissions
Permission.find_or_create_by(name: "leave_statuses_create", description: "Create Leave Status", group: "Leaves", display_name: "Create Leave Statuses")
Permission.find_or_create_by(name: "leave_statuses_index", description: "Leave Life-cycle", group: "Leaves" , display_name: "View Leaves' Lifecycles")


############   Leaves LeavesController Permissions
Permission.find_or_create_by(name: "leaves_index", description: "Leaves Index Page", group: "Leaves", display_name: "View Leaves")
Permission.find_or_create_by(name: "leaves_leave_approvals", description: "Leave Approvals", group: "Leaves", display_name: "View Leave Approvals")
Permission.find_or_create_by(name: "leaves_create", description: "Create New Leave", group: "Leaves", display_name: "Create New Leaves")
Permission.find_or_create_by(name: "leaves_user_leaves_history", description: "User Leave History", group: "Leaves", display_name: "View User Leave Summary")
Permission.find_or_create_by(name: "leaves_all_leaves", description: "All Users' Leaves", group: "Leaves", display_name: "View All Users' Leave History")
Permission.find_or_create_by(name: "leaves_get_user_leaves", description: "Get Other User Leaves", group: "Leaves", display_name: "View Other Users' Leaves")

############   Module TicketsController  Permissions
Permission.find_or_create_by(name: "tickets_index", description: "Tickets Index Page", group: "Tickets", display_name: "View Tickets")
Permission.find_or_create_by(name: "tickets_assigned", description: "Assigned Tickets", group: "Tickets", display_name: "Assigned Tickets")
Permission.find_or_create_by(name: "tickets_create", description: "Create New Ticket", group: "Tickets", display_name: "Create Ticket")
Permission.find_or_create_by(name: "tickets_update", description: "Update Ticket", group: "Tickets", display_name: "Update Tickets")
Permission.find_or_create_by(name: "tickets_ticket_option", description: "Options For Tickets", group: "Tickets", display_name: "Add Ticket Options")
Permission.find_or_create_by(name: "tickets_statuses", description: "Tickets Statuses", group: "Tickets" , display_name: "View Ticket Statuses")
Permission.find_or_create_by(name: "tickets_all_tickets", description: "Tickets All Tickets", group: "Tickets" , display_name: "View All Tickets")

roles = ["New Hiring","Advanced","Account Owner","Human Resource"]

roles.each do |role|
  Role.find_or_create_by(title: role, department_id: 1)
end


Role.find_by(title: 'Account Owner').permissions << Permission.all

User.first.roles << Role.find_by(title: 'Account Owner')
User.all.update(tokens: nil)
