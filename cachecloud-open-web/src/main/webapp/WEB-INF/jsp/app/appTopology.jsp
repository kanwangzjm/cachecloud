<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/manage/commons/taglibs.jsp"%>

<div class="row">
    <div class="page-header">
        <h4>应用拓扑结构-${appDesc.type}-<a href="/admin/app/index.do?appId=${appDesc.appId}">${appDesc.name}</a></h4>
    </div>
    <div style="margin-top: 20px">
        <table class="table table-bordered table-striped table-hover">
            <thead>
            <tr>
                <td>ID</td>
                <td>实例</td>
                <td>实例状态</td>
                <td>内存使用</td>
                <td>对象数</td>
                <td>连接数</td>
                <td>命中率</td>
                <td>角色</td>
                <td>主实例ID</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="instance" items="${instanceList}" varStatus="status">
            	<c:set var="instanceStatsMapKey" value="${instance.ip}:${instance.port}"></c:set>
                <tr>
                    <td><a href="/admin/instance/index.do?instanceId=${instance.id}" target="_blank">${instance.id}</a>
                    </td>
                    <td>${instance.ip}:${instance.port}</td>
                    <td>${instance.statusDesc}</td>
					<td>
						<c:choose>
							<c:when test="${(instanceStatsMap[instanceStatsMapKey]).memUsePercent >= 80}">
								<c:set var="progressBarStatus" value="progress-bar-danger"/>
							</c:when>
							<c:otherwise>
								<c:set var="progressBarStatus" value="progress-bar-success"/>
							</c:otherwise>
						</c:choose>
					
                         <div class="progress margin-custom-bottom0">
                               <div class="progress-bar ${progressBarStatus}"
                                    role="progressbar"
                                    aria-valuenow="${(instanceStatsMap[instanceStatsMapKey]).memUsePercent}"
                                    aria-valuemax="100"
                                    aria-valuemin="0"
                                    style="width: ${(instanceStatsMap[instanceStatsMapKey]).memUsePercent}%">
                                    
	                               	<label style="color: #000000">
	                                   <fmt:formatNumber value="${(instanceStatsMap[instanceStatsMapKey]).usedMemory / 1024 / 1024 / 1024}" pattern="0.00"/>G&nbsp;&nbsp;Used/<fmt:formatNumber value="${(instanceStatsMap[instanceStatsMapKey]).maxMemory / 1024 / 1024 / 1024}" pattern="0.00"/>G&nbsp;&nbsp;Total
	                               	</label>
                                </div>
                         </div>
                  </td>
                  <td>
                  ${(instanceStatsMap[instanceStatsMapKey]).currItems}
                  </td>
                  <td>${(instanceStatsMap[instanceStatsMapKey]).currConnections}</td>
                  <td>${(instanceStatsMap[instanceStatsMapKey]).hitPercent}</td>
                  <td>${instance.roleDesc}</td>
                  <c:choose>
                     <c:when test="${instance.masterInstanceId >0}">
                         <td>
                             <a href="/admin/instance/index.do?instanceId=${instance.masterInstanceId}" target="_blank">${instance.masterInstanceId}</a>
                         </td>
                     </c:when>
                     <c:otherwise>
                         <td></td>
                     </c:otherwise>
                 </c:choose>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
