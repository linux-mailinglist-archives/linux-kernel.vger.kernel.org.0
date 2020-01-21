Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2818E1435F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAUDhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 22:37:15 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34202 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgAUDhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:37:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToGbVG5_1579577823;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToGbVG5_1579577823)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 11:37:03 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OCFS2: remove FS_OCFS2_NM
Date:   Tue, 21 Jan 2020 11:36:52 +0800
Message-Id: <1579577812-251572-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is't used from commit ab09203e302b ("sysctl fs: Remove
dead binary sysctl support"). Better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com> 
Cc: Joel Becker <jlbec@evilplan.org> 
Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
Cc: ocfs2-devel@oss.oracle.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ocfs2/stackglue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index 8aa6a667860c..a191094694c6 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -656,8 +656,6 @@ static int ocfs2_sysfs_init(void)
  * and easier to preserve the name.
  */
 
-#define FS_OCFS2_NM		1
-
 static struct ctl_table ocfs2_nm_table[] = {
 	{
 		.procname	= "hb_ctl_path",
-- 
1.8.3.1

