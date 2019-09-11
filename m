Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618D6AFD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfIKMsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 08:48:21 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:22644 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbfIKMsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:48:21 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i822h-000LR7-2m; Wed, 11 Sep 2019 14:48:15 +0200
Received: from 83.9.150.83.ftth.as8758.net ([83.150.9.83] helo=volery)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i822g-000Lu2-RU; Wed, 11 Sep 2019 14:48:14 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Wed, 11 Sep 2019 14:48:12 +0200
From:   Sandro Volery <sandro@volery.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, linux@rasmusvillemoes.dk
Subject: [PATCH v3] Staging: exfat: Avoid use of strcpy
Message-ID: <20190911124812.GA25324@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strscpy instead of strcpy in exfat_core.c, and add a check
for length that will return already known FFS_INVALIDPATH.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Sandro Volery <sandro@volery.com>
---
v3: Fixed replacing mistake
v2: Introduced length check
v1: Original patch
 drivers/staging/exfat/exfat_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index da8c58149c35..4c40f1352848 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2964,7 +2964,8 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
 		return FFS_INVALIDPATH;
 
-	strcpy(name_buf, path);
+	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
+		return FFS_INVALIDPATH;
 
 	nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
 	if (lossy)
-- 
2.23.0

