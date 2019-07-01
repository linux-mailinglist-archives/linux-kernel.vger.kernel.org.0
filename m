Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4486651E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 00:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfFXWhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 18:37:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfFXWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:37:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hfXaY-0001El-FV; Mon, 24 Jun 2019 22:37:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbmem: remove redundant assignment to err
Date:   Mon, 24 Jun 2019 23:37:24 +0100
Message-Id: <20190624223724.13629-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is initialized to a value that is never read and it
is re-assigned later.  The initialization is redundant and can
be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dd1a708df1a7..ae044a1325ca 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1987,7 +1987,7 @@ int fb_new_modelist(struct fb_info *info)
 	struct list_head *pos, *n;
 	struct fb_modelist *modelist;
 	struct fb_videomode *m, mode;
-	int err = 1;
+	int err;
 
 	list_for_each_safe(pos, n, &info->modelist) {
 		modelist = list_entry(pos, struct fb_modelist, list);
-- 
2.20.1

