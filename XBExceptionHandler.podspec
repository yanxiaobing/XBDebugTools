Pod::Spec.new do |s|
    s.name         = 'XBExceptionHandler'
    s.version      = '1.0.1'
    s.summary      = 'Catch Crash Exception'
    s.homepage     = 'https://github.com/yanxiaobing/XBExceptionHandler'
    s.license      = 'MIT'
    s.authors      = {'Xingo' => 'dove025@qq.com'}
    s.platform     = :ios, '6.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/XBExceptionHandler.git', :tag => s.version}
    s.source_files = 'XBExceptionHandler/*.{h,m}'
    s.requires_arc = true
end