Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38AEF58334
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF0NQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 09:16:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52935 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF0NQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:16:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgUGV-000212-Kg; Thu, 27 Jun 2019 13:16:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: lp87565: fix missing break in switch statement
Date:   Thu, 27 Jun 2019 14:16:39 +0100
Message-Id: <20190627131639.6394-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the LP87565_DEVICE_TYPE_LP87561_Q1 case does not have a
break statement, causing it to fall through to a dev_err message.
Fix this by adding in the missing break statement.

Addresses-Coverity: ("Missing break in switch")
Fixes: 7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/lp87565-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 993c11702083..5d067f7c2116 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -180,6 +180,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	case LP87565_DEVICE_TYPE_LP87561_Q1:
 		min_idx = LP87565_BUCK_3210;
 		max_idx = LP87565_BUCK_3210;
+		break;
 	default:
 		dev_err(lp87565->dev, "Invalid lp config %d\n",
 			lp87565->dev_type);
-- 
2.20.1

