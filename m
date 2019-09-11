Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14445B00F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfIKQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 12:07:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35907 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfIKQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:07:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i859U-000298-Ft; Wed, 11 Sep 2019 16:07:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: fix spelling mistake "ambigous" -> "ambiguous"
Date:   Wed, 11 Sep 2019 17:07:28 +0100
Message-Id: <20190911160728.24322-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a mlog_bug_on_msg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7ad9d6590818..7c9dfd50c1c1 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -534,7 +534,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 	 */
 	mlog_bug_on_msg(!!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) !=
 			!!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE),
-			"Inode %llu: system file state is ambigous\n",
+			"Inode %llu: system file state is ambiguous\n",
 			(unsigned long long)args->fi_blkno);
 
 	if (S_ISCHR(le16_to_cpu(fe->i_mode)) ||
-- 
2.20.1

