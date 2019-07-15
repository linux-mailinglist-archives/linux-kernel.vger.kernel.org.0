Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E006863F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfGOJYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 05:24:07 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:49552 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfGOJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:24:06 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id C132D1009AC14;
        Mon, 15 Jul 2019 17:14:34 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id B8A0E201B4B7F;
        Mon, 15 Jul 2019 16:59:07 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JT3smSJvExNG; Mon, 15 Jul 2019 16:59:07 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id 9165820424204;
        Mon, 15 Jul 2019 16:59:07 +0800 (CST)
From:   xywang.sjtu@sjtu.edu.cn
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH 1/2] tracing: replace simple_strtol() by kstrtoint()
Date:   Mon, 15 Jul 2019 16:58:55 +0800
Message-Id: <20190715085856.5664-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>

The simple_strtol() function is deprecated. kstrto[l,int]() are
the correct replacements as they can properly handle overflows.

This patch replaces the deprecated simple_strtol() use introduced recently.
As skip_entries is actually int-typed, we are safe to use kstrtoint() here.

Same as before, set 0 to skip_entries on string parsing error.

Fixes: dbfe67334a17 ("tracing: kdb: The skip_lines parameter should have been skip_entries")
Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 kernel/trace/trace_kdb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index cca65044c14c..5d9dd4c3f23f 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -104,8 +104,7 @@ static int kdb_ftdump(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	if (argc) {
-		skip_entries = simple_strtol(argv[1], &cp, 0);
-		if (*cp)
+		if (kstrtoint(argv[1], 0, &skip_entries))
 			skip_entries = 0;
 	}
 
-- 
2.11.0

