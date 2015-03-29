Rails.application.routes.draw do

  # Documentation
  mount GrapeSwaggerRails::Engine => '/documentation' if  Rails.env =~ /development/

end
