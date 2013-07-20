namespace "c" do
  task :spec, [:target] do |t, args|
    args.with_defaults target: "spec"
    sh "rspec #{ args.target } -f documentation"
  end
end
