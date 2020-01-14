Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F213AA36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgANNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 08:04:09 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55216 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgANNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:04:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnjL6ub_1579007045;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnjL6ub_1579007045)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 21:04:06 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Varad Gautam <vrd@amazon.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/devpts: remove unused macro PTMX_MINOR
Date:   Tue, 14 Jan 2020 21:04:03 +0800
Message-Id: <1579007043-131766-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro are not used anymore from 
commit 8ead9dd54716 ("devpts: more pty driver interface cleanups")
So it's better to remove it now.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Varad Gautam <vrd@amazon.de> 
Cc: Amir Goldstein <amir73il@gmail.com> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: linux-kernel@vger.kernel.org 
---
 fs/devpts/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..ed1176682845 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -33,7 +33,6 @@
  * permissions.
  */
 #define DEVPTS_DEFAULT_PTMX_MODE 0000
-#define PTMX_MINOR	2
 
 /*
  * sysctl support for setting limits on the number of Unix98 ptys allocated.
-- 
1.8.3.1

