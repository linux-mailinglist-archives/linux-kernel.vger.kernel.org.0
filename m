Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3E6162585
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgBRLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 06:30:55 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60883 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgBRLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:30:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D8610727;
        Tue, 18 Feb 2020 06:30:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 18 Feb 2020 06:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Dg2Cd9EZBtYB1HWPx6/lUlj2Ii
        YhZqrvqg7YHhAG3aY=; b=bZ3GcoAkurSfDs9AeIRql7IS0oB+3lENUOtz9+/KcK
        l1/3CbkoWiTCkhI+MIn+0JtunJZQ1p9GEhaYHbbyLMPhRX0XCRvmJQYSfnAD6YcH
        hyu0INbXLMgfFI/9C0lxGtPjG46KByzpVo+GAd0AgDrk5s8imUfai/budHWiObuZ
        osKy6PDf0n9O8VzhbyOzIMlXwe+ktPEUe5zUvhPE/Qy7SKNNKBGLeNi6HMg6lmMW
        qYMRqjtI//ThZ8symHWY533BddicjuT5ql51x9NJYwBtmGLg+1+dGY5F/6XPbf8P
        S9KjH25e1NFWLWJHLHvEz4cvIHN3Hc+Q+jqUX26rJBQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Dg2Cd9EZBtYB1HWPx
        6/lUlj2IiYhZqrvqg7YHhAG3aY=; b=cx/Wg/eA1Hy4SSleVZwqCF1wCWeF+MjBm
        KXFjRAvqdclkdQetYFGD6/8Qw5WOQNf4MijYhp57D6m5Yd0G5GrBjOzTDEhtUGuy
        NPaqe1cSYuILqjj2I5FVhMq80OpWAsBMobFzpOEuWXEmFNLZZZbql7IxBKp5Y7Ha
        +6sHerWIEL79SauZEbLMTjfW+RSERhEZIP7Bql2qth6nJfa5PIvB5Fu2A9xGZQsI
        paufJOxO7HtUP6942t0A+wKR1n+Edi+AVzDtOmYJIyvpkudYA+Z1ZbahQLT+8KoT
        Etatf4jpNDHfRcUbNmXm6ywZ+Xt72fRHh5hS+ra6/g0y+0ocCYbZA==
X-ME-Sender: <xms:7MpLXj4xtwTuHmXD0o08Rt_dl9BRvnCrImoQz2_NbCJnLB8lI_w43A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhi
    ugdrrghuqeenucfkphepudegrddvrdekvddrgeeknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:7MpLXm9hrLLQwU1VaPo0_5zqzlUp8TC6nuFjJrrN02dMPnd8rYTx6g>
    <xmx:7MpLXqcxpakDEBW4zo3RC8U8yd1Y7cFzZWmU2ViUl5S3u64U6z5kYw>
    <xmx:7MpLXrLMfo3Q3tjOB3D5WUmQWACf-kQqsVWbJBcu7Vj6CtMmbkuACg>
    <xmx:7cpLXlcbukHKbtcHOrt7XghT_mq7DKpX-0Qla09Jb4e0SS0xBiKXfg>
Received: from localhost.localdomain (ppp14-2-82-48.adl-apt-pir-bras31.tpg.internode.on.net [14.2.82.48])
        by mail.messagingengine.com (Postfix) with ESMTPA id 937DD3060C21;
        Tue, 18 Feb 2020 06:30:50 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: rainier: Enable VUART2
Date:   Tue, 18 Feb 2020 22:00:52 +1030
Message-Id: <20200218113052.28392-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second VUART is used to expose multiplexed, non-hypervisor consoles.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 6232cd726a7f..61d4140a2601 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -540,6 +540,10 @@
 	status = "okay";
 };
 
+&vuart2 {
+	status = "okay";
+};
+
 &lpc_ctrl {
 	status = "okay";
 	memory-region = <&flash_memory>;
-- 
2.20.1

