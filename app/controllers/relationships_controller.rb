class RelationshipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user
	def create
		
	end

	def destroy
		
	end
	private

	def find_user
		@user = User.find(params[:user_id])
	end
end