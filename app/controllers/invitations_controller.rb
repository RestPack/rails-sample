class InvitationsController < ApplicationController
  before_filter :authenticate!

  def index

  end

  def new
    @group = api.groups.show(params[:group_id])[:group]
  end

  def show

  end

  def create
    begin #TODO: GJ: handle exceptions in client 
      api.invitations.create({
        :channel_id => @restpack.channel.id,
        :inviter_id => @restpack.user_id,
        :invitee_id => params[:invitee_id],
        :group_id => params[:group_id],
        :access_key_length => params[:access_key_length],
        :remaining_uses => params[:remaining_uses]
      })

      flash[:success] = "Invitation was created"
      redirect_to "/groups/#{params['group_id']}"
    rescue
      flash[:error] = "An error accured"
      render :action => :new
    end
  end

end