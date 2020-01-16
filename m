Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2346813DF30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 16:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAPPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 10:48:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:48:56 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1is7O8-0003V8-IY; Thu, 16 Jan 2020 15:48:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] tee: fix memory allocation failure checks on drv_data and amdtee
Date:   Thu, 16 Jan 2020 15:48:52 +0000
Message-Id: <20200116154852.84532-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the memory allocation failure checks on drv_data and
amdtee are using IS_ERR rather than checking for a null pointer.
Fix these checks to use the conventional null pointer check.

Addresses-Coverity: ("Dereference null return")
Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: update to apply against cryptodev-2.6 tree tip
---
 drivers/tee/amdtee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index be8937eb5d43..6370bb55f512 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -446,11 +446,11 @@ static int __init amdtee_driver_init(void)
 	}
 
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
-	if (IS_ERR(drv_data))
+	if (!drv_data)
 		return -ENOMEM;
 
 	amdtee = kzalloc(sizeof(*amdtee), GFP_KERNEL);
-	if (IS_ERR(amdtee)) {
+	if (!amdtee) {
 		rc = -ENOMEM;
 		goto err_kfree_drv_data;
 	}
-- 
2.24.0

