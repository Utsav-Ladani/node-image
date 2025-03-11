#!/bin/sh

echo "🧪 Running tests..."

if docker run --rm -u node -v $(pwd)/test:/usr/src/app/test:ro -w /usr/src/app utsavladani/node:latest node test/test.js; then
  echo "✅ All tests passed successfully!"
  exit 0
else
  echo "❌ Some tests failed!"
  exit 1
fi 