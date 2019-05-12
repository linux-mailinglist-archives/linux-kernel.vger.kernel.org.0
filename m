Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42041AD93
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 19:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfELRqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 13:46:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33929 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfELRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so3063849wrt.1;
        Sun, 12 May 2019 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FMzWU4kL/7cfSe9GLA2ni0LaXmAg+HUWUsDdn5ujQI=;
        b=dW7J2KNsq7L/8WnVMBpe0g5cOhxv/1O8zR/XignGtRI7/ohYqcUttaEzisem5rIzVq
         TDoYnZw1GK9I+fKuAgxihTbtmYLjQlh11kODNTfU4pACXLZub9JT0mdYTt4JTpTb9RVX
         UH2AyJNYmIU8DDsimdjmhtMhg3vixBvicryCW3Jp3t5o3bBkZ2X/2wEV4H2aQpuktaPu
         m5pnevbt48p9xjeXHyNzvmPCX8l523SUMjctrrbfCaMqkHV0MLMVghyBzCbk/c73W+e+
         csj1gcE+j7demTu+OwiEDASk6bQSZfun22Q/xh1xP3/5uAUzMeOP0U31jw6ypwlaHW9G
         aOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FMzWU4kL/7cfSe9GLA2ni0LaXmAg+HUWUsDdn5ujQI=;
        b=tUMlYV5ePa+q/wpB8YWZX4QoY61Ah+oFK10e4AHoAaHdtvo4cncUCTZU3pIqPC6Di4
         wfiEQGYti8NRbZDJGQIgf+7u8FsLkuL6jsaf0sqw4UhaM48aGvmrfnOHb40W8Y8CD7+M
         oJ7RTGXQD7bG2ud3J/rxDvT5694Tc3NoyN56GPfH+MyvJu7xp0BYKlOYTOem50T/+ZaA
         2ESwTgP8QB3QNE7+L7cYrKy4+KBdKnVt8X3g6Kww+YfRGjkSRqOFIUd1xR7qwZafcPSk
         u/1EtorVRNZn2n7RLlVvPBFokr8SIsZLIDp1VDyg8Z+je0OPWkGJOPi2pkN4uDnj4bsv
         fE2Q==
X-Gm-Message-State: APjAAAVSKod9JREri8N7PYPWlxYJ/JNpew3v1/UKsrM67Ap/O3cFxR+f
        r6xgAMUozB9QrkEGio0uGNQ=
X-Google-Smtp-Source: APXvYqxLR33kLqVeufhwDeW/jJLuiemVx7ENonuL8c+dIbenss+tXjrpQm8GTkH1++RQ9p3NpS/vuA==
X-Received: by 2002:a5d:54d2:: with SMTP id x18mr15171610wrv.186.1557683180041;
        Sun, 12 May 2019 10:46:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:19 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 4/8] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date:   Sun, 12 May 2019 19:46:04 +0200
Message-Id: <20190512174608.10083-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
References: <20190512174608.10083-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

Add the mali gpu node to the H6 device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index e0dc4a05c1ba..196753110434 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -157,6 +157,20 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu: gpu@1800000 {
+			compatible = "allwinner,sun50i-h6-mali",
+				     "arm,mali-t720";
+			reg = <0x01800000 0x4000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
+			clock-names = "core", "bus";
+			resets = <&ccu RST_BUS_GPU>;
+			status = "disabled";
+		};
+
 		syscon: syscon@3000000 {
 			compatible = "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
-- 
2.17.1

