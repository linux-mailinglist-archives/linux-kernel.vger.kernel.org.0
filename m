Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFD1436CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUFuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 00:50:21 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58577 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUFuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:50:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToH3RSI_1579585818;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToH3RSI_1579585818)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 13:50:19 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: remove abandoned macros
Date:   Tue, 21 Jan 2020 13:50:07 +0800
Message-Id: <1579585807-43316-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This 2 macros aren't used from commit eee8ded131f1 ("ftrace: Have the
function probes call their own function"), so remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/ftrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..68c4f20c564e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -62,8 +62,6 @@
 	})
 
 /* hash bits for specific function selection */
-#define FTRACE_HASH_BITS 7
-#define FTRACE_FUNC_HASHSIZE (1 << FTRACE_HASH_BITS)
 #define FTRACE_HASH_DEFAULT_BITS 10
 #define FTRACE_HASH_MAX_BITS 12
 
-- 
1.8.3.1

