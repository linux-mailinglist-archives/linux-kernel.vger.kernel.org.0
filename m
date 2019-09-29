Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA4C1962
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 22:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfI2UHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 16:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfI2UHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:07:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C3221920;
        Sun, 29 Sep 2019 20:07:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iEfTw-00082F-LW; Sun, 29 Sep 2019 16:07:48 -0400
Message-Id: <20190929200748.549323921@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 29 Sep 2019 16:06:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [for-linus][PATCH 3/5] tracing: Have error path in predicate_parse() free its allocated
 memory
References: <20190929200642.036511084@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

In predicate_parse, there is an error path that is not going to
out_free instead it returns directly which leads to a memory leak.

Link: http://lkml.kernel.org/r/20190920225800.3870-1-navid.emamdoost@gmail.com

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c773b8fb270c..c9a74f82b14a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -452,8 +452,10 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 
 		switch (*next) {
 		case '(':					/* #2 */
-			if (top - op_stack > nr_parens)
-				return ERR_PTR(-EINVAL);
+			if (top - op_stack > nr_parens) {
+				ret = -EINVAL;
+				goto out_free;
+			}
 			*(++top) = invert;
 			continue;
 		case '!':					/* #3 */
-- 
2.20.1


