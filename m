Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669AF1436DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 06:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAUFyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 00:54:46 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39609 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728928AbgAUFyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:54:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToH2iiQ_1579586081;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToH2iiQ_1579586081)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 13:54:41 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: remove abandoned macro RB_MISSED_FLAGS
Date:   Tue, 21 Jan 2020 13:54:40 +0800
Message-Id: <1579586080-45300-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro isn't used from commit d325c402964e ("ring-buffer: Remove
unused function ring_buffer_page_len()"), so better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/ring_buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3f655371eaf6..dffbacde4475 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -300,8 +300,6 @@ u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
 /* Missed count stored at end */
 #define RB_MISSED_STORED	(1 << 30)
 
-#define RB_MISSED_FLAGS		(RB_MISSED_EVENTS|RB_MISSED_STORED)
-
 struct buffer_data_page {
 	u64		 time_stamp;	/* page time stamp */
 	local_t		 commit;	/* write committed index */
-- 
1.8.3.1

