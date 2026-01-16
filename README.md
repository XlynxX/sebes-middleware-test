# Payment Gateway Middleware

A Ruby on Rails middleware application that sits between a payment Gateway and a Provider, handling transaction initialization and authorization flows.

## Overview

This application acts as an intermediary in the payment flow:

1. **Gateway → Middleware**: Gateway initiates a transaction
2. **Middleware → Provider**: Middleware forwards to Provider's init endpoint
3. **Middleware → Gateway**: Middleware returns a redirect URL
4. **User → Middleware**: User is redirected to middleware's authorization endpoint
5. **Middleware → Provider**: Middleware calls Provider's auth endpoint
6. **Middleware → User**: Displays success or failure

```
┌─────────┐      ┌────────────┐      ┌──────────┐
│ Gateway │─────▶│ Middleware │─────▶│ Provider │
└─────────┘      └────────────┘      └──────────┘
                       │
                       ▼
                   ┌──────┐
                   │ User │
                   └──────┘
```

## Prerequisites

- Ruby 4.x
- Rails 8.x
- Bundler

## Installation

### 1. Clone the repository

```bash
git clone <repository-url>
cd sebes-middleware-test
```

### 2. Install dependencies

```bash
bundle install
```

### 4. Run tests

```bash
bundle exec rspec
```

## Testing

This project uses RSpec for testing with WebMock to stub external HTTP requests.

### Run all tests

```bash
bundle exec rspec
```

### Run specific test files

```bash
bundle exec rspec spec/requests/gateway/transactions_spec.rb
bundle exec rspec spec/requests/transactions_spec.rb
```

### Test Coverage

The test suite covers:
- ✅ Successful transaction initialization
- ✅ Successful transaction authorization
- ✅ Failed authorization scenarios

## Development

### Running the application locally

```bash
rails server
```

The application will be available at `http://localhost:3000`

## Security Considerations

⚠️ **This implementation contains intentional security issues for educational purposes.**

### Identified Security Issues:

1. **CSRF Protection Disabled** - Gateway endpoint skips CSRF verification
2. **No Authentication/Authorization** - No API key or authentication required
3. **No Rate Limiting** - Vulnerable to DoS attacks
4. **Insufficient Input Validation** - No data validation
5. **Transaction ID Enumeration** - Predictable transaction IDs in URLs
6. **No Idempotency Protection** - Duplicate requests possible
7. **Information Disclosure** - Detailed error messages
8. **No Request Signing** - Can't verify request authenticity
9. **Timeout Configuration** - Hardcoded timeout values
10. **No Audit Trail** - Limited logging

**Note:** This is an educational project demonstrating middleware implementation patterns. Do not use in production without addressing the security concerns listed above.