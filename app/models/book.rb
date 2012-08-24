class Book < ActiveRecord::Base
  attr_accessible :author, :pages, :title
end
