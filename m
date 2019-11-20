Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA44E103C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfKTNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728319AbfKTNjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:53 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79CDF2251E;
        Wed, 20 Nov 2019 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257193;
        bh=aLgUTHkU8g2g0Eps8OoJNBBcLk286j9K1y9g5cSZy9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=nMGOm+bwXprnSTmLAZFgCuyncc5D317Rde6p0TC4nuSVTsw9P/idKuaHkU6EBVXrt
         zG7UM5TDuabHKoFcqV8L5RajxGvqPAIzTQQ8qi1zWt7WYFnCz4LK6Gd6Ve4cFckWIM
         qvNTDy+jez3yskOCjlw+P9P5kAarW4hl8+KXQsm0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:49 +0800
Message-Id: <20191120133949.13996-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3ee63531f6d5..74eb5af7295f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -841,10 +841,10 @@ config REGULATOR_SKY81452
 	  will be called sky81452-regulator.
 
 config REGULATOR_SLG51000
-        tristate "Dialog Semiconductor SLG51000 regulators"
-        depends on I2C
-        select REGMAP_I2C
-        help
+	tristate "Dialog Semiconductor SLG51000 regulators"
+	depends on I2C
+	select REGMAP_I2C
+	help
 	  Say y here to support for the Dialog Semiconductor SLG51000.
 	  The SLG51000 is seven compact and customizable low dropout
 	  regulators.
-- 
2.17.1

