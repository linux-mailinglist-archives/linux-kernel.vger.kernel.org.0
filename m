Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21989107B51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 00:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKVXbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 18:31:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44151 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:31:32 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iYIOW-00017f-NF; Fri, 22 Nov 2019 23:31:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fsi@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: fix bogos error returns from cfam_read and cfam_write
Date:   Fri, 22 Nov 2019 23:31:20 +0000
Message-Id: <20191122233120.110344-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where errors occur in functions cfam_read and cfam_write
the error return code in rc is not returned and a bogus non-error
count size is returned instead. Fix this by returning the correct
error code when an error occurs or the count size if the functions
worked correctly.

Addresses-Coverity: ("Unused value")
Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/fsi/fsi-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 8244da8a7241..c3885b138ead 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -718,7 +718,7 @@ static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
 	rc = count;
  fail:
 	*offset = off;
-	return count;
+	return rc;
 }
 
 static ssize_t cfam_write(struct file *filep, const char __user *buf,
@@ -755,7 +755,7 @@ static ssize_t cfam_write(struct file *filep, const char __user *buf,
 	rc = count;
  fail:
 	*offset = off;
-	return count;
+	return rc;
 }
 
 static loff_t cfam_llseek(struct file *file, loff_t offset, int whence)
-- 
2.24.0

