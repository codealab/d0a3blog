# encoding: UTF-8
class PaymentsController < ApplicationController
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
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:spot_id])
		@payment = @spot.payments.find(params[:id])
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
		@group = Group.find(params[:group_id])
		@spot = Spot.find(params[:spot_id])
		Payment.find(params[:id]).destroy
		flash[:success] = "Pago borrado"
		redirect_to group_spot_path(@group, @spot)
	end

	private

	def payment_params
      params.require(:payment).permit( :date, :spot_id, :scholarship, :amount )
    end

end