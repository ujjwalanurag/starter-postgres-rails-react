# frozen_string_literal: true

class Api::PostController < Api::BaseController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]

  def index
    @posts = Post.includes(:user).order('id desc')
    render json: @posts
  end

  def create
    @post = current_user.posts.create!(post_params)
    render json: @post
  end

  def show
    render json: @post
  end

  def update
    @post.update!(post_params)
    render json: @post
  end

  def destroy
    @post.discard
    render json: @post.id
  end

  private

  def post_params
    params.permit(:id, :title, :content)
  end

  def set_post
    @post = Post.find_by_id(params[:id])
  end
end
