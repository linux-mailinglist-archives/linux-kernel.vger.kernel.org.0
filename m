Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9555311F5AD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 05:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLOEZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 23:25:25 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48173 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfLOEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E16FE5AD8;
        Sat, 14 Dec 2019 23:25:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=JeR0cnryoywMK
        HwISvSewvjFYfRlDvtFyO5FMfPy1yA=; b=XBgHdhO4Xvt1A3axNmQfNuWp6NPJz
        PdKf50xbI6aXXF54u3H+59meFbQh1XEE8bIp1JTQYRgvDHg007nr+goNWIkss57h
        DvGgmTu2Afl6dZpUliXa7TbYmTbOLPXcQdjghc5XP27CtPw65hlOEUMLyiRjHsjE
        Z1NtEXNbsgZu4mOlrOb7o78yzXd901DaDQ/uQdtw1mC7xwLdFYSIvcYV2uCThgp8
        QoJLTsu0ECbAx+4c7qjsbCwsx0hWBhdywTJ1X4ggey5DMOmIji+gzYaI1vdp7SBi
        WfWM6lB9seX3DML8GKw5AGm+zU3UBl7s6MXprnN7rgpoRYyhHKSRscgtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JeR0cnryoywMKHwISvSewvjFYfRlDvtFyO5FMfPy1yA=; b=Legs+nZ4
        u/quZffYg8D714uR+n8AlFs1YdSOKulyg+5qv6Pg8Tk7t1nVgG+no2v5MjkVJWmh
        Ln2cY3WO005rVPvRI0WIC6ulWXiz1lsvTSyy5X247BOw8/CFQEFo2K2KYP8J8g8X
        bT9wM8YJ2GxxotQuPIFfDO/RBCpp+YVhQrXtZaM+LC28QB8jnCJcp7HXeUt2SRW6
        4Am4SXlYeru927B7tkTGMDsWArPXMSjP2VtaaXan6tekkCMJpkzdoc/AinhS//fr
        dOOH1qQ3UrUQjqXgE+ahv+9Z9HOFg/A4XMH8sfY/aHR+Ss2HLIsX7iXDZMlxu7jj
        oogYDurPB8hK2g==
X-ME-Sender: <xms:nLX1XdNI6GZsZaYg0-4bbejqvw4eb09AemPOcug9YScgtUXXRftv_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:nLX1XUOJ_T9rCjWao1X_dv32zPwuA7zWqx6B36HOVXtzljdjZVZsFg>
    <xmx:nLX1XXSQtG3FpDD5bjTcflMPOfJtkWKSS_ZyhMA0Vyk3emN_M0m_tA>
    <xmx:nLX1XeDCmMFM9Hww8OVdwKFgyU9ses2WoytM-ni4xWvMp-slq90QWw>
    <xmx:nLX1XVnxN3cIVF5Bhna_0Tb_1HgY4BnkyyIfrtfdAr7hYP-fp92JxQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A54580062;
        Sat, 14 Dec 2019 23:24:59 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 4/8] ARM: dts: sunxi: a83t: Add msgbox node
Date:   Sat, 14 Dec 2019 22:24:51 -0600
Message-Id: <20191215042455.51001-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A83T SoC contains a message box that can be used to send messages
and interrupts back and forth between the ARM application CPUs and the
ARISC coprocessor. Add a device tree node for it.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 53c38deb8a08..464b57d03dc0 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -592,6 +592,16 @@
 			clock-names = "bus", "mod";
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-a83t-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a83t-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.23.0

