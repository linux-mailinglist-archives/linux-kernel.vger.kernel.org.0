Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1DC334A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfJALsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:48:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53130 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJALsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Zrg6BngKS6o+5PSZfNmDViyOQ6WxCm6/6L9VMBrS+Ao=; b=oobNDfW22f8t
        dHSmFIHpY804aCILp746q8H23HJkQkGWZ8iCNIGsBx009h7dbXFBIpn7yyH4akJCTc3EN6/m/V+Mn
        JxcuzLrHuQDVqRKIQueR+NS2Ig58S2abZp/eOJks56Cw2BV58VGKrTG4HnvrhUXqPDc6XiBH3OzcM
        XDUCU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGdU-0004cg-GL; Tue, 01 Oct 2019 11:48:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F120227429C0; Tue,  1 Oct 2019 12:48:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: pcap-regulator: remove unused variable 'SW3_table'" to the regulator tree
In-Reply-To: <20190928085540.45332-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114807.F120227429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:48:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pcap-regulator: remove unused variable 'SW3_table'

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 182a1d8bc4ed30f5e0bb7fb52606fa1888430ca4 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 28 Sep 2019 16:55:40 +0800
Subject: [PATCH] regulator: pcap-regulator: remove unused variable 'SW3_table'

drivers/regulator/pcap-regulator.c:89:27: warning:
 SW3_table defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190928085540.45332-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pcap-regulator.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/pcap-regulator.c b/drivers/regulator/pcap-regulator.c
index c2469263db95..0345f38f6f78 100644
--- a/drivers/regulator/pcap-regulator.c
+++ b/drivers/regulator/pcap-regulator.c
@@ -86,10 +86,6 @@ static const unsigned int SW1_table[] = {
 
 #define SW2_table SW1_table
 
-static const unsigned int SW3_table[] = {
-	4000000, 4500000, 5000000, 5500000,
-};
-
 struct pcap_regulator {
 	const u8 reg;
 	const u8 en;
-- 
2.20.1

