Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17BAF1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 21:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfIJTWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 15:22:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:8944 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfIJTWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568143365;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Q2xo+8m/PTpfyib2FwPbe4+jFPDhaQCjl4xznLzRWQY=;
        b=L/4ZyO/QHymt7sZahA1NX80/tpUYDWCRIDGmLbJ9wQdlXtYUBYrKlwSyPPPFIq8XMJ
        GFMrkzzmamSurLICOCPJdkPFyvJZZ+9S+sfrurnzm0wvS8n+9aj+HVLJ8BM0mtyFIoJ5
        wwduuVq0DXACnZgxVFmU8J6LddrBmctgCg8sZsOkAQG6mhzizSswIB3xKxHsDhVW0esx
        3D37a84oSm/qkdNjWyAWeYGZqA1vOFEf8SySOqgp/DtpdP0/mfiWPZOf2+a1zHJ+dNsQ
        5NBU8wPpcj6drwzFu9gyXASSFvkeST/wUC7hxCNXE2d4jc1NOdwrjZ6f9nT3Cbc3TQ/H
        g30g==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7N8YnI7o="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8AJMU3Yg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 10 Sep 2019 21:22:30 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Adam Ford <aford173@gmail.com>
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] regulator: core: Fix error return for /sys access
Date:   Tue, 10 Sep 2019 21:22:29 +0200
Message-Id: <f37f2a1276efcb34cf3b7f1a25481175be048806.1568143348.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_uV_show() is missing error handling if regulator_get_voltage_rdev()
returns negative values. Instead it prints the errno as a string, e.g. -EINVAL
as "-22" which could be interpreted as -22 µV.

We also do not need to hold the lock while converting the integer to a string.

Reported-by: Adam Ford <aford173@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/regulator/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e0c0cf462004..ea48cb5a68b8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -564,13 +564,15 @@ static ssize_t regulator_uV_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
-	ssize_t ret;
+	int uV;
 
 	regulator_lock(rdev);
-	ret = sprintf(buf, "%d\n", regulator_get_voltage_rdev(rdev));
+	uV = regulator_get_voltage_rdev(rdev);
 	regulator_unlock(rdev);
 
-	return ret;
+	if (uV < 0)
+		return uV;
+	return sprintf(buf, "%d\n", uV);
 }
 static DEVICE_ATTR(microvolts, 0444, regulator_uV_show, NULL);
 
-- 
2.19.1

