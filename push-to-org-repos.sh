#!/bin/bash

# Script to push code from temporary repositories to Veltiscapital organization repositories
# Usage: ./push-to-org-repos.sh

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install Git and try again."
    exit 1
fi

# Function to push a repository to the organization
push_repo() {
    local temp_repo=$1
    local org_repo=$2
    
    echo "Pushing $temp_repo to Veltiscapital/$org_repo..."
    
    # Clone the temporary repository
    git clone https://github.com/rodrigomacias/$temp_repo.git temp_clone
    cd temp_clone
    
    # Add the organization repository as a remote
    git remote add organization https://github.com/Veltiscapital/$org_repo.git
    
    # Push to the organization repository
    if git push -f organization main:main; then
        echo "Successfully pushed $temp_repo to Veltiscapital/$org_repo"
    else
        echo "Failed to push $temp_repo to Veltiscapital/$org_repo"
        echo "Make sure you have the necessary permissions and the repository exists."
    fi
    
    # Clean up
    cd ..
    rm -rf temp_clone
}

# Main execution
echo "Starting to push repositories to Veltiscapital organization..."

# Push each repository
push_repo "veltis-frontend-temp" "veltis-frontend"
push_repo "veltis-backend-temp" "veltis-backend"
push_repo "veltis-contracts-temp" "veltis-contracts"
push_repo "veltis-docs-temp" "veltis-docs"
push_repo "veltis-project-temp" "veltis-project"

echo "All repositories have been pushed to the Veltiscapital organization."
echo "Next steps:"
echo "1. Set up CI/CD pipelines for each repository"
echo "2. Configure environment variables in deployment platforms"
echo "3. Set up branch protection rules in GitHub"
echo "4. Invite team members to the organization"

exit 0