<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문서</title>
    <style>
        * {
            box-sizing: border-box;
        }
        
        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            font-size: 14px;
        }
        
        .container {
            width: 80%;
            margin: 30px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }
        
        th {
            background-color: #f2f2f2;
            text-align: center;
        }
        
        .text-center {
            text-align: center;
        }
        
        .text-right {
            text-align: right;
        }
        
        .bold {
            font-weight: bold;
        }
        
        .total-row {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>주문서</h2>

        <table>
            <tr>
                <th>주문번호</th>
                <th>주문일자</th>
                <th>거래처명</th>
            </tr>
            <tr>
                <td>ORD20210701001</td>
                <td>2021-07-01</td>
                <td>ABC Trading Co.</td>
            </tr>
        </table>

        <table>
            <tr>
                <th>상품명</th>
                <th>단가</th>
                <th>수량</th>
                <th>금액</th>
            </tr>
            <tr>
                <td>Product A</td>
                <td class="text-right">10,000</td>
                <td class="text-right">5</td>
                <td class="text-right">50,000</td>
            </tr>
            <tr>
                <td>Product B</td>
                <td class="text-right">20,000</td>
                <td class="text-right">3</td>
                <td class="text-right">60,000</td>
            </tr>
            <tr>
                <td>Product C</td>
                <td class="text-right">15,000</td>
                <td class="text-right">2</td>
                <td class="text-right">30,000</td>
            </tr>
            <tr class="total-row">
                <td class="bold text-right" colspan="3">합계</td>
                <td class="bold text-right">140,000</td>
            </tr>
        </table>

        <div class="text-center">
            <button>저장</button>
            <button>인쇄</button>
        </div>
    </div>
</body>

</html>
<!-- jQuery -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<%@ include file="../include/footer_js.jsp" %>
