class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user! 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordNotSaved, with: :record_not_saved
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_updated

    before_action :configure_permitted_parameters, if: :devise_controller?
    

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name])
        end

    private
        def get_post
            @post = Post.find(params[:id])
        end
        
        def get_comment
            @post = Post.find(params[:post_id])
        end

        def get_user
            @user = User.find(params[:id])
        end

        def record_not_found
            render plain: "404 not found", status:404
        end

        def record_not_saved
            render plain: "409 Coundn't save record", status:409
        end

        def record_not_updated
            render plain: "409 Coundn't update record", status:409
        end
end
