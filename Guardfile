# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', {
    :all_on_start => true,
    :all_after_pass => false,
    :keep_failed => true,
    :spec_paths => ["spec"],
    :cli => '--color',
    :bundler => true,
    :version => 2
  } do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

