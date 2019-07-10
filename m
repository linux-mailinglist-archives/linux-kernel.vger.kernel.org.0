Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A039B647EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfGJOP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 10:15:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40581 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbfGJOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:15:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A98BF2213D;
        Wed, 10 Jul 2019 10:15:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Mo4UV5dPvBvsW
        DVJmnWOkPJbV5m2bJ8R6q784AbeQ54=; b=hEfa8IVJ+15tuBHc0n2ceaDlQ9zcO
        CfUNB9QjGJmWlfc/RpHLfgPwDxLi8Yf85w1Nlbvx650ALoE6QDHBmzrkYOzF66qR
        /KSnzIEeOZWK3Vsqxn6RdGJxr/EFzaTXxbDeiHzztvAb58Qyxtpe7xFjoMAsahD6
        bQsTPJD3XsKeeeJvL9wSH4jQliATIOiT+9GNXvtr7+Wo+bvaiJ61xhZW5cJRcip/
        6nTAdZnpSRuXM71a99w+mvIKfE1utOEfuybhe0LtJiJS8gGvR29KlEr5JLXhz3o9
        iX96fk5ieclv3PW1iI2lEq4WxMJRQCJZMAKmjBI2OJvph0bh19H9rdnsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Mo4UV5dPvBvsWDVJmnWOkPJbV5m2bJ8R6q784AbeQ54=; b=V3UszYlB
        ZsNKJKc8MbcYlz04Aa5EolyEbND3/BFFGdKV4aUFk80+QNpj4GUI1aoYz9rY3Pqg
        txFxw4+qzJJtMap7RNE+nTE2M4OvOdc36Ov+iV5VSQVqE1STuT7KwIht5W/xzibX
        Ve5a5gQ20lhq2Xm2tR/Ul67WUXG8HDro6Tqhzq5rEDGt56kGYirv0mspcs7pwX7f
        rRo6ltTa+QIxoKPpnhTQmu4N+r3D/LIub4ebXAphjjP6axn32GU9uTSAHePVzKDG
        8iEt8o8vM5FMFZ+AImoUqee2fqm/pAQzzFhqR7nQq1po9MglXGK4we4KxQH912Gj
        qSHySg+V1v1eRA==
X-ME-Sender: <xms:-_IlXdW5Oz0xFMwoPIBOInbYEV481NzzXz5eDWrU7fLmdCas2aK8jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedugedrvd
    drkeehrddvvdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruhenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:-_IlXZusYRqbHjy6HT_F_XsYUlKgtJuq90TMag3Hk7t1wTPGXlIgbQ>
    <xmx:-_IlXVMM2K08bDyYCvGcY7mKdV23t9mL1vaqj1VzetOud36qF2nklQ>
    <xmx:-_IlXZps8AmqWEFWktmZndVzpExwgEcKXOcplxYaAdFy8OHvgPX6kQ>
    <xmx:-_IlXZUh7OlZSnpRhXBXXi0sRg1e1pDmzW1nZqkuQqWEQPJiN6dz2g>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D20680059;
        Wed, 10 Jul 2019 10:15:19 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, ryanchen.aspeed@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: aspeed: Enable both MMC slots on Swift
Date:   Wed, 10 Jul 2019 23:45:03 +0930
Message-Id: <20190710141503.21026-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710141503.21026-1-andrew@aj.id.au>
References: <20190710141503.21026-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Stanley <joel@jms.id.au>

Swift will provide at least its rootfs on eMMC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index f1356ca794d8..fcaeae2dd0a8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -640,3 +640,21 @@
 &vhub {
 	status = "okay";
 };
+
+&sdc {
+	status = "okay";
+};
+
+&sdhci0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd1_default>;
+};
+
+&sdhci1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd2_default>;
+};
-- 
2.20.1

