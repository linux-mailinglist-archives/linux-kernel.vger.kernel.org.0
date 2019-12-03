Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9333D10FD0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfLCMDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:03:00 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49521 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLCMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:02:59 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A6242237A;
        Tue,  3 Dec 2019 07:02:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jm30yheMpSomj
        rpkWzReiyBbV2WMRj2TirNvmaUSIp4=; b=TyQTwPFhVMdXHf+7WolpbPFfUTAOA
        Pdy42plpu8GtDEYyY2+WL32jg/QmINT9wLAPPi+8sX0PeSsIbyrxiiqM6844/nug
        ihDvzMJTB48O950sroHoeSbEFWNymyS2N99ihvuSdaKcUrAUEXoKfxnr9y3cjjc4
        m6x7G1BmpOJTdEWXk10WQBupkuTzTA6IQMN2pbk2LFlZB7Znais6QgU1398SZ/lP
        GGwbb51x8OETwStsVTwfjgWD3cdeU7ibqintvTJSxY00/BtMnsbqPtX/eUjryt+V
        rBgcK3q9/6UUG4GBbZ7leX8rgI0d41hfmj5SsExuMbhp7btRGzzFG69Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jm30yheMpSomjrpkWzReiyBbV2WMRj2TirNvmaUSIp4=; b=kXWM650D
        pK2kod/FLmXZJFV/Hxbc71i8z89ybmHfGDZmSmfxy5Le005htDfrrWylETR4/rOV
        Ziuxv1KEkg25ypGB1OPImFRbL5rI9m+xAi6Qlhb0N3bqbCEcKoOzvf1LpI1Wx5rY
        k0+VidZKri1EWnb6pTUAZtudD9MeKJ0sCptxvPokLufoeMmqPsr1wJY1XWoYBg26
        irlVm1BRr5tkClhiye74ksz1hYfw9GT68hQpLvBYOECCzjAy8dBKmFWrR4tdRBA7
        PDC/wHsyMeiq0gZhSCbido7Rn4TiUyisoh5NJBhrCMLSugrPrqFO01maHz1KrjDB
        WVCcz7kcUEZvpA==
X-ME-Sender: <xms:8k7mXbscz4FaJIyES5A5kWth5HppQOQufM4w5z6i3WDxkLQyMN2ihw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:8k7mXcKrG6EBQCI2BULgXWIywLn0-wXsj6V2G2kW5szo8VK3WYPADw>
    <xmx:8k7mXUsgjvaXqKZxqGZtA7EycLncmWjYzrT5wMwbTWVBTcIoFwePOw>
    <xmx:8k7mXUfeUrKBlhIX2JnVO41T6E_lrkbs7Zp0MpiVaSlogN_TNy5Ynw>
    <xmx:8k7mXfZqyAHvvVbKcB6Ur1yB0vE5pZE5afabjHicgKKVy7G2gvxvsQ>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3EAE5306010D;
        Tue,  3 Dec 2019 07:02:54 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH 04/14] ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
Date:   Tue,  3 Dec 2019 22:34:05 +1030
Message-Id: <f6963e3de99508b1053e7d96e4dbb05cb4bef3be.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EDAC is a sub-function of the SDRAM Memory Controller. Rename the
node to the appropriate generic node name.

Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index edad1fd78925..d8d358e23d78 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -206,7 +206,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			edac: sdram@1e6e0000 {
+			edac: memory-controller@1e6e0000 {
 				compatible = "aspeed,ast2500-sdram-edac";
 				reg = <0x1e6e0000 0x174>;
 				interrupts = <0>;
-- 
git-series 0.9.1
