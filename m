Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF61FEA51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 04:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKPDBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 22:01:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbfKPDBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 22:01:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C094365A3DAFF918123B;
        Sat, 16 Nov 2019 11:01:03 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 16 Nov 2019 11:00:52 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <tyreld@linux.ibm.com>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <mahesh@linux.vnet.ibm.com>, <paulus@samba.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] powerpc/pseries: remove variable 'status' set but not used
Date:   Sat, 16 Nov 2019 11:07:30 +0800
Message-ID: <1573873650-62511-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/powerpc/platforms/pseries/ras.c: In function ras_epow_interrupt:
arch/powerpc/platforms/pseries/ras.c:319:6: warning: variable status set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 arch/powerpc/platforms/pseries/ras.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 1d7f973..4a61d0f 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -316,12 +316,11 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
 /* Handle environmental and power warning (EPOW) interrupts. */
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id)
 {
-	int status;
 	int state;
 	int critical;
 
-	status = rtas_get_sensor_fast(EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX,
-				      &state);
+	rtas_get_sensor_fast(EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX,
+			     &state);
 
 	if (state > 3)
 		critical = 1;		/* Time Critical */
@@ -330,12 +329,12 @@ static irqreturn_t ras_epow_interrupt(int irq, void *dev_id)
 
 	spin_lock(&ras_log_buf_lock);
 
-	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
-			   RTAS_VECTOR_EXTERNAL_INTERRUPT,
-			   virq_to_hw(irq),
-			   RTAS_EPOW_WARNING,
-			   critical, __pa(&ras_log_buf),
-				rtas_get_error_log_max());
+	rtas_call(ras_check_exception_token, 6, 1, NULL,
+		  RTAS_VECTOR_EXTERNAL_INTERRUPT,
+		  virq_to_hw(irq),
+		  RTAS_EPOW_WARNING,
+		  critical, __pa(&ras_log_buf),
+		  rtas_get_error_log_max());
 
 	log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
 
-- 
2.7.4

