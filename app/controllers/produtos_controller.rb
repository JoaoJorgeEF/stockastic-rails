class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[ show update destroy incrementar_quantidade decrementar_quantidade]

  # GET /produtos
  def index
    @produtos = Produto.all

    render json: @produtos
  end

  # GET /produtos/1
  def show
    render json: @produto
  end

  # POST /produtos
  def create
    @produto = Produto.new(produto_params)

    if @produto.save
      render json: @produto, status: :created, location: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /produtos/1
  def update
    if @produto.update(produto_params)
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  def incrementar_quantidade
    @produto.incrementar_quantidade(params[:quantidade])
    if @produto.save
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  def decrementar_quantidade
    @produto.decrementar_quantidade(params[:quantidade])
    if @produto.save
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  # DELETE /produtos/1
  def destroy
    @produto.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produto_params
      params.require(:produto).permit(:nome, :validade, :descricao, :preco_unitario, :quantidade_minima)
    end
end
