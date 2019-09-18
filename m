Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB4B5FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfIRIzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfIRIzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:55:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21DC218AF;
        Wed, 18 Sep 2019 08:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568796940;
        bh=+lueAAsQKUqeGKnYxOeGimMVjVTFw3fNJB+UmXbLp+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFOqMA0SiekAE3k6wEzp+G/fz1wZ7RSSmko1VoBA+4gkoy3zbhm0Fs4O2/wm2wD26
         DYiMk0K0VH2f81z7fzHv25uxXC3VQGQwYW3Z8jbh3IsmWOzeBxlGFY4fZu6sSvJWlp
         shzB006ItQ6ixXJx2nl6oAhc7KNVTpwgbFI3FAxw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com
Subject: [PATCH 1/3] tracing/probe: Fix to allow user to enable events on unloaded modules
Date:   Wed, 18 Sep 2019 17:55:37 +0900
Message-Id: <156879693733.31056.9331322616994665167.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156879692790.31056.9404391078827158266.stgit@devnote2>
References: <156879692790.31056.9404391078827158266.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to allow user to enable probe events on unloaded modules.

This operations was allowed before commit 60d53e2c3b75 ("tracing/probe:
Split trace_event related data from trace_probe"), because if users
need to probe module init functions, they have to enable those probe
events before loading module.

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7579c53bb053..0ba3239c0270 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -371,31 +371,24 @@ static int enable_trace_kprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	enabled = false;
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
 		tk = container_of(pos, struct trace_kprobe, tp);
 		if (trace_kprobe_has_gone(tk))
 			continue;
 		ret = __enable_trace_kprobe(tk);
-		if (ret) {
-			if (enabled) {
-				__disable_trace_kprobe(tp);
-				enabled = false;
-			}
+		if (ret)
 			break;
-		}
 		enabled = true;
 	}
 
-	if (!enabled) {
-		/* No probe is enabled. Roll back */
+	if (ret) {
+		/* Failed to enable one of them. Roll back all */
+		if (enabled)
+			__disable_trace_kprobe(tp);
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
 			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
-		if (!ret)
-			/* Since all probes are gone, this is not available */
-			ret = -EADDRNOTAVAIL;
 	}
 
 	return ret;

