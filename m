Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5C6138A59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 05:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgAMEtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 23:49:46 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60843 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387608AbgAMEtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5D8B0657B;
        Sun, 12 Jan 2020 23:49:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eSYYFPyUyxZ0R
        tyfs3BMeEOWH0PFF5jUUQ1YKpLnMkI=; b=gKiqUekW1doGrmwCeHQ/gF5R8/otF
        JIRUpY9sNCDyeGBAXqWIfFcOcoFuFbp8zK2y2C+TVAbXgGo/qs8bnOwKkmPpRXrN
        LeZFO3593OEaj/F8UUruy75DYIR7OGU22fHz39dMLdse3xm9PY/Ii17i5o/RtEkV
        t4gIqtacShe4HICfNi8qF+hf77DN+nMsT8TMduCBIXNjmwpzPHDi5mXCbQMrvW4n
        /o1x3ApI0pT8a75jJyDDWcTXxvCTPKL0zqhtL5MuB4/MNrWrheNmscRiKh6wksNL
        NVHocz1f+/Ea0Qa0YtiepyLJw1IzxIeFGgAM+TXWPCUD6ffoO3Ij+VByw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eSYYFPyUyxZ0Rtyfs3BMeEOWH0PFF5jUUQ1YKpLnMkI=; b=AWfMgKEq
        3K8H6UJi6eCyJyXxYi9hi2I7N+pRP9yPFpfpvJzhtewZ5VE6O/s7g6hdKbTJlFuX
        AVGOELV8zNgE5GctgingTVF7Y5AzvDp03zzUXRJ1urDq6D4JJl1x/hTaog6kLWPK
        zdKIYwN56PRI3loiIw0vOxH/sOrvJ1BeHaqr6hRKGmQmNCj/+Pe+pUesm+fSr3NR
        fWQY32vTFbN8YHTNmN35fzgH/tEgSiLBd6nMy+4n7D8HMf2DrdtGMU8FHTWV3/gq
        uUKO2gPeoTtiHjRy+DLV8uE5c9ZFAeI8vY/Gbs4T+305PyG1Rmzd47xGnhKQzC9X
        Oa68FTTJN8guWg==
X-ME-Sender: <xms:5fYbXhPOAO-ZGvFWK0Wu1NZapj-ZmLG69e12_zLZkuPnYU0mheXFYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:5fYbXoUJUrhdtRiOhPIeEsfSsTKR8CgYQhdu93L-PMhad9imfg4isQ>
    <xmx:5fYbXuLIxX4DNToAASAA0zzwG41mo6_S2wSDy8_wCQKJq4cDenz0XQ>
    <xmx:5fYbXroqlB_SBdQy4IFktX1GWLqxnj-qnCTcYCOMmnYtEtaKV5jQQg>
    <xmx:5fYbXvsJGkoFyAN6FQ2L1Z--hhvo8z563SQTpEMR3JFktfKJtCXV9Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9DAC130607B0;
        Sun, 12 Jan 2020 23:49:40 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/9] ARM: dts: sunxi: a83t: Move wakeup-capable IRQs to r_intc
Date:   Sun, 12 Jan 2020 22:49:33 -0600
Message-Id: <20200113044936.26038-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IRQs that can be used to wake up the system must be routed through
r_intc, so they are visible to firmware while the system is suspended.

r_intc IRQ numbers are offset by 32 from the GIC IRQ numbers.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 74bb053cf23c..98513f2af21c 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1103,7 +1103,8 @@
 			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			resets = <&r_ccu RST_APB0_IR>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x01f02000 0x400>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_cir_pin>;
@@ -1113,14 +1114,16 @@
 		r_lradc: lradc@1f03c00 {
 			compatible = "allwinner,sun8i-a83t-r-lradc";
 			reg = <0x01f03c00 0x100>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&r_intc>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>,
 				 <&osc16Md512>;
 			clock-names = "apb", "hosc", "losc";
-- 
2.23.0

