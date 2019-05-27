Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3F2B1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfE0KPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 06:15:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1776 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbfE0KPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:15:20 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4RABxHG027938;
        Mon, 27 May 2019 12:15:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=49KqLmi8uT8SGb9oCf/zQyH1WqJr1wPSd5r0q3Usx7Y=;
 b=Va3oDh/dPgY2nN0WH5+rQkCIv1Qx4+o6uBsv+VcU0y02MGqtQkH9J4F1tdNzW8sCBnOF
 De+kANpxEoMCxQzzCQDQLrAOZmNtmvsvLJIoSxcqhW9FvNYJ18CuqvYmIrOJPOiz0+GC
 PF8pGP7TExbF1G7tzkqRUAf6CQ2hpqvsmUpBZqAH+43onNXpnC3IYhKS/Nce1bOiwxQc
 cyTaynBwHjK6DXreKkHpmc5ySPEAUV3ScPInVrbG6g25eCTW2ZNOBGbolEW+LAOsGnwR
 fLSTeJjUu8THXjtFGzBd1yf33xHyYGk6V7ATwWVasvCovNooC9TVad28mw5T+pxiJfmj 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sptu9jhb6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 May 2019 12:15:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9AAB538;
        Mon, 27 May 2019 10:15:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 396C427DB;
        Mon, 27 May 2019 10:15:05 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May
 2019 12:15:05 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 27 May 2019 12:15:04
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: No message if probe
Date:   Mon, 27 May 2019 12:14:34 +0200
Message-ID: <1558952075-14883-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print display controller hardware version in debug mode only.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index d24ffc2..16b1103 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1211,7 +1211,7 @@ int ltdc_load(struct drm_device *ddev)
 		goto err;
 	}
 
-	DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
+	DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_version);
 
 	/* Add endpoints panels or bridges if any */
 	for (i = 0; i < MAX_ENDPOINTS; i++) {
-- 
2.7.4

