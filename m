Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D4C134BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 20:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgAHTp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 14:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbgAHTp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:45:27 -0500
Received: from localhost.localdomain (unknown [83.218.167.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD7420692;
        Wed,  8 Jan 2020 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578512727;
        bh=UWvJw/1tjXL2bFxBI/htLgWEov4V8RdvLBEJR/vcWsM=;
        h=From:To:Cc:Subject:Date:From;
        b=Ir+6rvcsIKXMUri+0JtQkKw0XIbOwB37L48UjvF9Z38NTanu5M4850mUlW7Pki3d8
         bA0yP8katDtqs80Pn/rhIOVWexZy+Ah2QTXZToeyFEH9vxfk7uSTqohvLs5+TgsFpA
         LoNl8svOR5wzYhG3F+8vgfWYTIkIhQ/0u02Qwp9M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: sh4a: Remove unused tmu3_device
Date:   Wed,  8 Jan 2020 20:45:20 +0100
Message-Id: <20200108194520.3341-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove left-over from previous cleanups to silence the warning:

    arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
        warning: ‘tmu3_device’ defined but not used [-Wunused-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 4b0db8259e3d..22d1c38f742f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -229,27 +229,6 @@ static struct platform_device tmu2_device = {
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
 };
 
-static struct sh_timer_config tmu3_platform_data = {
-	.channels_mask = 7,
-};
-
-static struct resource tmu3_resources[] = {
-	DEFINE_RES_MEM(0xffde0000, 0x2c),
-	DEFINE_RES_IRQ(evt2irq(0x7c0)),
-	DEFINE_RES_IRQ(evt2irq(0x7c0)),
-	DEFINE_RES_IRQ(evt2irq(0x7c0)),
-};
-
-static struct platform_device tmu3_device = {
-	.name		= "sh-tmu",
-	.id		= 3,
-	.dev = {
-		.platform_data	= &tmu3_platform_data,
-	},
-	.resource	= tmu3_resources,
-	.num_resources	= ARRAY_SIZE(tmu3_resources),
-};
-
 static const struct sh_dmae_channel dmac0_channels[] = {
 	{
 		.offset = 0,
-- 
2.17.1

