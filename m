Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5205016AD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 18:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBXRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 12:25:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44781 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:25:39 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1j6HU6-0003aC-Ur; Mon, 24 Feb 2020 18:25:34 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1j6HU5-00047o-Oy; Mon, 24 Feb 2020 18:25:33 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: stm32: demote warning about optional property absence
Date:   Mon, 24 Feb 2020 18:25:19 +0100
Message-Id: <20200224172519.15315-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mainline device trees lack the "st,syscfg-pdds", so probing the
driver always throws the warning. As the property is optional per binding
and the driver can deal with its absence, demote the warning to info log
level.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index a18f88044111..2e07a95439c8 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -602,7 +602,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	err = stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
 	if (err)
-		dev_warn(dev, "failed to get pdds\n");
+		dev_info(dev, "failed to get pdds\n");
 
 	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
 
-- 
2.25.0

