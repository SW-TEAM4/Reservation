<%--
  파일명 : sellerSales.jsp
  생성자 : JDeok
  날짜 : 2025.01.05
  기능 : 사장님 매출관리
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>매출 관리</title>
    <link rel="stylesheet" href="/css/sellerHeader.css">
    <link rel="stylesheet" href="/css/sellerSiderbar.css">
    <link rel="stylesheet" href="/css/sellerSales.css">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerHeader.jsp" %>

<div class="layout">
    <%-- 왼쪽 사이드바 포함 --%>
    <%@ include file="/WEB-INF/views/include/sellerSiderbar.jsp" %>

    <!-- 메인 콘텐츠 -->
    <main class="content">
        <h1>매출 관리</h1>
        <p class="sub-title">월간 매출을 알려드립니다.</p>
        <hr>

        <!-- 이번달 매출 -->
        <div class="monthly-sales">
            <p>사장님,</p>
            <p class="highlight">이번달 매출은 <span>${total_money[6]}원</span> 입니다.</p>
        </div>

        <!-- 월간 매출 그래프 -->
        <h2>월간 매출 현황</h2>
        <div class="chart-container">
            <canvas id="salesChart"></canvas>
        </div>
    </main>
</div>

<%--<%@ include file="/WEB-INF/views/include/footer.jsp" %>--%>
</body>

<script>
    $(document).ready(function () {
        // JSP에서 전달된 데이터
        const chartLabels = <c:out value='${month_date}' escapeXml="false"/>;     // 월별 날짜 리스트 (예: ["2023-07", "2023-08", "2023-09", ...])
        const chartData   = <c:out value='${total_money}' escapeXml="false"/>;    // 월별 매출 데이터 리스트 (예: [500000, 600000, 700000, ...])


        const numericData = chartData.map(value => Number(value));
        const formatter = new Intl.NumberFormat('ko-KR', { style: 'decimal' });
        const thisMonthSales = formatter.format(numericData[6]);

        // HTML에 포맷팅된 금액 삽입
        $('.highlight span').text(thisMonthSales + "원");

        // Chart.js 초기화
        const ctx = document.getElementById('salesChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: chartLabels, // X축 라벨
                datasets: [{
                    label: '월별 매출 (단위: 원)',
                    data: chartData, // Y축 데이터
                    backgroundColor: '#8A5642', // 배경색
                    borderColor: '#8A5642', // 선 색
                    borderWidth: 2,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    }
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: '월별 날짜', // X축 제목
                            font: {
                                size: 14
                            }
                        },
                        ticks: {
                            autoSkip: false, // 자동 간격 스킵 해제
                            callback: function(value, index) {
                                return chartLabels[index]; // 명시적으로 X축 라벨 표시
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString() + ' 원'; // 값 포맷팅
                            }
                        },
                        title: {
                            display: true,
                            text: '매출 금액 (단위: 원)',
                            font: {
                                size: 14
                            }
                        }
                    }
                }
            }
        });
    });
</script>


</html>





