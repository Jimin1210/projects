<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>손익 발생 정보 상세 조회</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
    <style>
        input {
            border: none;
            text-size : 100%;
            text-align: center;
        }
        html {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            align-items: center;
            justify-content: center;
            width: 80%;
            height: 70%;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 0.6em;
        }
        th,
        td {
            padding: 10px;
            border: 1px solid #ccc;
        }
        th {
            background-color: #f2f2f2;
            text-align: center;
            font-size: 0.7em;
        }
        td {
            vertical-align: middle;
            font-size: 0.7em;
            text-align: center;
        }
        .total,
        .files {
            font-weight: bold;
        }
        .note {
            font-style: italic;
        }
    </style>
</head>
<body>
    <h2>손익 발생 정보</h2>
    <div class="card-footer">
        <button type="button" id="listBtn" class="btn btn-warning" style="margin-left: 68%; margin-right: 2%; font-size: 0.8em;">닫기</button>
        <button type="button" id="detailBtn" class="btn btn-primary" style=" font-size: 0.8em;">해당 월 리스트 조회</button>
    </div>
    <!-- card footer End -->
    <form role="form" method="post" enctype="multipart/form-data">
        <table style="font-size: 1.2em;">
            <tr>
                <td align="center">발생일자</td>
                <td><input type="text" name="sys_regdate" value="${month }" readonly></td>
            </tr>
        </table>
        <table>
            <tr>
                <th width="12%"></th>
                <th width="12%">올해 발생 비용</th>
                <th width="12%">전년 발생 비용</th>
                <th width="12%">전년 대비</th>
                <th width="12%"></th>
                <th width="12%">올해 발생 비용</th>
                <th width="12%">전년 발생 비용</th>
                <th width="12%">전년 대비</th>
            </tr>
            <tbody id="prInput">
                <tr>
                    <td>쇼핑몰 판매</td>
                    <td style="color: ${s > 0 ? 'blue' : 'red'}">${s}원</td>
                    <td style="color: ${s2 > 0 ? 'blue' : 'red'}">${s2}원</td>
                    <td style="color: ${(s - s2) > 0 ? 'blue' : 'red'}">${(s - s2)}원</td>
                    <td>창고 이동</td>
                    <td style="color: ${w > 0 ? 'blue' : 'red'}">${w}원</td>
                    <td style="color: ${w2 > 0 ? 'blue' : 'red'}">${w2}원</td>
                    <td style="color: ${(w - w2) > 0 ? 'blue' : 'red'}">${(w - w2)}원</td>
                </tr>
                <tr>
                    <td>제품 구매</td>
                    <td style="color: ${pb > 0 ? 'blue' : 'red'}">${pb}원</td>
                    <td style="color: ${pb2 > 0 ? 'blue' : 'red'}">${pb2}원</td>
                    <td style="color: ${(pb - pb2) > 0 ? 'blue' : 'red'}">${(pb - pb2)}원</td>
                    <td>기타 구매</td>
                    <td style="color: ${b > 0 ? 'blue' : 'red'}">${b}원</td>
                    <td style="color: ${b2 > 0 ? 'blue' : 'red'}">${b2}원</td>
                    <td style="color: ${(b - b2) > 0 ? 'blue' : 'red'}">${(b - b2)}원</td>
                </tr>
                <tr>
                    <td>발주 요청</td>
                    <td style="color: ${o > 0 ? 'blue' : 'red'}">${o}원</td>
                    <td style="color: ${o2 > 0 ? 'blue' : 'red'}">${o2}원</td>
                    <td style="color: ${o - o2 > 0 ? 'blue' : 'red'}">${o - o2}원</td>
                    <td>불량 처리</td>
                    <td style="color: ${e > 0 ? 'blue' : 'red'}">${e}원</td>
                    <td style="color: ${e2 > 0 ? 'blue' : 'red'}">${e2}원</td>
                    <td style="color: ${e - e2 > 0 ? 'blue' : 'red'}">${e - e2}원</td>
                </tr>
                <tr>
                    <td>급여 제공</td>
                    <td style="color: ${p > 0 ? 'blue' : 'red'}">${p}원</td>
                    <td style="color: ${p2 > 0 ? 'blue' : 'red'}">${p2}원</td>
                    <td style="color: ${p - p2 > 0 ? 'blue' : 'red'}">${p - p2}원</td>
                    <td>AS 비용</td>
                    <td style="color: ${a > 0 ? 'blue' : 'red'}">${a}원</td>
                    <td style="color: ${a2 > 0 ? 'blue' : 'red'}">${a2}원</td>
                    <td style="color: ${a - a2 > 0 ? 'blue' : 'red'}">${a - a2}원</td>
                </tr>
            </tbody>
            <tr class="total">
                <td colspan="2">총 손익</td>
                <td colspan="2"  style="color: ${amount > 0 ? 'blue' : 'red'}">${amount}원</td>
                <td colspan="2">전년 대비</td>
                <td colspan="2" style="color: ${amount - amount2 > 0 ? 'blue' : 'red'}">${amount - amount2}원</td>
            </tr>
        </table>
    </form>
</body>
</html>
<script>
window.onload = function(){
	$('button#listBtn').on('click', function(){
		window.close();
	});
	
	$('button#detailBtn').on('click', function(){
		window.close();
		window.opener.location.href = "/profitLoss/dayProfit.do?mcode=M060000&startDate=${start}&endDate=${end}";
	});
	
}
</script>