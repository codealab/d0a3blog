# encoding: UTF-8
class PaymentsController < ApplicationController
	before_action :pasive_family, only: [:create, :new]

	def index
		@payments = Payment.all.paginate(page: params[:page])
	end

	def create
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:spot_id])
		@payment = @spot.payments.build(payment_params)
		if @spot.save  
	    	flash[:success] = "Pago generado exitosamente"
	    	redirect_to edit_group_spot_path(@group, @spot)
	    else
	      render 'new'
	    end
	end

	def new
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:spot_id])
		@payment = @spot.payments.build
	end

	def edit
		# @group = Group.find(params[:group_id])
		# @spot = Spot.find(params[:spot_id])
		# @payment = @spot.payments.find(params[:id])
	end

	def show
		@payment = Payment.find(params[:id])
	end

	def update
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:spot_id])
		@payment = Payment.find(params[:id])
	    if @payment.update_attributes(payment_params)
	    	flash[:success] = "Actualización Exitosa"
	    	redirect_to group_spot_path(@group, @spot)
	    else
	    	render 'edit'
	    end
	end

	def destroy
		# @group = Group.find(params[:group_id])
		# @spot = Spot.find(params[:spot_id])
		# Payment.find(params[:id]).destroy
		# flash[:success] = "Pago borrado"
		# redirect_to group_spot_path(@group, @spot)
	end

	def search
		init_date = (params[:init][0]).to_date
		ended_date = (params[:end][0]).to_date

		@payments = Payment.all

		if params[:group_id]
			@group = Group.find_by_id(params[:group_id])
		end
		if @group
			@payments = @group.payments
		end
		if init_date && ended_date
			@payments = @payments.where("date >= :start_date AND date<= :end_date ", { start_date: init_date, end_date: ended_date })
		end
		if init_date && !ended_date
			@payments = @payments.where("date >= :start_date", { start_date: init_date })
		end
		if !init_date && ended_date
			@payments = @payments.where("date<= :end_date ", { end_date: ended_date })
		end
	end

	private

	# def convert_date(hash)
	# 	if hash['(1i)'] != '' && hash['(2i)'] != '' && hash['(3i)'] != ''
	#     	return Date.new(hash['(1i)'].to_i, hash['(2i)'].to_i, hash['(3i)'].to_i)
	#     else
	#     	return false
	#     end
	# end

	def payment_params
      params.require(:payment).permit( :date, :scholarship, :amount, :clarification )
    end

   	def pasive_family
		@spot = Spot.find(params[:spot_id])
		@group = Group.find(params[:group_id])
		redirect_to(group_spot_path(@group,@spot)) unless @spot.child.family_relations.first.family.status?
	end

end