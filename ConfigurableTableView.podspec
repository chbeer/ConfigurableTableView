Pod::Spec.new do |s|
  s.name         = "ConfigurableTableView"
  s.version      = "1.3"
  s.summary      = "UITableViewDataSource and -Delegate that defines the sections and cells in the table using a lightweight data model."
  s.homepage     = "https://github.com/chbeer/ConfigurableTableView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Christian Beer" => "christian.beer@chbeer.de" }
  s.source       = { :git => "https://github.com/chbeer/ConfigurableTableView.git", :tag => s.version.to_s }
  s.platform     = :ios, '6.1'
  s.source_files = 'src/**/*.{h,m}'
  s.requires_arc = true
end