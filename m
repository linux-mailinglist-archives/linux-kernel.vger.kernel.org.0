Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F599C331C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfJALmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:42:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387543AbfJALlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zDFxt27zzlk0hzRbhmXUl19BWWqNe/+DnvGIxSIWc9g=; b=mYkGoHq8NgmU
        9pVQiw6NgNCyHPIFIt2Hv28ojukPlv69pn4XY1GqDXxx1KhGvT5VRl9KNMfXqbXPv/E9//WSBw4t0
        k81Ow7+2Vr3g2Gj24DqOlRhB0QDIc+mtRbQQqe3e+L2TVvXTKKRwPhMvH5GrkATvVw9qCqWKMCPng
        qnD6Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWZ-0004XF-0Y; Tue, 01 Oct 2019 11:40:59 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 767032742A10; Tue,  1 Oct 2019 12:40:58 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Balaji T K <balajitk@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ravikumar Kattekola <rk@ti.com>
Subject: Applied "regulator: pbias: Use of_device_get_match_data" to the regulator tree
In-Reply-To: <20190925101256.19030-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114058.767032742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:58 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pbias: Use of_device_get_match_data

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

From 41145b980e3f4c7c26763fae0379f1cb8f336868 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 25 Sep 2019 18:12:56 +0800
Subject: [PATCH] regulator: pbias: Use of_device_get_match_data

Use of_device_get_match_data to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190925101256.19030-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pbias-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index 92b41a6a4dc2..a59811060bdc 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -164,7 +164,6 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	const struct pbias_reg_info *info;
 	int ret = 0;
 	int count, idx, data_idx = 0;
-	const struct of_device_id *match;
 	const struct pbias_of_data *data;
 	unsigned int offset;
 
@@ -183,9 +182,8 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon))
 		return PTR_ERR(syscon);
 
-	match = of_match_device(of_match_ptr(pbias_of_match), &pdev->dev);
-	if (match && match->data) {
-		data = match->data;
+	data = of_device_get_match_data(&pdev->dev);
+	if (data) {
 		offset = data->offset;
 	} else {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.20.1

