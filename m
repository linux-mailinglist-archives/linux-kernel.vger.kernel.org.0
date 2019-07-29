Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBF79B29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfG2Vfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:35:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfG2Vfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:35:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLZFGx2941488
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:35:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLZFGx2941488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564436116;
        bh=54aFg4SiSUr3cc4BaVDb+2vesbuQTVJoXvqS2ayhL+o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=4E/5Z2cC6HlnCpD61ggMQQUjeNcIwy7FItBNz2koTIubh95MM7q9rd8ifJkA/oC0l
         XiS1hu32QkgkDOBilBQ06nb5r/YoCn4K6oXYcGm7DM6C8VsphLUEA4ccMRc/ZY3vmu
         YydjskD/kDek0xJcwO2+2592KNVs3LqkMQnNTYmia//AdNxxWByCEFTMdmL1cG7AoI
         9Lp1Fdz5sADjLPVs4RcI6VFs3kpSxBc6kBKRaROQTU8CsEt9oom0s6kDF+K2Tg6HNX
         PB7ffbxeXAXBXFN3WZduR/5O6yeT7OTVBblGhYH5zs5dfwsmWgiK8KYLVoUdgUTKXI
         vygBFw1fBH4pg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLZFau2941483;
        Mon, 29 Jul 2019 14:35:15 -0700
Date:   Mon, 29 Jul 2019 14:35:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Numfor Mbiziwo-Tiapo <tipbot@zytor.com>
Message-ID: <tip-20f9781f491360e7459c589705a2e4b1f136bee9@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        irogers@google.com, nums@google.com, namhyung@kernel.org,
        songliubraving@fb.com, hpa@zytor.com, mbd@fb.com,
        peterz@infradead.org
Reply-To: irogers@google.com, mingo@kernel.org, nums@google.com,
          songliubraving@fb.com, namhyung@kernel.org, peterz@infradead.org,
          mbd@fb.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, eranian@google.com,
          tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com
In-Reply-To: <20190724234500.253358-2-nums@google.com>
References: <20190724234500.253358-2-nums@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf header: Fix use of unitialized value warning
Git-Commit-ID: 20f9781f491360e7459c589705a2e4b1f136bee9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  20f9781f491360e7459c589705a2e4b1f136bee9
Gitweb:     https://git.kernel.org/tip/20f9781f491360e7459c589705a2e4b1f136bee9
Author:     Numfor Mbiziwo-Tiapo <nums@google.com>
AuthorDate: Wed, 24 Jul 2019 16:44:58 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:43 -0300

perf header: Fix use of unitialized value warning

When building our local version of perf with MSAN (Memory Sanitizer) and
running the perf record command, MSAN throws a use of uninitialized
value warning in "tools/perf/util/util.c:333:6".

This warning stems from the "buf" variable being passed into "write".
It originated as the variable "ev" with the type union perf_event*
defined in the "perf_event__synthesize_attr" function in
"tools/perf/util/header.c".

In the "perf_event__synthesize_attr" function they allocate space with a malloc
call using ev, then go on to only assign some of the member variables before
passing "ev" on as a parameter to the "process" function therefore "ev"
contains uninitialized memory. Changing the malloc call to zalloc to initialize
all the members of "ev" which gets rid of the warning.

To reproduce this warning, build perf by running:
make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
 -fsanitize-memory-track-origins"

(Additionally, llvm might have to be installed and clang might have to
be specified as the compiler - export CC=/usr/bin/clang)

then running:
tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
 -i - --stdio

Please see the cover letter for why false positive warnings may be
generated.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190724234500.253358-2-nums@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 47877f0f6667..1903d7ec9797 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3646,7 +3646,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 	size += sizeof(struct perf_event_header);
 	size += ids * sizeof(u64);
 
-	ev = malloc(size);
+	ev = zalloc(size);
 
 	if (ev == NULL)
 		return -ENOMEM;
