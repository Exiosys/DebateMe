class ReportsController < ApplicationController
  before_action :set_report, only: [:update, :destroy, :show]
  before_action :is_admin, except: [:create, :update]

  # GET /reports
  def index
    @reports = Report.all
    json_response(@reports)
  end

  # POST /reports
  def create
    params = report_params
    params[:user_id] = current_user.id
    report = Report.create!(params)
    json_response(report, :created)
  end

  # GET /reports/:id
  def show
    json_response(@report)
  end

  # PUT /reports/:id
  def update
    if @report.user == current_user or current_user.isAdmin
      @report.update(report_params)
      head :no_content
    else
      head :forbidden
    end
  end

  # DELETE /reports/:id
  def destroy
    @report.destroy
    head :no_content
  end

  private

  def report_params
    params.permit(:reason, :message, :post_id)
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def is_admin
    head :forbidden unless current_user.isAdmin
  end
end
