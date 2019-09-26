Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08729BE980
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfIZAdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfIZAdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:31 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D67A222C2;
        Thu, 26 Sep 2019 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458010;
        bh=WQ5/dVaZ4sucFyhnyfHzfxwTel6D3w1wEDWMcPjhBUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toxAIKllqiT40gutWC2+BFNPpdhjGHq5/krmwOap5zIJX7bX1ZWZ99KNZD6iVEc4Y
         cHXmkFOkmrhrF9zxkD4nrxv65XWLaEmOYoVKjvo/5isixoeo2uEOHD5Z7IU6B0cpyt
         cvHzzQf5RgJBRmDgnaIUTpnz6GFUzLXi8oviwgbM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux trace devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/66] libtraceevent: Round up in tep_print_event() time precision
Date:   Wed, 25 Sep 2019 21:31:45 -0300
Message-Id: <20190926003244.13962-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When testing the output of the old trace-cmd compared to the one that
uses the updated tep_print_event() logic, it was different in that the
time stamp precision in the old format would round up to the nearest
precision, where as the new logic truncates. Bring back the old method
of rounding up.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: linux trace devel <linux-trace-devel@vger.kernel.org>
Link: http://lore.kernel.org/lkml/20190919165119.5efa5de6@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 6f842af4550b..d948475585ce 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5527,8 +5527,10 @@ static void print_event_time(struct tep_handle *tep, struct trace_seq *s,
 	if (divstr && isdigit(*(divstr + 1)))
 		div = atoi(divstr + 1);
 	time = record->ts;
-	if (div)
+	if (div) {
+		time += div / 2;
 		time /= div;
+	}
 	pr = prec;
 	while (pr--)
 		p10 *= 10;
-- 
2.21.0

