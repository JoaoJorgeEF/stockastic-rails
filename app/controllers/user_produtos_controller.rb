class UserProdutosController < ApplicationController
  before_action :set_user_produto, only: %i[ show update destroy ]

  # GET /user_produtos
  def index
    @user_produtos = UserProduto.all

    render json: @user_produtos
  end

  # GET /user_produtos/1
  def show
    render json: @user_produto
  end

  # POST /user_produtos
  def create
    @user_produto = UserProduto.new(user_produto_params)

    if @user_produto.save
      render json: @user_produto, status: :created, location: @user_produto
    else
      render json: @user_produto.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_produtos/1
  def update
    if @user_produto.update(user_produto_params)
      render json: @user_produto
    else
      render json: @user_produto.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_produtos/1
  def destroy
    @user_produto.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_produto
      @user_produto = UserProduto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_produto_params
      params.require(:user_produto).permit(:user_id, :produto_id)
    end
end
