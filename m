Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E297BA67E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfICL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 07:57:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52812 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfICL5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/0nVzZLscQEkPV21dY0hCRFyg/dKRi0kgvgnarXzPLo=; b=Ymon4Vioox5e
        kbeDb0mwCldrxjluTgBxtAAcCgCx85UfVTherPsUahZIUV1ThYC0AvnHurAN55ZBYH8ZNuVZrhfRU
        LUEOKBE4EwoU8/R+G/e+Npuv/y7Sh2LsUbjV1I3wZywAQJAcSIOOq35p5RYLD7lfU0E/zUjXiYDdc
        997PA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i57RQ-0008Lo-12; Tue, 03 Sep 2019 11:57:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 912A72742D32; Tue,  3 Sep 2019 12:57:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: add missing 'static inline' to a helper's stub" to the regulator tree
In-Reply-To: <20190902151332.28058-1-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
Message-Id: <20190903115743.912A72742D32@ypsilon.sirena.org.uk>
Date:   Tue,  3 Sep 2019 12:57:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: add missing 'static inline' to a helper's stub

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

From d072cb263f9e0ce3f8f6089c17e3466885971fa8 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 2 Sep 2019 17:13:32 +0200
Subject: [PATCH] regulator: add missing 'static inline' to a helper's stub

The build fails when CONFIG_REGULATOR is not selected because the stub
for regulator_bulk_set_supply_names() is missing the 'static inline'
attribute.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20190902151332.28058-1-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/consumer.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 6d2181a76987..337a46391527 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -586,9 +586,10 @@ static inline int regulator_list_voltage(struct regulator *regulator, unsigned s
 	return -EINVAL;
 }
 
-void regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
-				     const char *const *supply_names,
-				     unsigned int num_supplies)
+static inline void
+regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
+				const char *const *supply_names,
+				unsigned int num_supplies)
 {
 }
 
-- 
2.20.1

