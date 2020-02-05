Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95F153240
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 14:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgBENuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 08:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgBENuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:50:08 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6191A217BA;
        Wed,  5 Feb 2020 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580910608;
        bh=verct/EyCPQlCAKz6LEayim3YbGFMeWAV043BlaTAFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ypgz9pt45DRbbDBD4aQajDlX0QY3LAEbD6cIahUVWBgcSPRjKedQ2WtVN+LHvGenG
         5UZ/iLNSxnrTH9ifkGCvUm9OxlXoxGe/z+ckUAU3eZ0P4eSfdF0srOUuN1f3es/rOM
         cKZJaZ0YsIzOCQ0GyLAYCOywyxAJnoIOguhcOcVM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/4] bootconfig: Add more parse error messages
Date:   Wed,  5 Feb 2020 22:50:04 +0900
Message-Id: <158091060401.27924.9024818742827122764.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158091058484.27924.11216788166827115442.stgit@devnote2>
References: <158091058484.27924.11216788166827115442.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more error messages for following cases.
 - Exceeding max number of nodes
 - Config tree data is empty (e.g. comment only)
 - Config data is empty or exceeding max size
 - bootconfig is already initialized

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c |   16 ++++++++++++----
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

