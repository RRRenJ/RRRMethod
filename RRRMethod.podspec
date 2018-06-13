
Pod::Spec.new do |s|

  s.name         = "RRRMethod"
  s.version      = "0.0.1"
  s.summary      = "个人使用的方法类等汇集"


  s.description  = <<-DESC
                    个人整理的常用方法等汇集
                   DESC

  s.homepage     = "https://github.com/RRRenJ/RRRMethod"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "RRRenJ" => "https://github.com/RRRenJ" }


  s.source       = { :git => "https://github.com/RRRenJ/RRRMethod.git", :tag => s.version }

  s.public_header_files = "RRRMethod/RRRMethod.h"

  s.source_files  = "RRRMethod/*.h"

  s.requires_arc = true

  s.frameworks   = 'UIKit', 'Foundation','Photos'

  s.platform     = :ios, "8.0"


  s.subspec 'FactoryView' do |ss|

  ss.source_files = 'RRRMethod/FactoryView/*'

  end

  s.subspec 'FooterView' do |ss|

  ss.source_files = 'RRRMethod/FooterView/*'
  ss.dependency 'RRRMethod/FactoryView'

  end

  s.subspec 'CountDownMethod' do |ss|

  ss.source_files = 'RRRMethod/CountDownMethod/*.{h,m}'


  end

  s.subspec 'CollcetionFlowLayout' do |ss|

  ss.source_files = 'RRRMethod/CollcetionFlowLayout/*.{h,m}'

  end

  s.subspec 'AVCompress' do |ss|

  ss.source_files = 'RRRMethod/AVCompress/*.{h,m}'


  end

  s.subspec 'RRRMBProgressHUD' do |ss|

  ss.source_files = 'RRRMethod/RRRMBProgressHUD/*'
  ss.dependency 'MBProgressHUD'

  end

end
