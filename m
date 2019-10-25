Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25ABE52B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfJYR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 13:57:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42534 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfJYR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:57:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so2001754pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hB0pIIBATDj7XQ4Wbz8E3uJD/S6VmCRjrZ4dOAWqf50=;
        b=SkOqSdCSPwXVo+8qdnvvqQ/eR8joWBQ7R/hkeU1jJh6Su00UdT34oEa4pXkqCwoSYq
         9HH2cMeJ6Hnb1nKXhGJddZqFkm6mIhaVR/ns24QaXViklZ1EyzUjUD4slpI+UVxsUl2X
         xQYMYFF31vAm/WVlAOSddJYOkLq0p9ec3aOcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hB0pIIBATDj7XQ4Wbz8E3uJD/S6VmCRjrZ4dOAWqf50=;
        b=H9dqK3GiyLlnzC1CZY41p46idPefHY2rMXSF3xKKXBkjy7rpcYYdBH7MKGysANzg2U
         9zSX+mhozPZi/cfUelRDYdKb6yEXr1xCANX6YaylyPeoBCi1atZUbKmuHhKeOZdAytEw
         V0HZD7/ArWN3qzyIt2Fi5euSAa4EJKgk39fQyTIVbnEq5ihTHX3qBVG70kkyN1z6OP0o
         38TK49XmYWXrxm2Xlxk9jHYX1zxQDShZWnGS3kNxUNMb8Uzq80yBqk77cd1oMnlfTuA1
         RqjSJy8Dm1tvL/x7BA40AZV4xjELmbDDV6cir4lXBsQpcwYwWNHVuR/jSo+Q/O3DzMrd
         TXog==
X-Gm-Message-State: APjAAAWA2KWMDVyA/kxypOSDPjjIBFElUbdg+bEDmO6aHh1Ct5NMNlIs
        exTDyKNzwmovlVNR46uwxnyOyQ==
X-Google-Smtp-Source: APXvYqwdTJlUGTm+q1YNKr1WJaGf+nuFBu7RLYAgAbmjqIUdbjCZk1Dq6OuM4dn4dfQhV5DB7NIKOA==
X-Received: by 2002:a63:5949:: with SMTP id j9mr5883267pgm.371.1572026240010;
        Fri, 25 Oct 2019 10:57:20 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id n15sm2926580pfq.146.2019.10.25.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:57:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 6/7] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Date:   Fri, 25 Oct 2019 23:26:24 +0530
Message-Id: <20191025175625.8011-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191025175625.8011-1-jagan@amarulasolutions.com>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI DSI pipeline for Allwinner A64.

- dsi node, with A64 compatible since it doesn't support
  DSI_SCLK gating unlike A33
- dphy node, with A64 compatible with A33 fallback since
  DPHY on A64 and A33 is similar
- finally, attach the dsi_in to tcon0 for complete MIPI DSI

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 69128a6dfc46..a52dfa98ac5e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -382,6 +382,12 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon0>;
+						allwinner,tcon-channel = <1>;
+					};
 				};
 			};
 		};
@@ -1003,6 +1009,37 @@
 			status = "disabled";
 		};
 
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>;
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port {
+				dsi_in_tcon0: endpoint {
+					remote-endpoint = <&tcon0_out_dsi>;
+				};
+			};
+		};
+
+		dphy: d-phy@1ca1000 {
+			compatible = "allwinner,sun50i-a64-mipi-dphy",
+				     "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01ca1000 0x1000>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_DPHY>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3

