Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5DE1438B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAUItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:49:04 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39057 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728977AbgAUItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHWsYi_1579596541;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWsYi_1579596541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] coda: remove err which no one care
Date:   Tue, 21 Jan 2020 16:48:59 +0800
Message-Id: <1579596539-257694-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one care 'err' in func coda_release, so better remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu> 
Cc: coda@cs.cmu.edu 
Cc: codalist@coda.cs.cmu.edu 
Cc: linux-kernel@vger.kernel.org 
---
 fs/coda/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 128d63df5bfb..31a7ba383cb2 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -238,11 +238,10 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
 	struct coda_file_info *cfi;
 	struct coda_inode_info *cii;
 	struct inode *host_inode;
-	int err;
 
 	cfi = coda_ftoc(coda_file);
 
-	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
+	venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
 			  coda_flags, coda_file->f_cred->fsuid);
 
 	host_inode = file_inode(cfi->cfi_container);
-- 
1.8.3.1

