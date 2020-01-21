Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE5731436DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 06:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAUFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 00:54:49 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57473 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728978AbgAUFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:54:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToH2KsM_1579586084;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToH2KsM_1579586084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 13:54:44 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: remove unused ret
Date:   Tue, 21 Jan 2020 13:54:43 +0800
Message-Id: <1579586083-45359-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No body care the variable 'ret' in function unregister_field_var_hists,
better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/trace_events_hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f62de5f43e79..0acfac95ca2a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5712,12 +5712,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	struct trace_event_file *file;
 	unsigned int i;
 	char *cmd;
-	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
 		file = hist_data->field_var_hists[i]->hist_data->event_file;
 		cmd = hist_data->field_var_hists[i]->cmd;
-		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+		event_hist_trigger_func(&trigger_hist_cmd, file,
 					      "!hist", "hist", cmd);
 	}
 }
-- 
1.8.3.1

