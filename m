Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9914B108DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKYM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 07:26:45 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:23244 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfKYM0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574684803;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=slzL0wEBERMw+r5ZllRQGIEHa9MDUC2QNWePkvo5OGQ=;
        b=Aj6/D5hDk8RCHMrHZG5LpxF1BdW4ShD8Hmxw2cyNKMByVlisGP5TjIVvHHeXsGenK1
        0MrNbhSp1DW+pNTfNttoiBTe4FqHu/oCOO0tnm9IJG/wVg15YCyj6Ppa0td+mL6uQyVY
        CrkCqrGdeoPMOj9C42yVm9uy2zAdK71N09klNlMyR/zt2TM3eyG23vSFbUu1pZLyaPkb
        E8R4/yPa+JoemgXfWpDT8dgjZGiZ66d38j8WvzQvik/Q+17robhh2ewXeLcjc0TJR6Rb
        14uj2uPNxgB3tGPlYR6rXR29XCuMiI9C3YGqWkosQPzOzjL2MEssYgsDZWanHJrMQUwH
        h5rQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1NmWArOmLo="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 45.0.2 DYNA|AUTH)
        with ESMTPSA id 304194vAPCQh0FR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 13:26:43 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/5] ARM: dts: ux500: Add pin configs for UART1 CTS/RTS pins
Date:   Mon, 25 Nov 2019 13:22:55 +0100
Message-Id: <20191125122256.53482-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125122256.53482-1-stephan@gerhold.net>
References: <20191125122256.53482-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART1 an be optionally used with additional CTS/RTS pins.
The pinctrl driver has an extra "u1ctsrts_a_1" pin group for them.

Add a new pin configuration to configure them correctly if needed.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
index b6d0a60e9aed..e85a08ad2ea7 100644
--- a/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
@@ -65,6 +65,32 @@
 				ste,config = <&slpm_out_wkup_pdis>;
 			};
 		};
+
+		u1ctsrts_a_1_default: u1ctsrts_a_1_default {
+			default_mux {
+				function = "u1";
+				groups = "u1ctsrts_a_1";
+			};
+			default_cfg1 {
+				pins = "GPIO6_AF6"; /* CTS */
+				ste,config = <&in_pu>;
+			};
+			default_cfg2 {
+				pins = "GPIO7_AG5"; /* RTS */
+				ste,config = <&out_hi>;
+			};
+		};
+
+		u1ctsrts_a_1_sleep: u1ctsrts_a_1_sleep {
+			sleep_cfg1 {
+				pins = "GPIO6_AF6"; /* CTS */
+				ste,config = <&slpm_in_wkup_pdis>;
+			};
+			sleep_cfg2 {
+				pins = "GPIO7_AG5"; /* RTS */
+				ste,config = <&slpm_out_hi_wkup_pdis>;
+			};
+		};
 	};
 
 	uart2 {
-- 
2.24.0

