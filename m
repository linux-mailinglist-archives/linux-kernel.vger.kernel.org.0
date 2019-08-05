Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E581A82367
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfHERBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 13:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbfHERBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:01:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FD612075B;
        Mon,  5 Aug 2019 17:01:52 +0000 (UTC)
Date:   Mon, 5 Aug 2019 13:01:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wang Nan <wangnan0@huawei.com>, He Kuang <hekuang@huawei.com>,
        Michal Marek <mmarek@suse.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Paul Turner <pjt@google.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH] tools lib traceevent: Fix "robust" test of
 do_generate_dynamic_list_file
Message-ID: <20190805130150.25acfeb1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[
  Not sure why I wasn't Cc'd on the original patch (or the one before that)
  but I guess I need to add tools/lib/traceevent under MAINTAINERs for
  perhaps tracing?
]

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The tools/lib/traceevent/Makefile had a test added to it to detect a failure
of the "nm" when making the dynamic list file (whatever that is). The
problem is that the test sorts the values "U W w" and some versions of sort
will place "w" ahead of "W" (even though it has a higher ASCII value, and
break the test.

Add 'tr "w" "W"' to merge the two and not worry about the ordering.

Cc: stable@vger.kernel.org
Fixes: 6467753d61399 ("tools lib traceevent: Robustify do_generate_dynamic_list_file")
Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index 3292c290654f..8352d53dcb5a 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -266,8 +266,8 @@ endef
 
 define do_generate_dynamic_list_file
 	symbol_type=`$(NM) -u -D $1 | awk 'NF>1 {print $$1}' | \
-	xargs echo "U W w" | tr ' ' '\n' | sort -u | xargs echo`;\
-	if [ "$$symbol_type" = "U W w" ];then				\
+	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
+	if [ "$$symbol_type" = "U W" ];then				\
 		(echo '{';						\
 		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
 		echo '};';						\
-- 
2.20.1

