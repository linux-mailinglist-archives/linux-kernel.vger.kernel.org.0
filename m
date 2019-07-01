Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E04D47E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfFTREt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:04:49 -0400
Received: from node.akkea.ca ([192.155.83.177]:56990 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTREt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:04:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id AC02D4E204D;
        Thu, 20 Jun 2019 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1561050288; bh=AS2pgKIGsJ0biwMjPOOxiQ+3/xJul3EqWR67+O8CU7w=;
        h=From:To:Cc:Subject:Date;
        b=o/XivuCq99sKxBwg5SGBs+LJl82Zu8IO/2JLO/QYxckEtWOzWXhzwMc6G409QUZ4Y
         mbenT5NaCb2Y7E7wkUDpt4LDBF2CU1FIXGd2tw6GUdk6ZAPRetrKC30XsyMk13ENxr
         +AAFyvYnxwszwLeq5AEn4/tMuj/J39+gs3S8I96Q=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jV7O3S7XKWV1; Thu, 20 Jun 2019 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 3A2D04E204B;
        Thu, 20 Jun 2019 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1561050288; bh=AS2pgKIGsJ0biwMjPOOxiQ+3/xJul3EqWR67+O8CU7w=;
        h=From:To:Cc:Subject:Date;
        b=o/XivuCq99sKxBwg5SGBs+LJl82Zu8IO/2JLO/QYxckEtWOzWXhzwMc6G409QUZ4Y
         mbenT5NaCb2Y7E7wkUDpt4LDBF2CU1FIXGd2tw6GUdk6ZAPRetrKC30XsyMk13ENxr
         +AAFyvYnxwszwLeq5AEn4/tMuj/J39+gs3S8I96Q=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: fsl: librem5: Limit the USB to 5V
Date:   Thu, 20 Jun 2019 11:04:39 -0600
Message-Id: <20190620170439.18762-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charge controller can handle 14V but the PTC on the devkit can only
handle 6V so limit the negotiated voltage to 5V.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 3f4736fd3cea..ec85ada77955 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -353,7 +353,7 @@
 			sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
 				PDO_FIXED_DUAL_ROLE |
 				PDO_FIXED_DATA_SWAP )
-			     PDO_VAR(5000, 12000, 2000)>;
+			     PDO_VAR(5000, 3000, 3000)>;
 			op-sink-microwatt = <10000000>;
 
 			ports {
-- 
2.17.1

