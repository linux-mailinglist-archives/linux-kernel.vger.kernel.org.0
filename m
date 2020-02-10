Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D51573E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 13:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBJMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 07:07:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39879 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBJMHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so10296201wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=Rzmbsn0TqHDRj64leM1gThtjgaD6kwky4m2rT9IYPagYCS5cGR1iw/wXJmhDRFDPgG
         xLyjn4BYa6tgSXIqovvxBKXVvWNvGtlbnOdxdM5X0/jXKDpo5e4bCTzUdNV3yyDCbCkF
         +Sfbt04JfwCIRDPftxZJeY7jH60hT2I0DQ2D0kYZswxbMZ5oAIE4nKwQOf5R7+3K1aD9
         8N4rTlPVGNuz+pKGZqV9Kaq3xPnokgSBA2wGlRYQNI/kKWuGZs5636dduYlfnHUgvM4I
         Xgd1ytosY0lzCyWIIq9yiq8TLBkt4Rlbzl7Q1Y4MlMQAfQvJYW7ywKe8/iEAp03PjR6d
         EeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=MqAs8kkl8RdeAXay0sIqbAdQg1P8JnNnaiZlpks5cbAS7m6HolqEFFxLMwR0xb86j3
         Cfh0ifzGcJ9KRfxNhar4GPlFECY8U7A++ewvFUk9yyE2McfTEPjweaqdyuJt9H1PUA49
         fg6lkqFt/pWjAhGdmq20FAuwLUnFhYnsu0RJaQPUElVR2trNFgL2PpIIoI7buc+lUWGG
         37b2T4pmGey0sFyrj2gyzAVDIb5FSO8A++GtSJcU5G6KOocASFwaXOnRdUGI/VyQq4EA
         kgUTW5yutF3QVjUtszIRq7bO70T1M07/ioBoSXEQZed9fInxE1NCDJLcsxptWszORL/p
         cLLQ==
X-Gm-Message-State: APjAAAXwXo8CHYupGo6yZGHG/eu6GxtVJU4DuBX4W/j9fHi+CoTEW5D8
        9jyN7+fYpTV5Vjrz7D7ju4bR+g==
X-Google-Smtp-Source: APXvYqzRPprUdegtPPoJ2R9DDNIO7g+b4f3TGlqKbGuIRbdIJBtE7v+DEGiQ/HW1Y9yfE0wQrEUhbg==
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr14648317wmj.108.1581336440503;
        Mon, 10 Feb 2020 04:07:20 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i204sm293124wma.44.2020.02.10.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:07:19 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 01/18] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Mon, 10 Feb 2020 12:07:06 +0000
Message-Id: <20200210120723.91794-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
References: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

This binding is not used by any driver.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/phy/qcom-dwc3-usb-phy.txt        | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt b/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
deleted file mode 100644
index a1697c27aecd..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Qualcomm DWC3 HS AND SS PHY CONTROLLER
---------------------------------------
-
-DWC3 PHY nodes are defined to describe on-chip Synopsis Physical layer
-controllers.  Each DWC3 PHY controller should have its own node.
-
-Required properties:
-- compatible: should contain one of the following:
-	- "qcom,dwc3-hs-usb-phy" for High Speed Synopsis PHY controller
-	- "qcom,dwc3-ss-usb-phy" for Super Speed Synopsis PHY controller
-- reg: offset and length of the DWC3 PHY controller register set
-- #phy-cells: must be zero
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-- clock-names: Should contain "ref" for the PHY reference clock
-
-Optional clocks:
-  "xo"		External reference clock
-
-Example:
-		phy@100f8800 {
-			compatible = "qcom,dwc3-hs-usb-phy";
-			reg = <0x100f8800 0x30>;
-			clocks = <&gcc USB30_0_UTMI_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-
-		phy@100f8830 {
-			compatible = "qcom,dwc3-ss-usb-phy";
-			reg = <0x100f8830 0x30>;
-			clocks = <&gcc USB30_0_MASTER_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-- 
2.25.0

