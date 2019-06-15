Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3466C47000
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfFOMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 08:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfFOMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:43:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B8E21852;
        Sat, 15 Jun 2019 12:43:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hc81Z-0006e8-AA; Sat, 15 Jun 2019 08:43:13 -0400
Message-Id: <20190615124313.204410137@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 15 Jun 2019 08:42:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Eiichi Tsukata <devel@etsukata.com>
Subject: [for-linus][PATCH 5/7] tracing/uprobe: Fix obsolete comment on trace_uprobe_create()
References: <20190615124216.188179157@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eiichi Tsukata <devel@etsukata.com>

Commit 0597c49c69d5 ("tracing/uprobes: Use dyn_event framework for
uprobe events") cleaned up the usage of trace_uprobe_create(), and the
function has been no longer used for removing uprobe/uretprobe.

Link: http://lkml.kernel.org/r/20190614074026.8045-2-devel@etsukata.com

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a88c692e3b8a..b55906c77ce0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -426,8 +426,6 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 /*
  * Argument syntax:
  *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS]
- *
- *  - Remove uprobe: -:[GRP/]EVENT
  */
 static int trace_uprobe_create(int argc, const char **argv)
 {
-- 
2.20.1


