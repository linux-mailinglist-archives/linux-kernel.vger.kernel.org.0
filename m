Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B7A90B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 00:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfHPWlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 18:41:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38226 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfHPWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:41:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hykuA-0003WU-PO; Fri, 16 Aug 2019 22:41:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bus: moxtet: fix unsigned comparison to less than zero
Date:   Fri, 16 Aug 2019 23:41:06 +0100
Message-Id: <20190816224106.11583-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the size_t variable res is being checked for
an error failure however the unsigned variable is never
less than zero so this test is always false. Fix this by
making variable res ssize_t

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 5bc7f990cd98 ("bus: Add support for Moxtet bus")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bus/moxtet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1ee4570e7e17..288a9e4c6c7b 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -514,7 +514,7 @@ static ssize_t output_write(struct file *file, const char __user *buf,
 	struct moxtet *moxtet = file->private_data;
 	u8 bin[TURRIS_MOX_MAX_MODULES];
 	u8 hex[sizeof(bin) * 2 + 1];
-	size_t res;
+	ssize_t res;
 	loff_t dummy = 0;
 	int err, i;
 
-- 
2.20.1

