Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23901FFBDB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfKQWNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 17:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfKQWNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:13:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7872075E;
        Sun, 17 Nov 2019 22:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iWSn8-0002qs-Jc; Sun, 17 Nov 2019 17:13:10 -0500
Message-Id: <20191117221310.490191223@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 17 Nov 2019 17:12:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [for-next][PATCH 3/7] tracing: Increase SYNTH_FIELDS_MAX for synthetic_events
References: <20191117221256.228674565@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Increase the maximum allowed count of synthetic event fields from 16 to 32
in order to allow for larger-than-usual events.

Link: http://lkml.kernel.org/r/20191115091730.9192-1-dedekind1@gmail.com

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7482a1466ebf..f49d1a36d3ae 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -23,7 +23,7 @@
 #include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
-#define SYNTH_FIELDS_MAX	16
+#define SYNTH_FIELDS_MAX	32
 
 #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
 
-- 
2.24.0


