class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[ show edit update destroy add_task add_task_to_group]

  # GET /groups or /groups.json
  def index
    # require login
    if defined?(current_user.groups)
      @groups = current_user.groups
    else
      redirect_to new_user_session_path
    end
    # @groups = current_user.groups
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end

    # Add the current user as a member of the group in table memberships
    Membership.create(user_id: current_user.id, group_id: @group.id)
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_task
  end

  def add_task_to_group
    @task = Task.new
    @task.group_id = params[:id]
    @task.description = params[:description]
    @task.due_date = params[:due_date]
    @task.name = params[:name]
    @task.save
    redirect_to group_url(@task.group_id)
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    # remove all memberships
    @group.memberships.each do |m|
      m.destroy
    end
    # remove all tasks
    @group.tasks.each do |t|
      t.destroy
    end
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def join_group
    #@group = Group.find_by(invite_code: params[:invite_code])
    @group = Group.find_by(invite_code: params[:invite_code])
    begin
      # check if the user is already a member of the group
      if @group.memberships.find_by(user_id: current_user.id) != nil
        # if @group.memberships.find_by(user_id: current_user.id).user_id == current_user.id
          redirect_to group_url(@group), notice: "You are already a member of the group."
        else
          @group.memberships.create(user_id: current_user.id)
          redirect_to group_url(@group), notice: "You are now a member of the group."
        # end
      end
    rescue
      # reload the page with an error message
      redirect_to request.referrer, notice: "Invalid invite code."
    end
  end

  def join_group_p
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :description, :invite_code, :creator_id)
  end
end