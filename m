Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A769382155
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfHEQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 12:10:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfHEQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7Uxl0ZKm2A/r9ieAhBWOkTy1zwF3j76as57EGlYyu9I=; b=D6f5etZHZXU1
        ZcIVVhu/b6t5MSuZ4+AZpde1JnryV+eEaiF3OkgQ4VnPyc6qJnaeVm3jhBBzqC9Q0QOAxeFmEnaK8
        gSPZAu8+fpRu9edk9I3xNF/N89Q2GnvxnCrRuaeV0+b3OzNsrNeH9q1OepEISYF/jvdw9Aw7O3U4u
        TQUn8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hufYm-0000n0-Di; Mon, 05 Aug 2019 16:10:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C232B2742D06; Mon,  5 Aug 2019 17:10:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Add of_node_put() before return" to the regulator tree
In-Reply-To: <20190804162023.5673-1-nishkadg.linux@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190805161007.C232B2742D06@ypsilon.sirena.org.uk>
Date:   Mon,  5 Aug 2019 17:10:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Add of_node_put() before return

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From db2a17320a25a63b46ddb081a306af9ded1b906e Mon Sep 17 00:00:00 2001
From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Sun, 4 Aug 2019 21:50:23 +0530
Subject: [PATCH] regulator: core: Add of_node_put() before return

Each iteration of for_each_child_of_node puts the previous node, but in
the case of a return from the middle of the loop, there is no put, thus
causing a memory leak. Hence add an of_node_put before the return in
two places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
Link: https://lore.kernel.org/r/20190804162023.5673-1-nishkadg.linux@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..7a5d52948703 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -380,9 +380,12 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 		if (!regnode) {
 			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode)
+			if (regnode) {
+				of_node_put(child);
 				return regnode;
+			}
 		} else {
+			of_node_put(child);
 			return regnode;
 		}
 	}
-- 
2.20.1

