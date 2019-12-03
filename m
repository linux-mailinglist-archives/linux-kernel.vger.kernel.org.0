Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134FA112186
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 03:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLDCoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 21:44:12 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:50616 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLDCoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:44:12 -0500
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d59 with ME
        id Zek62100A3xPcdm03ek7w5; Wed, 04 Dec 2019 03:44:09 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 04 Dec 2019 03:44:09 +0100
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sbkim73@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: s5m8767: Fix a warning message
Date:   Tue,  3 Dec 2019 22:48:38 +0100
Message-Id: <20191203214838.9680-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axe a duplicated word ("property") in a warning message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/regulator/s5m8767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index bdc07739e9a2..12d6b8d2e97e 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -588,7 +588,7 @@ static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
 		if (of_property_read_u32(reg_np, "op_mode",
 				&rmode->mode)) {
 			dev_warn(iodev->dev,
-				"no op_mode property property at %pOF\n",
+				"no op_mode property at %pOF\n",
 				reg_np);
 
 			rmode->mode = S5M8767_OPMODE_NORMAL_MODE;
-- 
2.20.1

