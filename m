Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05E416F744
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBZF2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:28:05 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42968 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgBZF2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:28:05 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E1831A695C;
        Wed, 26 Feb 2020 06:28:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 40B271A693C;
        Wed, 26 Feb 2020 06:27:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A32CB402AD;
        Wed, 26 Feb 2020 13:27:53 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] nvmem: imx-ocotp: Drop unnecessary initializations
Date:   Wed, 26 Feb 2020 13:22:13 +0800
Message-Id: <1582694533-18870-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary initialization of variable 'clk_rate' and 'timing'.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 4ba9cc8..5b6a0c9 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -193,9 +193,9 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 
 static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 {
-	unsigned long clk_rate = 0;
+	unsigned long clk_rate;
 	unsigned long strobe_read, relax, strobe_prog;
-	u32 timing = 0;
+	u32 timing;
 
 	/* 47.3.1.3.1
 	 * Program HW_OCOTP_TIMING[STROBE_PROG] and HW_OCOTP_TIMING[RELAX]
@@ -245,9 +245,9 @@ static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 
 static void imx_ocotp_set_imx7_timing(struct ocotp_priv *priv)
 {
-	unsigned long clk_rate = 0;
+	unsigned long clk_rate;
 	u64 fsource, strobe_prog;
-	u32 timing = 0;
+	u32 timing;
 
 	/* i.MX 7Solo Applications Processor Reference Manual, Rev. 0.1
 	 * 6.4.3.3
-- 
2.7.4

