Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CCD9A679
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 06:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfHWEMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 00:12:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50525 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfHWEMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 00:12:10 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7N4BgHC004623;
        Fri, 23 Aug 2019 13:11:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Fri, 23 Aug 2019 13:11:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7N4BcR0004403
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Aug 2019 13:11:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: [PATCH v2] /dev/mem: Bail out upon SIGKILL.
Date:   Fri, 23 Aug 2019 13:11:19 +0900
Message-Id: <1566533479-4390-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found that a thread can stall for minutes inside read_mem() or
write_mem() after that thread was killed by SIGKILL [1]. Reading 2GB at
one read() is legal, but delaying termination of killed thread for minutes
is bad. Let's insert cond_resched() and SIGKILL check into iteration loop
of reading/writing /dev/mem and /dev/kmem.

  [ 1335.912419][T20577] read_mem: sz=4096 count=2134565632
  [ 1335.943194][T20577] read_mem: sz=4096 count=2134561536
  [ 1335.978280][T20577] read_mem: sz=4096 count=2134557440
  [ 1336.011147][T20577] read_mem: sz=4096 count=2134553344
  [ 1336.041897][T20577] read_mem: sz=4096 count=2134549248

[1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
---
 drivers/char/mem.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50..cb8e653 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -140,6 +140,10 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 		int allowed, probe;
 
 		sz = size_inside_page(p, count);
+		cond_resched();
+		err = -EINTR;
+		if (fatal_signal_pending(current))
+			goto failed;
 
 		err = -EPERM;
 		allowed = page_is_allowed(p >> PAGE_SHIFT);
@@ -218,6 +222,9 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 		int allowed;
 
 		sz = size_inside_page(p, count);
+		cond_resched();
+		if (fatal_signal_pending(current))
+			return -EINTR;
 
 		allowed = page_is_allowed(p >> PAGE_SHIFT);
 		if (!allowed)
@@ -451,6 +458,9 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 #endif
 		while (low_count > 0) {
 			sz = size_inside_page(p, low_count);
+			cond_resched();
+			if (fatal_signal_pending(current))
+				return -EINTR;
 
 			/*
 			 * On ia64 if a page has been mapped somewhere as
@@ -477,6 +487,11 @@ static ssize_t read_kmem(struct file *file, char __user *buf,
 			return -ENOMEM;
 		while (count > 0) {
 			sz = size_inside_page(p, count);
+			cond_resched();
+			if (fatal_signal_pending(current)) {
+				err = -EINTR;
+				break;
+			}
 			if (!is_vmalloc_or_module_addr((void *)p)) {
 				err = -ENXIO;
 				break;
@@ -523,6 +538,9 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 		void *ptr;
 
 		sz = size_inside_page(p, count);
+		cond_resched();
+		if (fatal_signal_pending(current))
+			return -EINTR;
 
 		/*
 		 * On ia64 if a page has been mapped somewhere as uncached, then
@@ -581,6 +599,11 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
 			unsigned long sz = size_inside_page(p, count);
 			unsigned long n;
 
+			cond_resched();
+			if (fatal_signal_pending(current)) {
+				err = -EINTR;
+				break;
+			}
 			if (!is_vmalloc_or_module_addr((void *)p)) {
 				err = -ENXIO;
 				break;
-- 
1.8.3.1

