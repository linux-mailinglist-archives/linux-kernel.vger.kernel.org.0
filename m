Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA6153AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBEWVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbgBEWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:21:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5EB222C2;
        Wed,  5 Feb 2020 22:21:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izT3H-001P16-6X; Wed, 05 Feb 2020 17:21:43 -0500
Message-Id: <20200205222143.086800401@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 17:21:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 3/5] bootconfig: Add more parse error messages
References: <20200205222110.912457436@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add more error messages for following cases.
 - Exceeding max number of nodes
 - Config tree data is empty (e.g. comment only)
 - Config data is empty or exceeding max size
 - bootconfig is already initialized

Link: http://lkml.kernel.org/r/158091060401.27924.9024818742827122764.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 055014e233a5..a98ae136529c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -373,7 +373,8 @@ static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
 				sib->next = xbc_node_index(node);
 			}
 		}
-	}
+	} else
+		xbc_parse_error("Too many nodes", data);
 
 	return node;
 }
@@ -657,8 +658,10 @@ static int __init xbc_verify_tree(void)
 	struct xbc_node *n, *m;
 
 	/* Empty tree */
-	if (xbc_node_num == 0)
+	if (xbc_node_num == 0) {
+		xbc_parse_error("Empty config", xbc_data);
 		return -ENOENT;
+	}
 
 	for (i = 0; i < xbc_node_num; i++) {
 		if (xbc_nodes[i].next > xbc_node_num) {
@@ -732,12 +735,17 @@ int __init xbc_init(char *buf)
 	char *p, *q;
 	int ret, c;
 
-	if (xbc_data)
+	if (xbc_data) {
+		pr_err("Error: bootconfig is already initialized.\n");
 		return -EBUSY;
+	}
 
 	ret = strlen(buf);
-	if (ret > XBC_DATA_MAX - 1 || ret == 0)
+	if (ret > XBC_DATA_MAX - 1 || ret == 0) {
+		pr_err("Error: Config data is %s.\n",
+			ret ? "too big" : "empty");
 		return -ERANGE;
+	}
 
 	xbc_data = buf;
 	xbc_data_size = ret + 1;
-- 
2.24.1


