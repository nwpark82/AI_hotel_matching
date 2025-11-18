# CLAUDE.md - AI Hotel Matching Project

This document provides comprehensive guidance for AI assistants working on the AI Hotel Matching codebase. It covers project structure, development workflows, coding conventions, and key concepts.

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Codebase Structure](#codebase-structure)
3. [Technology Stack](#technology-stack)
4. [Development Setup](#development-setup)
5. [Development Workflow](#development-workflow)
6. [Coding Conventions](#coding-conventions)
7. [Testing Strategy](#testing-strategy)
8. [Key Concepts & Architecture](#key-concepts--architecture)
9. [Common Tasks](#common-tasks)
10. [AI Assistant Guidelines](#ai-assistant-guidelines)

---

## 🎯 Project Overview

**AI Hotel Matching** is an intelligent system designed to match hotels with user preferences, requirements, and context using machine learning and data processing techniques.

### Core Objectives
- **Intelligent Matching**: Use AI/ML algorithms to match hotels with user criteria
- **Data Processing**: Handle and process hotel data from multiple sources
- **API Integration**: Provide RESTful APIs for hotel search and matching
- **Scalability**: Design for high-volume queries and large datasets

### Key Features (Planned)
- Natural language query processing
- Multi-criteria matching (price, location, amenities, reviews)
- Semantic search capabilities
- Rating and review analysis
- Personalized recommendations
- Real-time availability checking

---

## 📁 Codebase Structure

The recommended project structure follows industry best practices:

```
AI_hotel_matching/
├── .github/
│   ├── workflows/          # CI/CD pipelines
│   └── ISSUE_TEMPLATE/     # Issue templates
├── docs/
│   ├── api/                # API documentation
│   ├── architecture/       # Architecture diagrams and docs
│   └── guides/             # Development guides
├── src/
│   ├── api/                # API layer (REST/GraphQL)
│   │   ├── routes/         # Route handlers
│   │   ├── controllers/    # Business logic controllers
│   │   └── middleware/     # Auth, validation, etc.
│   ├── models/             # Data models and schemas
│   │   ├── hotel.py/ts     # Hotel data model
│   │   ├── user.py/ts      # User preferences model
│   │   └── matching.py/ts  # Matching criteria model
│   ├── ml/                 # Machine learning components
│   │   ├── embeddings/     # Text/feature embeddings
│   │   ├── matching/       # Matching algorithms
│   │   ├── ranking/        # Ranking models
│   │   └── training/       # Model training scripts
│   ├── data/               # Data processing
│   │   ├── ingestion/      # Data ingestion pipelines
│   │   ├── preprocessing/  # Data cleaning and transformation
│   │   └── validation/     # Data validation
│   ├── services/           # Business logic services
│   │   ├── search.py/ts    # Search service
│   │   ├── matching.py/ts  # Matching service
│   │   └── recommendations.py/ts
│   ├── utils/              # Utility functions
│   │   ├── logger.py/ts    # Logging utilities
│   │   ├── config.py/ts    # Configuration management
│   │   └── helpers.py/ts   # Helper functions
│   └── database/           # Database layer
│       ├── migrations/     # Database migrations
│       ├── queries/        # Common queries
│       └── connection.py/ts
├── tests/
│   ├── unit/               # Unit tests
│   ├── integration/        # Integration tests
│   ├── e2e/                # End-to-end tests
│   └── fixtures/           # Test fixtures and mocks
├── scripts/
│   ├── setup.sh            # Setup script
│   ├── train_model.py      # Model training
│   └── seed_data.py        # Database seeding
├── config/
│   ├── development.yaml    # Dev configuration
│   ├── production.yaml     # Prod configuration
│   └── test.yaml           # Test configuration
├── data/                   # Data directory (gitignored)
│   ├── raw/                # Raw data
│   ├── processed/          # Processed data
│   └── models/             # Trained models
├── .env.example            # Environment variables template
├── .gitignore
├── README.md
├── CLAUDE.md               # This file
├── CONTRIBUTING.md
├── LICENSE
└── requirements.txt / package.json

```

---

## 🛠 Technology Stack

### Primary Options

#### Option 1: Python Stack (Recommended for ML-heavy)
- **Language**: Python 3.10+
- **Web Framework**: FastAPI or Flask
- **ML/AI**:
  - PyTorch or TensorFlow for deep learning
  - scikit-learn for traditional ML
  - Sentence Transformers for embeddings
  - LangChain for LLM integration
- **Database**: PostgreSQL with pgvector for similarity search
- **Caching**: Redis
- **Task Queue**: Celery
- **Testing**: pytest, pytest-asyncio
- **Linting**: ruff, black, mypy

#### Option 2: TypeScript Stack (Recommended for API-heavy)
- **Language**: TypeScript 5.0+
- **Runtime**: Node.js 20+
- **Web Framework**: Express.js or Fastify
- **ML Integration**:
  - TensorFlow.js
  - Python microservices for heavy ML
- **Database**: PostgreSQL with pgvector
- **ORM**: Prisma or TypeORM
- **Testing**: Jest, Vitest
- **Linting**: ESLint, Prettier

### Supporting Technologies
- **Vector Database**: Pinecone, Weaviate, or pgvector
- **API Documentation**: OpenAPI/Swagger
- **Containerization**: Docker, Docker Compose
- **Orchestration**: Kubernetes (production)
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus, Grafana
- **Logging**: ELK Stack or Loki

---

## 🚀 Development Setup

### Prerequisites
- Python 3.10+ or Node.js 20+ (depending on stack choice)
- PostgreSQL 14+
- Redis 6+
- Docker and Docker Compose
- Git

### Initial Setup

```bash
# Clone the repository
git clone <repository-url>
cd AI_hotel_matching

# Copy environment variables
cp .env.example .env

# Edit .env with your configuration
nano .env

# For Python:
python -m venv venv
source venv/bin/activate  # or `venv\Scripts\activate` on Windows
pip install -r requirements.txt
pip install -r requirements-dev.txt

# For Node.js:
npm install

# Start dependencies with Docker
docker-compose up -d postgres redis

# Run database migrations
# Python: alembic upgrade head
# Node.js: npx prisma migrate dev

# Seed initial data (optional)
python scripts/seed_data.py  # or npm run seed

# Start development server
# Python: uvicorn src.main:app --reload
# Node.js: npm run dev
```

---

## 🔄 Development Workflow

### Branch Strategy
- **main**: Production-ready code
- **develop**: Integration branch for features
- **feature/***: Feature development branches
- **bugfix/***: Bug fix branches
- **hotfix/***: Production hotfixes
- **claude/***: AI assistant work branches (auto-generated)

### Commit Convention
Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks
- `ci`: CI/CD changes

**Examples:**
```
feat(matching): add semantic similarity scoring

Implemented cosine similarity between hotel embeddings and user query
embeddings using sentence-transformers.

Closes #123
```

### Pull Request Process
1. Create feature branch from `develop`
2. Implement changes with tests
3. Ensure all tests pass locally
4. Update documentation if needed
5. Create PR with descriptive title and body
6. Address review comments
7. Squash and merge when approved

---

## 📝 Coding Conventions

### General Principles
- **DRY (Don't Repeat Yourself)**: Avoid code duplication
- **SOLID**: Follow SOLID principles
- **KISS (Keep It Simple, Stupid)**: Prefer simple solutions
- **YAGNI (You Aren't Gonna Need It)**: Don't add unused features

### Python Conventions
- Follow PEP 8 style guide
- Use type hints for all functions
- Maximum line length: 100 characters
- Use docstrings (Google style) for all public functions/classes
- Prefer f-strings for string formatting

```python
from typing import List, Optional
from pydantic import BaseModel

class Hotel(BaseModel):
    """Represents a hotel entity.

    Attributes:
        id: Unique identifier
        name: Hotel name
        location: Geographic coordinates
        rating: Average rating (0-5)
    """
    id: str
    name: str
    location: tuple[float, float]
    rating: float

    def calculate_score(self, user_prefs: dict) -> float:
        """Calculate matching score based on user preferences.

        Args:
            user_prefs: Dictionary of user preferences

        Returns:
            Matching score between 0 and 1
        """
        # Implementation
        pass
```

### TypeScript Conventions
- Use strict mode
- Prefer interfaces over types for objects
- Use async/await over promises
- Avoid `any` type
- Use meaningful variable names

```typescript
interface Hotel {
  id: string;
  name: string;
  location: {
    latitude: number;
    longitude: number;
  };
  rating: number;
}

interface UserPreferences {
  maxPrice?: number;
  location?: string;
  amenities?: string[];
}

/**
 * Calculate matching score between hotel and user preferences
 */
async function calculateMatchingScore(
  hotel: Hotel,
  preferences: UserPreferences
): Promise<number> {
  // Implementation
  return 0.0;
}
```

### Database Conventions
- Use snake_case for table and column names
- Always include `created_at` and `updated_at` timestamps
- Use UUIDs for primary keys when appropriate
- Add indexes for frequently queried columns
- Use migrations for all schema changes

### API Conventions
- RESTful endpoint naming: use nouns, not verbs
- Use proper HTTP methods (GET, POST, PUT, PATCH, DELETE)
- Version your APIs: `/api/v1/hotels`
- Return consistent error responses
- Include pagination for list endpoints
- Use HTTP status codes correctly

```python
# Good
GET    /api/v1/hotels          # List hotels
GET    /api/v1/hotels/{id}     # Get hotel
POST   /api/v1/hotels          # Create hotel
PUT    /api/v1/hotels/{id}     # Update hotel (full)
PATCH  /api/v1/hotels/{id}     # Update hotel (partial)
DELETE /api/v1/hotels/{id}     # Delete hotel
POST   /api/v1/hotels/search   # Search hotels (POST for complex queries)

# Bad
GET  /api/v1/getHotels
POST /api/v1/createHotel
```

---

## 🧪 Testing Strategy

### Test Coverage Goals
- **Unit Tests**: >80% code coverage
- **Integration Tests**: Critical paths covered
- **E2E Tests**: Main user journeys covered

### Testing Pyramid
```
    /\
   /E2E\      <- Few, slow, high-level
  /______\
 /Integra-\   <- Some, medium speed
/___tion___\
/___Unit____\ <- Many, fast, low-level
```

### Test Organization
- Mirror `src/` structure in `tests/`
- One test file per source file
- Group related tests in classes/describe blocks
- Use descriptive test names

### Python Testing Example
```python
import pytest
from src.services.matching import MatchingService

class TestMatchingService:
    @pytest.fixture
    def service(self):
        return MatchingService()

    @pytest.fixture
    def sample_hotel(self):
        return {
            "id": "123",
            "name": "Test Hotel",
            "rating": 4.5
        }

    def test_calculate_score_with_valid_input(self, service, sample_hotel):
        """Should return score between 0 and 1 for valid input."""
        user_prefs = {"min_rating": 4.0}
        score = service.calculate_score(sample_hotel, user_prefs)

        assert 0.0 <= score <= 1.0
        assert score > 0.5  # Should match preferences

    def test_calculate_score_with_no_preferences(self, service, sample_hotel):
        """Should handle empty preferences gracefully."""
        score = service.calculate_score(sample_hotel, {})
        assert score == 0.5  # Default/neutral score
```

### Running Tests
```bash
# Python
pytest                           # Run all tests
pytest tests/unit               # Run unit tests only
pytest --cov=src --cov-report=html  # With coverage

# Node.js
npm test                        # Run all tests
npm run test:unit              # Run unit tests only
npm run test:coverage          # With coverage
```

---

## 🏗 Key Concepts & Architecture

### Matching Algorithm Architecture

The system uses a multi-stage matching pipeline:

1. **Query Processing**
   - Parse user input (natural language or structured)
   - Extract key features (location, price range, dates, amenities)
   - Generate query embeddings

2. **Candidate Retrieval**
   - Fast filtering based on hard constraints
   - Vector similarity search for semantic matching
   - Retrieve top-k candidates

3. **Ranking**
   - Apply ML ranking model
   - Consider multiple factors: relevance, price, rating, availability
   - Personalization based on user history

4. **Post-processing**
   - Diversification to avoid similar results
   - Apply business rules
   - Format and return results

### Data Models

#### Hotel Model
```python
{
  "id": "uuid",
  "name": "string",
  "description": "string",
  "location": {
    "latitude": float,
    "longitude": float,
    "address": "string",
    "city": "string",
    "country": "string"
  },
  "price_range": {
    "min": int,
    "max": int,
    "currency": "string"
  },
  "rating": {
    "average": float,
    "count": int
  },
  "amenities": ["string"],
  "room_types": [
    {
      "type": "string",
      "price": int,
      "available": boolean
    }
  ],
  "images": ["url"],
  "embedding": [float],  # 768-dim vector
  "created_at": "datetime",
  "updated_at": "datetime"
}
```

#### User Query Model
```python
{
  "query": "string",  # Natural language query
  "filters": {
    "location": "string",
    "check_in": "date",
    "check_out": "date",
    "guests": int,
    "price_range": {
      "min": int,
      "max": int
    },
    "rating": float,
    "amenities": ["string"]
  },
  "preferences": {
    "style": ["string"],  # luxury, budget, boutique
    "purpose": "string"    # business, leisure, family
  },
  "embedding": [float],
  "user_id": "uuid"
}
```

### Embedding Strategy

Use sentence-transformers or similar to generate embeddings:
- **Hotel embeddings**: Combine name, description, amenities, reviews
- **Query embeddings**: Process user input text
- **Similarity**: Cosine similarity in embedding space
- **Storage**: pgvector or dedicated vector DB

### Caching Strategy

- **L1 Cache**: In-memory (Redis) for hot data
  - Popular hotel details
  - Recent search results (keyed by query hash)
  - User sessions
- **L2 Cache**: Database query cache
- **TTL**:
  - Hotel details: 1 hour
  - Search results: 15 minutes
  - Availability: 5 minutes

---

## 🔧 Common Tasks

### Adding a New API Endpoint

1. Define route in `src/api/routes/`
2. Implement controller in `src/api/controllers/`
3. Add validation schema in `src/models/`
4. Implement business logic in `src/services/`
5. Add unit tests
6. Add integration tests
7. Update API documentation

### Adding a New Matching Feature

1. Design feature in `docs/architecture/`
2. Implement in `src/ml/matching/`
3. Add configuration in `config/`
4. Update model training if needed
5. Add feature tests
6. Update matching service
7. Benchmark performance

### Training/Updating ML Models

```bash
# Prepare training data
python scripts/prepare_training_data.py

# Train model
python src/ml/training/train_ranking_model.py \
  --config config/model_config.yaml \
  --data data/processed/training_data.parquet \
  --output data/models/ranking_v2.pkl

# Evaluate model
python src/ml/training/evaluate_model.py \
  --model data/models/ranking_v2.pkl \
  --test-data data/processed/test_data.parquet

# Deploy model (update path in config)
```

### Database Migrations

```bash
# Python (Alembic)
alembic revision -m "add hotel amenities table"
# Edit migration file
alembic upgrade head

# Node.js (Prisma)
npx prisma migrate dev --name add_hotel_amenities
```

---

## 🤖 AI Assistant Guidelines

### When Working on This Codebase

1. **Understand Before Changing**
   - Read relevant code and documentation first
   - Use the Task tool with Explore agent for unfamiliar areas
   - Check existing patterns and follow them

2. **Maintain Consistency**
   - Follow established coding conventions
   - Match the style of surrounding code
   - Use existing utility functions

3. **Think About Scale**
   - Consider performance implications
   - Will this work with 1M+ hotels?
   - Are database queries optimized?

4. **Security First**
   - Validate all user inputs
   - Sanitize data before database queries
   - Avoid SQL injection, XSS, and other vulnerabilities
   - Don't log sensitive data

5. **Test Thoroughly**
   - Write tests for new features
   - Update existing tests when refactoring
   - Run full test suite before committing

6. **Document as You Go**
   - Add docstrings to new functions
   - Update this CLAUDE.md if structure changes
   - Comment complex algorithms

### Common Gotchas

1. **Embedding Dimensions**: Ensure consistency (e.g., always 768-dim)
2. **Null Handling**: Hotels may have missing data (no rating, no amenities)
3. **Timezones**: Always use UTC internally
4. **Currency**: Convert to common currency for price comparisons
5. **Rate Limiting**: Implement for external API calls
6. **Vector Search**: Remember to normalize vectors before similarity calculation

### Code Review Checklist

Before marking work as complete, verify:

- [ ] Code follows project conventions
- [ ] All tests pass
- [ ] No security vulnerabilities introduced
- [ ] Database queries are efficient (no N+1 problems)
- [ ] Error handling is comprehensive
- [ ] Logging is appropriate (not too verbose/quiet)
- [ ] Configuration is externalized (no hardcoded values)
- [ ] Documentation is updated
- [ ] Type hints/types are correct
- [ ] No sensitive data in logs or responses

### Performance Considerations

- **Database Queries**:
  - Use indexes for WHERE, JOIN, ORDER BY columns
  - Batch queries when possible
  - Use EXPLAIN to analyze slow queries

- **API Response Times**:
  - Target: <100ms for simple queries
  - Target: <500ms for complex matching
  - Use async/await for I/O operations
  - Implement request timeouts

- **ML Inference**:
  - Batch predictions when possible
  - Cache model in memory
  - Consider GPU acceleration for large models
  - Monitor inference latency

### Debugging Tips

1. **Enable Debug Logging**: Set `LOG_LEVEL=DEBUG` in `.env`
2. **Check Vector Dimensions**: Common source of bugs
3. **Inspect SQL Queries**: Enable query logging
4. **Profile Code**: Use cProfile (Python) or clinic (Node.js)
5. **Monitor Metrics**: Check Prometheus/Grafana dashboards

---

## 📚 Additional Resources

### Documentation
- [API Documentation](./docs/api/README.md)
- [Architecture Overview](./docs/architecture/README.md)
- [Contributing Guide](./CONTRIBUTING.md)

### External Resources
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Sentence Transformers](https://www.sbert.net/)
- [pgvector Guide](https://github.com/pgvector/pgvector)
- [PostgreSQL Best Practices](https://wiki.postgresql.org/wiki/Don't_Do_This)

### Useful Commands

```bash
# Format code
# Python: black src/ tests/
# Node.js: npm run format

# Lint code
# Python: ruff check src/
# Node.js: npm run lint

# Type check
# Python: mypy src/
# Node.js: npm run type-check

# Run specific test file
# Python: pytest tests/unit/test_matching.py -v
# Node.js: npm test -- matching.test.ts

# Generate API docs
# Python: python scripts/generate_openapi.py
# Node.js: npm run docs:generate

# Database console
psql $DATABASE_URL

# Redis console
redis-cli
```

---

## 🔄 Keeping This Document Updated

This CLAUDE.md should be updated when:
- Project structure changes significantly
- New major technologies are adopted
- Coding conventions are modified
- New common patterns emerge
- Architecture decisions are made

**Last Updated**: 2025-11-18
**Version**: 1.0.0
**Maintainer**: AI Assistant (Claude)

---

## 📞 Getting Help

For questions or clarifications:
1. Check this document first
2. Review code comments and docstrings
3. Check existing tests for examples
4. Review closed PRs and issues for context
5. Ask the team in appropriate channels

---

**Remember**: Good code is not just working code—it's maintainable, testable, documented, and secure. Take the time to do it right! 🚀
