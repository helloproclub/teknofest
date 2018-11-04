class CandidatesController < ApplicationController
  before_action :redirect_if_not_candidate,
    only: [:index, :logout]
  before_action :redirect_if_logged_in,
    only: [:new, :create, :login, :login_validation]

  def index
  end

  def new
  end

  def create
    @candidate = Candidate.new candidate_params

    if @candidate.save(context: :register)
      create_session @candidate

      redirect_to candidate_dashboard_path
    else
      render 'new'
    end
  end

  def login
  end

  def login_validation
    @candidate = Candidate.new candidate_login_params

    if @candidate.valid? :login
      login_params = candidate_login_params

      @candidate = Candidate.find_by(username: login_params['username'])

      if @candidate and @candidate.authenticate(login_params['password'])
        create_session @candidate

        redirect_to candidate_login_get_path
      else
        @candidate = Candidate.new
        @candidate.errors.messages[:account] = [
          "credentials invalid or it is doesn't exists"
        ]

        render 'login'
      end
    else
      render 'login'
    end
  end

  def logout
    session.delete :user_type
    session.delete :user_data

    redirect_to candidate_login_get_path
  end

  private
    def candidate_params
      params.require(:candidate).permit :username, :fullname, :password
    end

    def candidate_login_params
      params.require(:candidate).permit :username, :password
    end

    def create_session(candidate)
      session[:user_type] = 'candidate'
      session[:user_data] = {
        username: candidate[:username],
        fullname: candidate[:fullname],
      }
    end

    def redirect_if_logged_in
      unless session[:user_type].nil?
        if session[:user_type] == 'candidate'
          redirect_to candidate_dashboard_path
        else
          redirect_to mentor_dashboard_path
        end
      end
    end

    def redirect_if_not_candidate
      if session[:user_type].nil?
        redirect_to candidate_login_get_path
      elsif session[:user_type] == 'mentor'
        redirect_to mentor_dashboard_path
      end
    end
end

