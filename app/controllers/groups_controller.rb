class GroupsController < ApplicationController
  before_filter :authenticate!
  
  def index
    response = api.memberships.index({
      channel_id: @restpack.channel.id,
      user_id: @restpack.user_id
    })
    @users = response[:users]
    @groups = response[:groups]
  end
  
  def new
  end
  
  def show
    @response = api.groups.show(params[:id])
    @group = @response[:group]
  end
  
  def create
    begin #TODO: GJ: handle exceptions in client 
      api.groups.create({
        :channel_id => @restpack.channel.id,
        :created_by_user_id => @restpack.user_id,
        :requires_invitation => true,
        :name => params[:name],
        :description => params[:description]
      })

      flash[:success] = "Group was created"
      redirect_to :action => 'index'
    rescue
      flash[:error] = "An error accured"
      render :action => :new
    end
  end
  
  def join
    begin #TODO: GJ: handle exceptions in client 
      api.invitations.accept({
        :channel_id => @restpack.channel.id,
        :user_id => @restpack.user_id,
        :access_key => params[:access_key]
      })
      flash[:success] = "Welcome to the Group"
    rescue
      flash[:error] = "Invalid Invitation"
    end
    
    redirect_to :action => 'index'
  end  
end