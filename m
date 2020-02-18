Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F261E162097
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 06:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgBRF5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 00:57:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41898 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgBRF5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 00:57:23 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CC0E1A173C;
        Tue, 18 Feb 2020 06:57:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E86B1A3764;
        Tue, 18 Feb 2020 06:57:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C79C140245;
        Tue, 18 Feb 2020 13:57:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, agx@sigxcpu.org, andrew.smirnov@gmail.com,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx: Remove unused include in gpcv2.c
Date:   Tue, 18 Feb 2020 13:51:29 +0800
Message-Id: <1582005089-23767-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing in use from sizes.h, remove it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6cf8a7a..b0dffb0 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -14,7 +14,6 @@
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
 
-- 
2.7.4

