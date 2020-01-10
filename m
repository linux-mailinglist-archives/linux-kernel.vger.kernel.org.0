Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A5136E34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgAJNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:38:17 -0500
Received: from foss.arm.com ([217.140.110.172]:44594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgAJNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:38:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6FF1063;
        Fri, 10 Jan 2020 05:38:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07EC93F73B;
        Fri, 10 Jan 2020 05:38:15 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:38:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: Applied "regulator: mp8859: tidy up white space in probe" to the regulator tree
In-Reply-To: <20200110055252.rvelu4ysvoxsbmlg@kili.mountain>
Message-Id: <applied-20200110055252.rvelu4ysvoxsbmlg@kili.mountain>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp8859: tidy up white space in probe

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From b83380512e955f538366c33dd79d660cdac2875c Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 10 Jan 2020 08:52:52 +0300
Subject: [PATCH] regulator: mp8859: tidy up white space in probe

These two lines are indented an extra tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200110055252.rvelu4ysvoxsbmlg@kili.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index e804a5267301..1d26b506ee5b 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -123,8 +123,8 @@ static int mp8859_i2c_probe(struct i2c_client *i2c)
 		ret = PTR_ERR(rdev);
 		dev_err(&i2c->dev, "failed to register %s: %d\n",
 			mp8859_regulators[0].name, ret);
-			return ret;
-		}
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.20.1

