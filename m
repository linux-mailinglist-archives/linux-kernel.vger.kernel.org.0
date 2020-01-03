Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F11E12FB5D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 18:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgACRNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 12:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgACRNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:13:06 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3AA215A4;
        Fri,  3 Jan 2020 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071585;
        bh=fPm5Yby+y1HvlcMvlRngQAQVaF5ytWsyr2iFrW2UnT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfU9D4Xqx4lG34UMVnNZSfUw6Ch56xCx/oZWiTm4y2AnbXl0SuB7flfJHj1RV9yKD
         +vAI0BN/BgtI9wncq/ea2fc3NJ6Ol6nFpOPt2mWtzp8AM4dxk29DLWEohMgdWWUk2n
         LcgyTE7qH6pAK7oYvUOlSI7+4SJwM+a/Kv+aOi/k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 19/19] regulator: samsung: Rename Samsung to lowercase
Date:   Fri,  3 Jan 2020 18:11:31 +0100
Message-Id: <20200103171131.9900-20-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
name.

"SAMSUNG" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/regulator/s2mpa01.c | 2 +-
 drivers/regulator/s2mps11.c | 2 +-
 drivers/regulator/s5m8767.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 51f7e8b74d8c..115f59530852 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -390,5 +390,5 @@ module_platform_driver(s2mpa01_pmic_driver);
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
 MODULE_AUTHOR("Sachin Kamat <sachin.kamat@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S2MPA01 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S2MPA01 Regulator Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 4f2dc5ebffdc..23d288278957 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1265,5 +1265,5 @@ module_platform_driver(s2mps11_pmic_driver);
 
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S2MPS11/S2MPS14/S2MPS15/S2MPU02 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S2MPS11/S2MPS14/S2MPS15/S2MPU02 Regulator Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 12d6b8d2e97e..4abd3ed31f60 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -1015,5 +1015,5 @@ module_exit(s5m8767_pmic_exit);
 
 /* Module information */
 MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
-MODULE_DESCRIPTION("SAMSUNG S5M8767 Regulator Driver");
+MODULE_DESCRIPTION("Samsung S5M8767 Regulator Driver");
 MODULE_LICENSE("GPL");
-- 
2.17.1

