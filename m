Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED7A98DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 05:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfIEDWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 23:22:18 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:18740 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfIEDWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:22:18 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x853LWmj015290;
        Thu, 5 Sep 2019 12:21:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x853LWmj015290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567653693;
        bh=9WB476Jgz2iwQGx8WhZTdMWCoqoGKePNIED8HdmTYP8=;
        h=From:To:Cc:Subject:Date:From;
        b=kiLVhU38zUPA7LQClZMW0sQWODRJX2F4UsE3x4zKxgNMRBycx0jt9yloe0LKQDCwZ
         C52osBMh2fmB07x5WN8kwdOEWM/gHY3Pg85mAbqBUa6aR13h3gcE4WS7T+ulBG2Uwh
         w/bZf/ulT7dlgTF5NneQ56FhEWLWYhwuCGjWp8RlIv2kieTJjiSwjnxs/RSb+xlb4G
         x9NwOTy0e09Nc4H/e0TlyrNBDG2qw93BNH5qmG3nxFl6YFqzv/Lk2lDGeympBrJuFB
         6HNkutN+BF8n+eQdOwiPni/t/ngJsYhJf08bdIoyjpqzIFtyh0MUpL51lAIiUHEY9x
         p1/sGsVffIBlA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] bus: uniphier-system-bus: use devm_platform_ioremap_resource()
Date:   Thu,  5 Sep 2019 12:21:22 +0900
Message-Id: <20190905032122.26076-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the chain of platform_get_resource() and devm_ioremap_resource()
with devm_platform_ioremap_resource().

This allows to remove the local variable for (struct resource *), and
have one function call less.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/bus/uniphier-system-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index e845c1a93f21..f70dedace20b 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -176,7 +176,6 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_system_bus_priv *priv;
-	struct resource *regs;
 	const __be32 *ranges;
 	u32 cells, addr, size;
 	u64 paddr;
@@ -186,8 +185,7 @@ static int uniphier_system_bus_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->membase = devm_ioremap_resource(dev, regs);
+	priv->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->membase))
 		return PTR_ERR(priv->membase);
 
-- 
2.17.1

