Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38E3740F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfFFM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 08:27:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51152 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfFFM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:27:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hYrU3-000591-Jj; Thu, 06 Jun 2019 12:27:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     "amy . shih" <amy.shih@advantech.com.tw>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: nct7904: fix error check on register read
Date:   Thu,  6 Jun 2019 13:27:07 +0100
Message-Id: <20190606122707.16107-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the return from the call to nct7904_read is being masked
and so and negative error returns are being stripped off and the
error check is always false.  Fix this by checking on err first and
then masking the return value in ret.

Addresses-Coverity: ("Logically dead code")
Fixes: af55ab0b0792 ("hwmon: (nct7904) Add extra sysfs support for fan, voltage and temperature.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/nct7904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index dd450dd29ac7..5fa69898674c 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -928,10 +928,10 @@ static int nct7904_probe(struct i2c_client *client,
 
 	/* Check DTS enable status */
 	if (data->enable_dts) {
-		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
+		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG);
 		if (ret < 0)
 			return ret;
-		data->has_dts = ret;
+		data->has_dts = ret & 0xF;
 		if (data->enable_dts & ENABLE_TSI) {
 			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
 			if (ret < 0)
-- 
2.20.1

