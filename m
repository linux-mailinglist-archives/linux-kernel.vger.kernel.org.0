Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D374F102321
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfKSLdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 06:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKSLdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:33:47 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6B92230C;
        Tue, 19 Nov 2019 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163227;
        bh=DtgJBBL3afPt6FerAcL6XJr6K7OQqApiq5qmf3jy6w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYRAiPp2fE0mrnbL3y6VvnzIVzJIirfhhfQrSdig9RojjYEaCjA58rj4oopUJPeId
         /eZGJNpYWzjzCr3diMyzBHFLF52eMJYSqsW58mhFHJC0PbIPe2OXAqSRXjdKFMMSkV
         /EXbRv8ZwaPt8Ub1lL81hIJsknc+Q3ulsIE4LEI8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/25] libtraceevent: Fix parsing of event %o and %X argument types
Date:   Tue, 19 Nov 2019 08:32:33 -0300
Message-Id: <20191119113245.19593-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Add missing "%o" and "%X". Ext4 events use "%o" for printing i_mode.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Link: http://lore.kernel.org/lkml/157338066113.6548.11461421296091086041.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index d948475585ce..beaa8b8c08ff 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4395,8 +4395,10 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
 				/* fall through */
 			case 'd':
 			case 'u':
-			case 'x':
 			case 'i':
+			case 'x':
+			case 'X':
+			case 'o':
 				switch (ls) {
 				case 0:
 					vsize = 4;
@@ -5078,10 +5080,11 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 
 				/* fall through */
 			case 'd':
+			case 'u':
 			case 'i':
 			case 'x':
 			case 'X':
-			case 'u':
+			case 'o':
 				if (!arg) {
 					do_warning_event(event, "no argument match");
 					event->flags |= TEP_EVENT_FL_FAILED;
-- 
2.21.0

