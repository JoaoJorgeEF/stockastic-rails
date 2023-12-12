class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[show update destroy incrementar_quantidade decrementar_quantidade]
  before_action :authenticate_user!

  # GET /produtos
  def index
    @produtos = Produto.by_user(current_user.id).page(params[:page] || 1).per(params[:per_page] || 10)
    authorize! :read, @produtos

    @produtos = @produtos.map do |prod|
      prod.as_json.merge({
        category: prod.category&.nome,
        notifications: prod.notifications.pluck(:mensagem)
      })
    end
    render json: @produtos
  end

  # GET /produtos/1
  def show
    authorize! :read, @produto
    @produto = @produto.as_json.merge({
      category: @produto.category&.nome,
      notifications: @produto.notifications.pluck(:mensagem)
    })
    render json: @produto
  end

  # POST /produtos
  def create
    @produto = Produto.new(produto_params)
    @produto.users << current_user
    authorize! :create, @produto

    @produto.notifications << Notification.new(
      mensagem: "Produto #{@produto.nome} cadastrado com sucesso!"
    )
    @produto.tornar_disponivel
    
    if @produto.save!
      render json: @produto, status: :created, location: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /produtos/1
  def update
    authorize! :update, @produto

    @produto.notifications << Notification.new(
      mensagem: "Produto #{@produto.nome} atualizado com sucesso!"
    )
    if @produto.update(produto_params)
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  def incrementar_quantidade
    authorize! :update, @produto
    
    @produto.incrementar_quantidade(params[:quantidade].to_i)
    if @produto.save!
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  def decrementar_quantidade
    authorize! :update, @produto

    @produto.decrementar_quantidade(params[:quantidade].to_i)
    if @produto.save
      render json: @produto
    else
      render json: @produto.errors, status: :unprocessable_entity
    end
  end

  # DELETE /produtos/1
  def destroy
    authorize! :destroy, @produto
    @produto.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produto_params
      params.require(:produto).permit(:nome, :validade, :descricao, :preco_unitario, :quantidade_atual, :quantidade_minima, :category_id)
    end
end
