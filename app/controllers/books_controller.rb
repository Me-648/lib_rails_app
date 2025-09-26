class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update  borrow return_book destroy ]
  before_action :require_admin, only: %i[new create edit update
  destroy]

  # GET /books or /books.json
  def index
    @books = Book.all
    
    # フリーワード検索
    if params[:q].present?
      keyword = "%#{params[:q]}%"
      @books = @books.where("title LIKE ? OR author LIKE ?", keyword, keyword)
    end

    # カテゴリで絞り込み
    if params[:category].present?
      @books = @books.where(category: params[:category])
    end
  end

  # GET /books/1 or /books/1.json
  def show
    # ログイン中ユーザが今借りているLoanを取得(返却してないものだけ)
    @loan = @book.loans.find_by(user: current_user, returned_at: nil)
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def borrow
    # 在庫が残っていれば貸出可能
    if @book.loans.where(returned_at: nil).count < @book.total_copies
      Loan.create!(
        user: current_user,
        book: @book,
        borrowed_at: Time.current,
        due_at: 2.weeks.from_now
      )
      redirect_to @book, notice: "貸出処理が完了しました。"
    else
      redirect_to @book, alert: "在庫がありません"
    end
  end

  def return_book
    # 現在のユーザが借りているLoanを見つけて返却処理
    loan = @book.loans.find_by(user: current_user, returned_at: nil)
    if loan
      loan.update!(returned_at: Time.current)
      redirect_to @book, notice: "本を返却しました"
    else
      redirect_to @book, alert: "返却できる本がありません"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.expect(book: [ :title, :author, :isbn, :category, :total_copies ])
    end
    
    def require_admin
      redirect_to root_path, alert: "権限がありません" unless current_user&.admin?
    end
end
