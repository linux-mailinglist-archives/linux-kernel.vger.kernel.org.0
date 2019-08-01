Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9681D7DC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfHANLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 09:11:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbfHANKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ta6SVOPfBEUXAoK68k+AFFQ870iLGBNa1TpwByQ+Eno=; b=COM4R8O8UblY
        lrUXmNhyDp2EkXu40KiUT7eZ/V89UGzoDIIp4mMbesfeWwl3wlMCAAXJsQynd4k8NgMTtSLv/pOGv
        6VDCEGLslICkfQ923UFaHHBehYhj8T4fd/Xw7rprt8DFcZ5KAeXDdCqtKYWOO4B+eY7SPSC5ZpqG7
        57lNI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAr4-0004k5-SQ; Thu, 01 Aug 2019 13:10:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 64F9D2742C48; Thu,  1 Aug 2019 14:10:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: of: Add of_node_put() before return in function" to the regulator tree
In-Reply-To: <20190724083231.10276-1-nishkadg.linux@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190801131050.64F9D2742C48@ypsilon.sirena.org.uk>
Date:   Thu,  1 Aug 2019 14:10:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: of: Add of_node_put() before return in function

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 811ba489fa524ec634933cdf83aaf6c007a4c004 Mon Sep 17 00:00:00 2001
From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Wed, 24 Jul 2019 14:02:31 +0530
Subject: [PATCH] regulator: of: Add of_node_put() before return in function

The local variable search in regulator_of_get_init_node takes the value
returned by either of_get_child_by_name or of_node_get, both of which
get a node. If this node is not put before returning, it could cause a
memory leak. Hence put search before a mid-loop return statement.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Link: https://lore.kernel.org/r/20190724083231.10276-1-nishkadg.linux@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 397918ebba55..9112faa6a9a0 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -416,8 +416,10 @@ device_node *regulator_of_get_init_node(struct device *dev,
 		if (!name)
 			name = child->name;
 
-		if (!strcmp(desc->of_match, name))
+		if (!strcmp(desc->of_match, name)) {
+			of_node_put(search);
 			return of_node_get(child);
+		}
 	}
 
 	of_node_put(search);
-- 
2.20.1

