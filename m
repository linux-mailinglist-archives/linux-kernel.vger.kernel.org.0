Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C49D25EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbfJJJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 05:08:26 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39835 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733144AbfJJJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:08:26 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46plcR3d7hz1rQCD;
        Thu, 10 Oct 2019 11:08:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46plcR0bYQz1qqkQ;
        Thu, 10 Oct 2019 11:08:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id GACLg3BAFslI; Thu, 10 Oct 2019 11:08:20 +0200 (CEST)
X-Auth-Info: 3yv9RJi5v/uCUl5RBM3UxIXknte+Kate4wyyjunP9RI=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 10 Oct 2019 11:08:20 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lukasz Majewski <lukma@denx.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] dts: Disable DMA support on the BK4 vf610 device's fsl_lpuart driver
Date:   Thu, 10 Oct 2019 11:08:02 +0200
Message-Id: <20191010090802.16383-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change disables the DMA support (RX/TX) on the NXP's fsl_lpuart
driver - the PIO mode is used instead. This change is necessary for better
robustness of BK4's device use cases with many potentially interrupted
short serial transfers.

Without it the driver hangs when some distortion happens on UART lines.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Suggested-by: Robin Murphy <robin.murphy@arm.com>

---
Changes for v2:
- Use /delete-property/dma-names; instead of dma-names = "","";
---
 arch/arm/boot/dts/vf610-bk4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index 0f3870d3b099..830c85476b3d 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -259,24 +259,28 @@
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0>;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
-- 
2.20.1

