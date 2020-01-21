Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB271438B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAUItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:49:12 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46650 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728977AbgAUItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToHWsbJ_1579596549;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWsbJ_1579596549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fcache: remove unused macro CACHEFILES_KEYBUF_SIZE
Date:   Tue, 21 Jan 2020 16:49:03 +0800
Message-Id: <1579596543-257734-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after commit 402cb8dda949 ("fscache: Attach the index key and aux data
to the cookie"), no one use this macro anymore, remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: David Howells <dhowells@redhat.com> 
Cc: linux-cachefs@redhat.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/cachefiles/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ecc8ecbbfa5a..e327f781dae7 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -18,8 +18,6 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-#define CACHEFILES_KEYBUF_SIZE 512
-
 /*
  * dump debugging info about an object
  */
-- 
1.8.3.1

