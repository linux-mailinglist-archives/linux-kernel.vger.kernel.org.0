Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE39910AD71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 11:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfK0KXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 05:23:03 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27280 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfK0KXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:23:03 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARAM3r3006174;
        Wed, 27 Nov 2019 11:22:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=DGAu8nBd8sSn0yVexjpoA/8nuPadx0SdCFMZkuAqTjI=;
 b=ygulLg2e5rLFuUd584h0vuVZhD+RKemgd493AWF3vztp/dF30AIlPn83ICzuODlilTxU
 68GX8ZqJt66704So7IBm4ukcmBA8GkDdLslHejaaqixJcgaRkjF4QV4GlSuEqvIBc29i
 mJXPz/6TRQqMtI9NOvyTIFIZVOTr3E1MxaRbvXKanIGnsjB2vYegAlDIYVe95fUGzwTH
 TIa7QobmHTOohdnwiXst1FjfyPY0PnoyjiRDohKzq/ZdTHdjt1LGIJ7puffGWhwdB21A
 jueEyE2x/gECpq6uTHG6hwTYfZLyQ6ePA6pSWlnSMDu3aBgDsku+AvNgXJ3yDN+V2OmP JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxj2xh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:22:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF3FB10002A;
        Wed, 27 Nov 2019 11:22:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 199782B1211;
        Wed, 27 Nov 2019 11:22:51 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov 2019 11:22:50
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge/synopsys: dsi: check post disable
Date:   Wed, 27 Nov 2019 11:22:45 +0100
Message-ID: <1574850165-13135-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Some bridges did not registered the post_disable function.
To avoid a crash, check it before calling.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index cc806ba..1e37233 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -886,7 +886,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
 	 * This needs to be fixed in the drm_bridge framework and the API
 	 * needs to be updated to manage our own call chains...
 	 */
-	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
+	if (dsi->panel_bridge->funcs->post_disable)
+		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
 
 	if (dsi->slave) {
 		dw_mipi_dsi_disable(dsi->slave);
-- 
2.7.4

