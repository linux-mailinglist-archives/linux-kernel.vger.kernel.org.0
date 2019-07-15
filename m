Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1533968327
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 07:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfGOFLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 01:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfGOFLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:11:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EFA20868;
        Mon, 15 Jul 2019 05:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167506;
        bh=8RzbIez3/gV7djsGVGljsi9n/uUzLTL1tlAOyhS3Cmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOYZ+6vtyTUZIUS8oxJjoRFlTtGZFC4cBni9V/w6pTpfGV/VgCfCbWf0wLxtSvgeJ
         3Qh64gIAy724cSBGh/n+8MQNeIGqBJ/DLh4YoRZWNiqpmCH/yxJdNufC4ei9OxX/5X
         ls21Ymxr6KXu3lysCVTGlVp9D2SoQ9oJEJtQv4G8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tim Bird <Tim.Bird@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v2 03/15] tracing: Expose EXPORT_SYMBOL_GPL symbol
Date:   Mon, 15 Jul 2019 14:11:41 +0900
Message-Id: <156316750104.23477.16130563883422978119.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156316746861.23477.5815110570539190650.stgit@devnote2>
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ftrace_set_clr_event is already exported by EXPORT_SYMBOL_GPL,
it should not be static.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 22cf08bd2317..c2d38048edae 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -788,7 +788,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;

