Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEE135A52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgAINjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 08:39:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39821 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgAINjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:39:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so7435541wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r7WTFcFTk1QmmtFD4T5h5vDKOxEbNevvnGjMspC9SaQ=;
        b=yB+cXjham6iu3QWUiauzuVhna2pI/lM3ap1PyFVUgIdf30z80pj5V0REouRFMrmXeb
         bxHZZ3PvHKPP1+LkEXDd9Gde0FPU3HRc6pALcVoVz4lW2JKgdN0qWpOloTRNYIs/+JsR
         PSr02LwEXLY1Y/8kDuEkbMsnKt4iK9RpGiq8N37cls+E7WBdBvMQ5VG3g0bU9P5m1pAj
         51cSJpVp2nw7HJlV1B8w/yUNvoa0uM6JoiyXEAJ1fugzcAE+Afj/1kFkgl1t2A0lGBwg
         9G4vyVJtLJNKoBaMVpn60KFoDIlCkBGHlcsfaTMcrFK22AH2+5s8G1GXHWwx7xsyy6iR
         07hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r7WTFcFTk1QmmtFD4T5h5vDKOxEbNevvnGjMspC9SaQ=;
        b=tgcUpfVn2ztPposWY24KkIoldis6pf/sC9nDXjsZbGS1Mwi+jaGomdfzNFRZ2DKt40
         bXUnfqYnL/1I9K+3xvGk9WRPqfs5Xg0J+J8U3MrVyq3MELCph/vCwK8e6D5cSM8Ymhxe
         GQlYibizyhmsRq9STWiY0VOYEWaeZ4W00BIE7V+JT7mfUjXxAFbF3fgp+LoDwHkUbmOW
         QRbPXb6Js2MnnfQeoUdOFT4ig+BraLnw2w0pbUFamlpkdGp+VfQHqK7FWNlnP/Fl6bEs
         mL5QrPOmUs2RjVV2XAb3gSRf9ZchshJtqHS583W3m0FpfLu/uyiqcEwRgZUj5kpcQBeU
         pPNw==
X-Gm-Message-State: APjAAAWJBlI0CwNJnMY3NAqUx5v2A2mcZUvuqbJ2y0psvd3r5mR0buYP
        XHtjuGml96oNF/sQhajgF5314g==
X-Google-Smtp-Source: APXvYqzBNJJfU6vCVqf/kckPeYyOk9us+nNsVs1xLIoX1DFcfCCm47/9vDfpkL8wjDjT2Bi7VzAFnw==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr1797127wrx.39.1578577161031;
        Thu, 09 Jan 2020 05:39:21 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a16sm8167344wrt.37.2020.01.09.05.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:39:20 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: zynqmp: Turn comment to gpio-line-names
Date:   Thu,  9 Jan 2020 14:39:11 +0100
Message-Id: <5c7d1ef3643f6ac96e8a7c0144da224d8eabc529.1578577147.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577147.git.michal.simek@xilinx.com>
References: <cover.1578577147.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Label gpio lines properly.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 43 ++++---------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 7c6b538490f8..c96e8416fa7e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -125,21 +125,11 @@ &i2c0 {
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
 		reg = <0x20>;
-		gpio-controller;
+		gpio-controller; /* IRQ not connected */
 		#gpio-cells = <2>;
-		/*
-		 * IRQ not connected
-		 * Lines:
-		 * 0 - PS_GTR_LAN_SEL0
-		 * 1 - PS_GTR_LAN_SEL1
-		 * 2 - PS_GTR_LAN_SEL2
-		 * 3 - PS_GTR_LAN_SEL3
-		 * 4 - PCI_CLK_DIR_SEL
-		 * 5 - IIC_MUX_RESET_B
-		 * 6 - GEM3_EXP_RESET_B
-		 * 7, 10 - 17 - not connected
-		 */
-
+		gpio-line-names = "PS_GTR_LAN_SEL0", "PS_GTR_LAN_SEL1", "PS_GTR_LAN_SEL2", "PS_GTR_LAN_SEL3",
+				"PCI_CLK_DIR_SEL", "IIC_MUX_RESET_B", "GEM3_EXP_RESET_B",
+				"", "", "", "", "", "", "", "", "";
 		gtr-sel0 {
 			gpio-hog;
 			gpios = <0 0>;
@@ -169,27 +159,12 @@ gtr-sel3 {
 	tca6416_u61: gpio@21 {
 		compatible = "ti,tca6416";
 		reg = <0x21>;
-		gpio-controller;
+		gpio-controller; /* IRQ not connected */
 		#gpio-cells = <2>;
-		/*
-		 * IRQ not connected
-		 * Lines:
-		 * 0 - VCCPSPLL_EN
-		 * 1 - MGTRAVCC_EN
-		 * 2 - MGTRAVTT_EN
-		 * 3 - VCCPSDDRPLL_EN
-		 * 4 - MIO26_PMU_INPUT_LS
-		 * 5 - PL_PMBUS_ALERT
-		 * 6 - PS_PMBUS_ALERT
-		 * 7 - MAXIM_PMBUS_ALERT
-		 * 10 - PL_DDR4_VTERM_EN
-		 * 11 - PL_DDR4_VPP_2V5_EN
-		 * 12 - PS_DIMM_VDDQ_TO_PSVCCO_ON
-		 * 13 - PS_DIMM_SUSPEND_EN
-		 * 14 - PS_DDR4_VTERM_EN
-		 * 15 - PS_DDR4_VPP_2V5_EN
-		 * 16 - 17 - not connected
-		 */
+		gpio-line-names = "VCCPSPLL_EN", "MGTRAVCC_EN", "MGTRAVTT_EN", "VCCPSDDRPLL_EN", "MIO26_PMU_INPUT_LS",
+				"PL_PMBUS_ALERT", "PS_PMBUS_ALERT", "MAXIM_PMBUS_ALERT", "PL_DDR4_VTERM_EN",
+				"PL_DDR4_VPP_2V5_EN", "PS_DIMM_VDDQ_TO_PSVCCO_ON", "PS_DIMM_SUSPEND_EN",
+				"PS_DDR4_VTERM_EN", "PS_DDR4_VPP_2V5_EN", "", "";
 	};
 
 	i2c-mux@75 { /* u60 */
-- 
2.24.0

