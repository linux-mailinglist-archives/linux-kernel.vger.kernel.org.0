Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A664310FD1A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLCMDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:03:21 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59871 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfLCMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 90D9022400;
        Tue,  3 Dec 2019 07:03:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=lTMgt1HLjzp8s
        L+PteL0UcJwaA7usVkuzSVyWJEJXu8=; b=RR+21FlIAVje80xSbGcjFMlUfNPtv
        nQV+LDgnbhUlm/xqEXPfa/xgWCx/RKNL3oPXX9mHmkeZ5FRSTnfuPSFEICR3Yvtk
        2J9EBzNPR7HjQwfcX+K/uEHZ1jcKilZ2/rVFavq/Kq/6LhY+v8vdPCYoTpbN9IEz
        PtgyiBlXZ+JtyU+YXkgfKO9gRicy6MkWXJ6xELycOJYHYiBRjRj1MqRG2IrZeWQ+
        sonAPyAhNsDUimjBvpIr6zVyc3gqVI4jlJTeh/wTdyfl65nNlt4oiq6Ucynwcbiv
        kVyWQpaz5OFRVZgHKCU4iBxPPPWofyIJlvPS1QYgkZCN6X43RM4Aig21Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=lTMgt1HLjzp8sL+PteL0UcJwaA7usVkuzSVyWJEJXu8=; b=CV8XFhu6
        gU+QdLhBG5/YK9Yg/ylAugTOryxmjty/zk+dg+JzyJOZQgR5t/7xfAH+y5QLfap+
        GwpQxBUrL8JJgQ2M7sKybzc83xZY1cz3EkM3+YcKC8mLOX0PRZtYfjYDMBqmR3r+
        uW+hKvJnycjJP6biVWWe5LXI7k8bvyLYL0T5fDNL95jI9jGGgYm3xsNHRxB5YXNm
        fxYNweQQN6jNV2WRLYxY+Z1ozWUP0tngQsdHnaev+RbdB6+1taIXTHVmbKrFFkvD
        jBHC1FKKfyrLNHUSyBI5ks93wH41fw+uv2mJjpnlQAN4+0TkIDLNNExMZd8lXAg9
        1uL58/QyGHW8gw==
X-ME-Sender: <xms:Bk_mXcJfd9IhMsaVQsRCTh7_V0DUtXgb_IUVur1PtrvdtL08QObXSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppeduudekrddvuddurdelvddrudefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepke
X-ME-Proxy: <xmx:Bk_mXRmnTDCpl1NupdlprVw0iR0DZBrVqZw4CSRbfMT7eFRFSAFh_A>
    <xmx:Bk_mXRe71vo0pQYdZxVdoYqLADuwUHjvAZHs5IqX1u-LZDOddxsYlQ>
    <xmx:Bk_mXaW7K2nUD2dRaBz43t1J9ZW4L-zUhpp6_c8FNt_XKxH4woBfjQ>
    <xmx:Bk_mXde_FPJ7gVUkFek50lKO3_swb8RmNZWmstxWlV3-NiUtJxi9PA>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4B8C30600D2;
        Tue,  3 Dec 2019 07:03:15 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
Date:   Tue,  3 Dec 2019 22:34:10 +1030
Message-Id: <dff08baaac1fd2710b2db33fcac73c1411e1af6c.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check gave the following warning:

    Warning (avoid_unnecessary_addr_size): /gpio-keys-polled: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 39ba4d5a787e..dbcd3dd8b405 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -77,8 +77,6 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <1000>;
 
 		fan0-presence {
-- 
git-series 0.9.1
