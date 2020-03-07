Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C614717CE74
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 14:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 08:48:45 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41942 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgCGNsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:48:45 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E7BE200D70;
        Sat,  7 Mar 2020 14:48:43 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90DDA20002F;
        Sat,  7 Mar 2020 14:48:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 90AA8402DA;
        Sat,  7 Mar 2020 21:48:36 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] irqchip: Add COMPILE_TEST support for IMX_INTMUX
Date:   Sat,  7 Mar 2020 21:42:27 +0800
Message-Id: <1583588547-7164-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST support to IMX_INTMUX driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6d39773..24fe087 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -458,7 +458,7 @@ config IMX_IRQSTEER
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
 config IMX_INTMUX
-	def_bool y if ARCH_MXC
+	def_bool y if ARCH_MXC || COMPILE_TEST
 	select IRQ_DOMAIN
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
-- 
2.7.4

