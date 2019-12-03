Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E824510FD08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLCMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:02:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59329 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLCMCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:02:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CC3792237D;
        Tue,  3 Dec 2019 07:02:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=oRxzRdsRajLK4
        JLtN6NWanmeTYQX2/mKS46TueKiHxs=; b=SNIn+/zFo3+mFdkF6++DmHSZHHHu6
        ttx7/t2SQzEMzMUKTrVUX0o3Y1xqA1Y04h13HKf5i9FSxY+uk0nwPJaxaskURDam
        T+pU8/8ABB3ERXcMzfqrto1rzqCz/RAdr+uYrWQSyprUJ07JJOYF4lUzJjoQL/uf
        GanzHn9uMgAwDgXz5hXI2aEU78KRmdXLwgo2WbOUuUdWRqsPCyIAV7jEbIVkKUrr
        TA7/ag+bdWMfexRs8AcL3oPJiNfGlJ/PXbiHqh35ky5cd6oUV+Azrq6+SwdeUqVj
        Uaq6f+o+061OD3Ilt1lOZw4Oeu/f8BaVuSyNK/2gulDdrHSRthJzXIc7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=oRxzRdsRajLK4JLtN6NWanmeTYQX2/mKS46TueKiHxs=; b=OgQv4yXY
        t+E+NbNh0VXE/v0ql2eKf9ExaWMZWYPNsqUH0zEbg5PsnoIbADyySUPy3iMvmwIX
        TyxrqoRYmMp5ASgy5sXll8Xqgpj/pGiiWCh9lSDR6G75XtoAejkYmnAJy7HgHqwD
        DvIZpy6dFwsOs4yFpSRpXipYclWC/Nbdk/XlCB8cDYfm0SZjBVzN2yzyWvteRVwm
        stT/0VbwRx3rkCB3pQOtchdKgMO5eD/vpfQWAECu2CjPwpnkzK1fy6v/ZuK2qHqL
        PMjF3l+4CILAX3CiLuFKNDxcDbGNMAdM1155rEFys1INQG/ZnEcVobgrAVwnAlDm
        /mCxx5UocYe5vA==
X-ME-Sender: <xms:7k7mXYyRk7xsKZpCLFJqelq6Y1D9QPcHGMN64NxC7LoEkWKjjImRvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:7k7mXUpJBnoXPAxfC6v0jFikcKS5gGc18ZcjFVnhBj8IiSmdNymgTg>
    <xmx:7k7mXUn29PdTT01nQJdvkOK09yYl1WLE9u_RimfFhGCcl5euPIizQQ>
    <xmx:7k7mXbF8vRmYaBwHtSgkm_FbkNkELQ-qBh892ACZxWxXzSckxsjy5w>
    <xmx:7k7mXZ7HFc070Fr1csz3pYcV5-fSrjT6t0wQYncvCLz62OmSE4OR2g>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id A4723306010D;
        Tue,  3 Dec 2019 07:02:51 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH 03/14] ARM: dts: aspeed-g5: Move EDAC node to APB
Date:   Tue,  3 Dec 2019 22:34:04 +1030
Message-Id: <73940993d9dd958984ed3f9a0c6c15f7f17ba556.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the register interface was not attached to any internal bus,
which is not correct - it lives on the APB.

Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index a8ce59a3c88d..edad1fd78925 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -47,13 +47,6 @@
 		reg = <0x80000000 0>;
 	};
 
-	edac: sdram@1e6e0000 {
-		compatible = "aspeed,ast2500-sdram-edac";
-		reg = <0x1e6e0000 0x174>;
-		interrupts = <0>;
-		status = "disabled";
-	};
-
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -213,6 +206,13 @@
 			#size-cells = <1>;
 			ranges;
 
+			edac: sdram@1e6e0000 {
+				compatible = "aspeed,ast2500-sdram-edac";
+				reg = <0x1e6e0000 0x174>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
 			syscon: syscon@1e6e2000 {
 				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
-- 
git-series 0.9.1
