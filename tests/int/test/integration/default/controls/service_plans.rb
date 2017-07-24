title 'Check Service Plans'

control 'azure-service-plan' do

  impact 1.0
  title 'Check that the service has the correct properties'
  json_obj = json('.kitchen/kitchen-terraform/default-azure/terraform.tfstate')
  random_name = json_obj['modules'][0]['outputs']['random_name']['value'] + '-frontend-int'


  # Ensure that the expected resources have been deployed
  describe azure_service_plan(rg_name: random_name, name: random_name) do
    its('location') { should eq 'UK South' }
    its('name') { should eq "#{random_name}" }
    its('ase_name') { should eq 'sandbox-core-infra' }
    its('maximum_number_of_workers') { should eq 3 }
    its('number_of_sites') { should eq 1 }
  end
end

