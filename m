Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650B5131A47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAFVUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 16:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgAFVUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:20:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B939B24677;
        Mon,  6 Jan 2020 21:19:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ioZn4-000MXw-SM; Mon, 06 Jan 2020 16:19:58 -0500
Message-Id: <20200106211958.739059931@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 Jan 2020 16:19:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-linus][PATCH 7/7] tracing: Fix indentation issue
References: <20200106211901.293910946@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a declaration that is indented one level too deeply, remove
the extraneous tab.

Link: http://lkml.kernel.org/r/20191221154825.33073-1-colin.king@canonical.com

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 344e4c1aa09c..87de6edafd14 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -381,7 +381,7 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 		       int prefix_type, int rowsize, int groupsize,
 		       const void *buf, size_t len, bool ascii)
 {
-		unsigned int save_len = s->seq.len;
+	unsigned int save_len = s->seq.len;
 
 	if (s->full)
 		return 0;
-- 
2.24.0


