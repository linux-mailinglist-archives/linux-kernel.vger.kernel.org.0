Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016144ECF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFUQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:18:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94B4C2089E;
        Fri, 21 Jun 2019 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133914;
        bh=PwyIRlw4eGqVixKLTAdetpyYxnczvxvkrv1PiQ/hkbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILXggq8rI3dwdWMakT32bI0nuIjhZ7NSpfKISdj95Zbwivj/Avg9lFb4W699NqM/f
         uItgLS2TJIRYw0glDjWmVgL1maykq4yTqqH1Q+j+EwqZuxJ17+3sfUnpVeRcby6Rx4
         Ee5ULya3BYiaCTrLWwU1Z3jAstFNDiz6MFpbk5b0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 03/11] tracing: Expose EXPORT_SYMBOL_GPL symbol
Date:   Sat, 22 Jun 2019 01:18:30 +0900
Message-Id: <156113391031.28344.15363982923173501964.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
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
index 733ae975e7b8..c9b458dcdd36 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -796,7 +796,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
 	return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
 	char *event = NULL, *sub = NULL, *match;
 	int ret;

