Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE42319BFA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbgDBKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 06:50:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37351 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:50:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jJxQ8-0003JL-GG; Thu, 02 Apr 2020 10:50:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] binderfs: remove redundant assignment to pointer ctx
Date:   Thu,  2 Apr 2020 11:50:00 +0100
Message-Id: <20200402105000.506296-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer ctx is being initialized with a value that is never read
and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/android/binderfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 9ecad74183a3..8352a3d160bf 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -747,7 +747,7 @@ static const struct fs_context_operations binderfs_fs_context_ops = {
 
 static int binderfs_init_fs_context(struct fs_context *fc)
 {
-	struct binderfs_mount_opts *ctx = fc->fs_private;
+	struct binderfs_mount_opts *ctx;
 
 	ctx = kzalloc(sizeof(struct binderfs_mount_opts), GFP_KERNEL);
 	if (!ctx)
-- 
2.25.1

