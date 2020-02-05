Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC3153242
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgBENuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 08:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBENuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:50:18 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4FD20702;
        Wed,  5 Feb 2020 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580910617;
        bh=HZXKxKb8zdvXbvKRk2UF9Qp0GfxuN1tEzPn2xIp/we4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWIzE1tjR7gGfeNU3D0Spxh2suZI0UqbwK17/ZeuKuTAVhw0wpCwjzDK0s4NnWd6S
         gYNYrZ4ItVLasPkMlgUKfCzbvgH0Zmj50k20n0zh15mHKs5RLcW+6f/P5qjmRlV9Ky
         jSivXFpuIV+zdW9FBa/PCATSMZ4A5dbsncYK3SsI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/4] tools/bootconfig: Show the number of bootconfig nodes
Date:   Wed,  5 Feb 2020 22:50:13 +0900
Message-Id: <158091061337.27924.10886706631693823982.stgit@devnote2>
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

Show the number of bootconfig nodes when applying new bootconfig to
initrd.

Since there are limitations of bootconfig not only in its filesize,
but also the number of nodes, the number should be shown when applying
so that user can get the feeling of scale of current bootconfig.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c        |    5 ++++-
 tools/bootconfig/main.c |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a98ae136529c..afb2e767e6fe 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -728,7 +728,8 @@ void __init xbc_destroy_all(void)
  *
  * This parses the boot config text in @buf. @buf must be a
  * null terminated string and smaller than XBC_DATA_MAX.
- * Return 0 if succeeded, or -errno if there is any error.
+ * Return the number of stored nodes (>0) if succeeded, or -errno
+ * if there is any error.
  */
 int __init xbc_init(char *buf)
 {
@@ -788,6 +789,8 @@ int __init xbc_init(char *buf)
 
 	if (ret < 0)
 		xbc_destroy_all();
+	else
+		ret = xbc_node_num;
 
 	return ret;
 }
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 91c9a5c0c499..47f488458328 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -268,6 +268,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	printf("Apply %s to %s\n", xbc_path, path);
+	printf("\tNumber of nodes: %d\n", ret);
 	printf("\tSize: %u bytes\n", (unsigned int)size);
 	printf("\tChecksum: %d\n", (unsigned int)csum);
 

