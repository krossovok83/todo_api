{
  "openapi": "3.0.0",
  "info": {
    "title": "API Documentation",
    "description": "ToDo list\n",
    "version": "1.0"
  },
  "paths": {
    "/api/v1/users": {
      "post": {
        "summary": "Create User",
        "tags": [
          "Users"
        ],
        "description": "",
        "parameters": [
          {
            "name": "Accept",
            "in": "header",
            "example": "text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5"
          },
          {
            "name": "Content-Type",
            "in": "header",
            "example": "application/x-www-form-urlencoded"
          }
        ],
        "requestBody": {
          "content": {
            "text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5": {
              "examples": {
                "create user": {
                  "summary": "create user",
                  "value": "email=examle%40example.com&password=password&password_confirmation=password"
                }
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created",
            "content": {
              "application/json; charset=utf-8": {
                "examples": {
                  "create user": {
                    "summary": "create user",
                    "value": {
                      "id": 24,
                      "email": "examle@example.com",
                      "password_digest": "$2a$04$/Js3lYuOSmjhwvjHkglTBu9/fO3wn8p.pJLdi8710UQ1iuXnC3h2q",
                      "created_at": "2022-04-16T08:19:36.723Z",
                      "updated_at": "2022-04-16T08:19:36.723Z"
                    }
                  }
                }
              }
            },
            "headers": {
              "Content-Type": {
                "description": "application/json; charset=utf-8"
              }
            }
          }
        }
      }
    }
  },
  "tags": [
    {
      "name": "Users",
      "description": ""
    }
  ],
  "x-tagGroups": [
    {
      "name": "Users",
      "tags": [
        "Users"
      ]
    }
  ]
}
