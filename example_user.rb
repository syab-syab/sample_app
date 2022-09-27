class User
  # nameとemailにアクセサー(accessor)を作成することで
  # データを取り出すメソッド(getter)と、
  # データに代入するメソッド(setter)が定義される
  # つまりインスタンス変数@name、@emailにアクセスするためのメソッド
  attr_accessor :name, :email

  # initializeはUser.newを実行すると呼び出される
  # 特殊なメソッド
  # 空のハッシュを持つattributesは
  # 名前とアドレスの無いユーザーを作れる
  def initialize(attributes = {})
  # インスタンス変数は頭に「@」
  # attributesにそれぞれキーを指定
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
  # 式や変数は #{変数} で展開
    "#{@name} <#{@email}>"
  end
end