<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.Pattern, java.util.regex.Matcher, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <title>Mathematical Parser</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .custom-button {
            width: auto;
            height: 40px;
        }
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="font-size: 26px;">Enter a mathematical expression:</h1>
        <form method="post">
            <div class="d-flex">
                <div class="mb-3 flex-grow-1 mr-3">
                    <input type="text" name="input" id="txtInput" class="form-control" placeholder="Enter the expression" style="font-size: 18px;">
                </div>
                <button type="submit" class="custom-button btn btn-primary">Submit</button>
            </div>
        </form>
        
        <%
            String input = request.getParameter("input");
            if (input != null && !input.trim().isEmpty()) {
                input = input.toLowerCase();
                Pattern pattern = Pattern.compile("([-+]?\\d+\\.?\\d*)|([+*\\-x/:])");
                Matcher matcher = pattern.matcher(input);

                ArrayList<String> tokens = new ArrayList<>();
                while (matcher.find()) {
                    tokens.add(matcher.group());
                }
                
                try {
                    if (tokens.size() < 3) {
                        out.println("<div class='alert alert-danger mt-3' role='alert'><strong>Error: the input does not contain a valid mathematical expression.</strong></div>");
                    } else {
                        double result = Double.parseDouble(tokens.get(0));
                        for (int i = 1; i < tokens.size(); i += 2) {
                            String operator = tokens.get(i);
                            double nextNumber = Double.parseDouble(tokens.get(i + 1));
                            switch (operator) {
                                case "+":
                                    result += nextNumber;
                                    break;
                                case "-":
                                    result -= nextNumber;
                                    break;
                                case "*":
                                case "x":
                                    result *= nextNumber;
                                    break;
                                case "/":
                                case ":":
                                    if (nextNumber != 0) {
                                        result /= nextNumber;
                                    } else {
                                        throw new ArithmeticException("Division by zero.");
                                    }
                                    break;
                                default:
                                    throw new IllegalArgumentException("Unsupported operation: " + operator);
                            }
                        }
                        out.println("<div class='alert alert-success mt-3' role='alert'><strong>Result: " + result + "</strong></div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger mt-3' role='alert'><strong>Error: " + e.getMessage() + "</strong></div>");
                }
            } else if (request.getMethod().equalsIgnoreCase("POST")) {
                out.println("<div class='alert alert-danger mt-3' role='alert'><strong>Error: the input is empty.</strong></div>");
            }
        %>
    </div>
</body>
</html>