Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C24913ECB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 18:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406808AbgAPR6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 12:58:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47028 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406471AbgAPR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:58:01 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1is9P5-00070X-0R; Thu, 16 Jan 2020 17:57:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Simon Schwartz <kern.simon@theschwartz.xyz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] driver core: platform: fix u32 greater or equal to zero comparison
Date:   Thu, 16 Jan 2020 17:57:58 +0000
Message-Id: <20200116175758.88396-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check that a u32 variable i is >= 0 is always true because
the unsigned variable will never be negative, causing the loop to run
forever.  Fix this by changing the pre-decrement check to a zero check on
i followed by a decrement of i.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 39cc539f90d0 ("driver core: platform: Prevent resouce overflow from causing infinite loops")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 864b53b3d598..7fa654f1288b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -571,7 +571,7 @@ int platform_device_add(struct platform_device *pdev)
 		pdev->id = PLATFORM_DEVID_AUTO;
 	}
 
-	while (--i >= 0) {
+	while (i--) {
 		struct resource *r = &pdev->resource[i];
 		if (r->parent)
 			release_resource(r);
-- 
2.24.0

