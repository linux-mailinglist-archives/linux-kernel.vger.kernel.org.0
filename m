Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DF17C60A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 20:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCFTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 14:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgCFTMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:06 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8907206D5;
        Fri,  6 Mar 2020 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521926;
        bh=Am6zFIgFOLL63uCAqolgYvyXNoh1jE5cQ+uHZXB+BS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBmHrTtYZeST2IVX1Ir4RGq8Wlx8eHcYa6PdylK7lJe08Lm70Cy21gFuIQykNnGc9
         jdmzgwDulAs0yRuDL1Bxrh5DVq/twtXL0LCM3CW1INQhhLqlGBmLtCoztXhthpxNVj
         N3bTE4luk/O6HCLiLs45GuwnhVoYFT9dyqBaf/AE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/6] perf top: Fix stdio interface input handling with glibc 2.28+
Date:   Fri,  6 Mar 2020 16:11:37 -0300
Message-Id: <20200306191144.12762-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Since glibc 2.28 when running 'perf top --stdio', input handling no
longer works, but hitting any key always just prints the "Mapped keys"
help text.

To fix it, call clearerr() in the display_thread() loop to clear any EOF
sticky errors, as instructed in the glibc NEWS file
(https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS):

 * All stdio functions now treat end-of-file as a sticky condition.  If you
   read from a file until EOF, and then the file is enlarged by another
   process, you must call clearerr or another function with the same effect
   (e.g. fseek, rewind) before you can read the additional data.  This
   corrects a longstanding C99 conformance bug.  It is most likely to affect
   programs that use stdio to read interactive input from a terminal.
   (Bug #1190.)

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200305083714.9381-2-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f6dd1a63f159..d2539b793f9d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -684,7 +684,9 @@ static void *display_thread(void *arg)
 	delay_msecs = top->delay_secs * MSEC_PER_SEC;
 	set_term_quiet_input(&save);
 	/* trash return*/
-	getc(stdin);
+	clearerr(stdin);
+	if (poll(&stdin_poll, 1, 0) > 0)
+		getc(stdin);
 
 	while (!done) {
 		perf_top__print_sym_table(top);
-- 
2.21.1

