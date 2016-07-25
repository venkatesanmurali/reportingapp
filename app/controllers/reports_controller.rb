class ReportsController < ApplicationController
	before_filter :signed_in_user

	def create
		@report = current_user.reports.build(params[:report])
		if @report.save
			flash[:success] = "Report posted!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy

	end
end