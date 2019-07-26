Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2B75E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 07:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGZFkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 01:40:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56457 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfGZFkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 394F222131;
        Fri, 26 Jul 2019 01:40:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=HIlXPSjKgK5qU
        xVhM3BUkxF4hyG95XBN2iVQvkJ99FQ=; b=G2BHcXk0PJY9s/xfFwAzcYhSMCR0C
        DCHepIqJGNpIF2ZZdJkbsTjRizyTOeR/1/E9mhNgWgI19IZkBGnni8NGhgr4UETb
        xx+9httKsAukin6Jr2QRz822tnDNjZa5mdo1YBTUzKfiKshsAQL7KcweOWm9UDmZ
        /5wUdHYvm8XK6Kplb3i7SMZL3W/RiyqpcbqUGK8/AuyK2jQcLOm1CQZG3lw7lKkK
        L4nAWwkeh71f/8U2rb2aF22S8tdEby3plP23AxXu6KoBWfXVOnPmunup8EXd0NA+
        wRp6JD81sLzqefeGj6hQ6SLIgXx0LsCclX1ZcTjq5XvWYSBxc/eXWEigA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HIlXPSjKgK5qUxVhM3BUkxF4hyG95XBN2iVQvkJ99FQ=; b=RaX88la1
        /8mfNU9bjbL+KsZrAQIMq5BHujxJYav2lzb0uASDWeogcfZzmCQuyZrxT34iBLJC
        D8u7Lv7pWDjIzFE0LCPPswMaw56qKGl7/AyKQCxl/2s28qfvBRj8w4RszXkwZ5Ul
        IDwQ6VIQ6P/fBqKBGsG2tjxItHHeW3AqooPJgCd3H+sAgUOSbMHuDKk5ghaqT76b
        5zxDeDW5k6BGcO5+BAPxKyzxUMv2ZCWhY85TrRFosAQil30INRhK6REo3yUTfvj1
        K+Tx7GcI7RttQT1pa+ZG7PCpyZpqdXsLFGOQg/9bk9G4RdDPbTr3xB0lis6xxQ7z
        Gf+VBKKcoeCHcg==
X-ME-Sender: <xms:QZI6XbsKaVGsM-KOKcH713c2RoXLLPECCb7af3KTALJQ6bs-5p9Edw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:QZI6Xd7lsMlldboqtKETyZcNu4OQ387q6XMenBKZoSZ0-A-comDLAA>
    <xmx:QZI6XaKLNWBDVqr0dKwFExgmjJjkbJbxClWYxnurdDJhv0EE_EmDHw>
    <xmx:QZI6XXT09mFm8fjXsnRj3MivOzSX5BMYuZaodn6WFqL-WbwAggHcrw>
    <xmx:QZI6XYJJsJWWmL4I4lKgTtwX6o-uF79RdcwLgSe-rZzpQI0YGLyuaA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1ECD380076;
        Fri, 26 Jul 2019 01:40:13 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH 04/17] ARM: dts: vesnin: Add unit address for memory node
Date:   Fri, 26 Jul 2019 15:09:46 +0930
Message-Id: <20190726053959.2003-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

    arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: /: memory: False schema does not allow {'reg': [[1073741824, 536870912]]}
    arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dt.yaml: memory: 'device_type' is a required property

Cc: Alexander Filippov <a.filippov@yadro.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index 0b9e29c3212e..81d9dcb752a0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -14,7 +14,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0x40000000 0x20000000>;
 	};
 
-- 
2.20.1

