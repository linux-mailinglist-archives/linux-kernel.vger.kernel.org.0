Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1990A134DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 21:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgAHUxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 15:53:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35222 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgAHUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so4945467wro.2;
        Wed, 08 Jan 2020 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z5HJGRQJ2/f2kJUQoCeIFnI3hwMtLOLQy/CYHk2/+co=;
        b=NzEFBmTw/MkuVz5mPbP3iuI9K7JbjF/4gA3ZSAEoJ2JoIY4O3CU11F950od9NnqL5p
         ZK7/1X7C64V0PeKlQ/aros7Yl1Rx1u/ImZnvL4Hz4b9S0DLJ2bQE6t7chelRxG1JZ4UO
         oLTVQDNDrC0MUR1pw2Xb7rB90EZG4hEI0q2sW9QsT5WQLZCN3d8P8s4Z7Hu1TwBb65FL
         ZQUx5+MNfsgJ/Hux8ohu2XmkyLuLPq0oFZwCWQlMgSiAlGcb4lpAkQQuC0MacU6pCdf+
         boF6qMr7xQzqAWqHSa1JJ3f7F6a2qlS4dEfSYaG3Xu8Mk9bsmcXkn3oATl0yt0dlwsvr
         YLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z5HJGRQJ2/f2kJUQoCeIFnI3hwMtLOLQy/CYHk2/+co=;
        b=pY0JsJWlIhUx210HjTjXty6kxr1pjAbiuaLHLR08TY4fxiHk6g/qRF9HTTLbGStd50
         e5b+WVukp17kKqyUERUl2uU3deXkbi5PujK84S1VbHKH+AuSl1T9AXS34EoWEYPcOVJ7
         12eJGQzYfXh1H/5vvmOZAki2mWjK4M4K+zcTzso5V2brAUSPlH3hWsr2Bp0xrkznF9mq
         nnQhvrOANJLKbwI6OK2TfjIzM623gWC6IP9TWVwg8but49mk8+4nhs4AkQ/uO0+FzDD8
         z0+eRJCYFaGNo5aIfR3nIguIAdXfNIsHzw9ZCbxrVFEOiUnE0TOS/OiWnD48B0ioWu/t
         uvOw==
X-Gm-Message-State: APjAAAUxZ9Sa121jwm95Yq4N+nolFzG2dzvnDhP0YxvRsnTG4fxhf527
        HLZXVtv72eg04D6tTYBtIwg=
X-Google-Smtp-Source: APXvYqztpcAxKuxj+Aok9yVC+U1ZAFgB2+pDeKfb/4QaCGmSSDWhXBw5M0MhKZ4pGGLFPjk83KIEIQ==
X-Received: by 2002:adf:f850:: with SMTP id d16mr6884005wrq.161.1578516829937;
        Wed, 08 Jan 2020 12:53:49 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:49 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 03/10] ARM: dts: rockchip: add nandc node for rk3066a/rk3188
Date:   Wed,  8 Jan 2020 21:53:31 +0100
Message-Id: <20200108205338.11369-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Zhong <zyw@rock-chips.com>

Add nandc node for rk3066a/rk3188.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 97307a405..416b0d272 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -273,6 +273,17 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@10500000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x10500000 0x4000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC0>;
+		clock-names = "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	pmu: pmu@20004000 {
 		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
 		reg = <0x20004000 0x100>;
-- 
2.11.0

