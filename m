Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9AD11E4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 14:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLMNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 08:49:41 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:35178 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfLMNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:49:41 -0500
Received: from trochilidae.toradex.int (31-10-206-124.static.upc.ch [31.10.206.124])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 395885C05EA;
        Fri, 13 Dec 2019 14:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1576244979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=KGQxjK58jAQG6FE+vNh52hsu3NbDX3qzbuGmMeNbvdc=;
        b=wVGNG34WmvlBILnUGAbsYGUMOh2z1Trmyeqk11UEfG9AHKoO7OAoUj7tmDfJnKVxHZZSIk
        zUBjbeFSMPqAZQqsPRDUOYfMy4Xq2iUywvcTaJDJIUdlDqYr/TZgDhMMOShA+EVIJkR96O
        9TIx5ryMTe/ezWupM7PWTjOEBENhazo=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     stefan@agner.ch, philippe.schenker@toradex.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] ARM: dts: imx6qdl-apalis: mux HDMI CEC pin
Date:   Fri, 13 Dec 2019 14:49:37 +0100
Message-Id: <20191213134937.257840-1-stefan@agner.ch>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Mux the HDMI CEC pin to make HDMI CEC working. With this change HDMI CEC
seems to work fine on a Apalis iMX6 on Ixora using cec-ctl.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 4b6b8b60ea19..f6dd48a4f89e 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -246,7 +246,7 @@
 
 &hdmi {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hdmi_ddc>;
+	pinctrl-0 = <&pinctrl_hdmi_ddc &pinctrl_hdmi_cec>;
 	status = "disabled";
 };
 
-- 
2.24.0

