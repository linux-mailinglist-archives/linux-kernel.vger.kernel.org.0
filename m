Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A475148B13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 16:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbgAXPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 10:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387953AbgAXPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E90222522;
        Fri, 24 Jan 2020 15:17:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i6-000qGc-3d; Fri, 24 Jan 2020 10:17:26 -0500
Message-Id: <20200124151725.996608776@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:17:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 12/14] tracing/boot: Fix an IS_ERR() vs NULL bug
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The trace_array_get_by_name() function doesn't return error pointers,
it returns NULL on error.

Link: http://lkml.kernel.org/r/20200117053007.5h2juv272pokqhtq@kili.mountain

Fixes: 4f712a4d04a4 ("tracing/boot: Add instance node support")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index fa9603dc6469..cd541ac1cbc1 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -322,7 +322,7 @@ trace_boot_init_instances(struct xbc_node *node)
 			continue;
 
 		tr = trace_array_get_by_name(p);
-		if (IS_ERR(tr)) {
+		if (!tr) {
 			pr_err("Failed to get trace instance %s\n", p);
 			continue;
 		}
-- 
2.24.1


