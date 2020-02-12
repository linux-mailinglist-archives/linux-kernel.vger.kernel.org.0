Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47EF15A186
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBLHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 02:08:03 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34026 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgBLHIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:08:02 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 95D4C1A39F6;
        Wed, 12 Feb 2020 08:08:00 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 138E81C74D7;
        Wed, 12 Feb 2020 08:07:53 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DDDD0402E0;
        Wed, 12 Feb 2020 15:07:43 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        ping.bai@nxp.com, jun.li@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clk: imx: Include clk-provider.h instead of clk.h for i.MX8M SoCs clock driver
Date:   Wed, 12 Feb 2020 15:02:23 +0800
Message-Id: <1581490943-17920-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M SoCs clock driver are provider, NOT consumer, so clk-provider.h
should be used instead of clk.h.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 2 +-
 drivers/clk/imx/clk-imx8mn.c | 2 +-
 drivers/clk/imx/clk-imx8mq.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2ed93fc..3d19e87 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -4,7 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mm-clock.h>
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c5e7316..ad20487 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -4,7 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mn-clock.h>
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4c0edca..8c82e7a 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -5,7 +5,7 @@
  */
 
 #include <dt-bindings/clock/imx8mq-clock.h>
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.7.4

