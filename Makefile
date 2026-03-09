.PHONY: preview build clean deploy new-post help

# Default target
help:
	@echo "Available commands:"
	@echo "  make preview    - Start live preview server"
	@echo "  make build      - Build site for production"
	@echo "  make clean      - Remove built files"
	@echo "  make deploy     - Build and prepare for deployment"
	@echo "  make new-post   - Create a new blog post (requires POST_NAME)"
	@echo ""
	@echo "Examples:"
	@echo "  make preview"
	@echo "  make new-post POST_NAME=my-new-post"
	@echo "  make deploy"

# Start preview server
preview:
	quarto preview

# Build the site
build:
	quarto render

# Clean build artifacts
clean:
	rm -rf docs/
	rm -rf _site/
	rm -rf .quarto/
	rm -rf _freeze/
	@echo "✨ Cleaned build artifacts"

# Build and prepare for deployment
deploy: clean build
	@echo "✅ Site built successfully!"
	@echo "📁 Site files are in _site/ directory"
	@echo ""
	@echo "To deploy:"
	@echo "  - GitHub Pages: commit and push docs/ folder"
	@echo "  - Netlify: drag _site/ folder to netlify.com"
	@echo "  - Quarto Pub: run 'quarto publish quarto-pub'"

# Create a new blog post
new-post:
	@if [ -z "$(POST_NAME)" ]; then \
		echo "❌ Error: POST_NAME required"; \
		echo "Usage: make new-post POST_NAME=my-post-title"; \
		exit 1; \
	fi
	@mkdir -p posts/$(POST_NAME)
	@cp posts/_template.qmd posts/$(POST_NAME)/index.qmd
	@DATE=$$(date +%Y-%m-%d); \
	sed -i.bak "s/YYYY-MM-DD/$$DATE/" posts/$(POST_NAME)/index.qmd && \
	rm posts/$(POST_NAME)/index.qmd.bak
	@echo "✅ Created new post: posts/$(POST_NAME)/index.qmd"
	@echo "📝 Edit the file to add your content"

# Install R dependencies
install-r:
	Rscript -e 'install.packages(c("tidyverse", "here", "broom", "modelsummary", "ggplot2", "patchwork"))'
	@echo "✅ R packages installed"

# Install Python dependencies  
install-python:
	pip install pandas numpy matplotlib seaborn statsmodels scikit-learn
	@echo "✅ Python packages installed"

# Check for broken links
check:
	quarto render
	@echo "✅ Check complete - review console for errors"
