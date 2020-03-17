Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B4189085
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 22:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCQVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 17:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgCQVeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660AB20757;
        Tue, 17 Mar 2020 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480842;
        bh=Z9j7UZbT4RR4xbQdANlM4HcRrJBuhd00PkTyuGO8S0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqbHlpXx6TpL1aQfepPIWdS3TwuLfUGZzBqEV6SgQFUPjs+4iCaHbAEcnmLYazfLk
         2tIQjAfcC1jSvlU/WagJO/BC0MTXTfgdiesFAyFaCgp02OLTO94HdVI+1RvbyjAtSG
         utp9xi3T5+Pfy/dtUpYT3aODSAygFsKIpFvzRK0E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 14/23] perf doc: Set man page date to last git commit
Date:   Tue, 17 Mar 2020 18:32:50 -0300
Message-Id: <20200317213259.15494-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

Currently the man page dates reflect the date the man pages were built.
This patch adjusts the date so that the date is when then man page
last had a commit against it. The date is generated using 'git log'.

Committer testing:

  $ git log -1 --pretty="format:%cd" --date=short tools/perf/Documentation/perf-top.txt
  2020-01-14

Before:

  rm -rf /tmp/build/perf
  mkdir -p /tmp/build/perf
  make -C tools/perf O=/tmp/build/perf/ install
  $ date
  Wed 11 Mar 2020 10:21:19 AM -03
  $ man perf-top | tail -1
  perf                    03/11/2020           PERF-TOP(1)
  $

After:

  rm -rf /tmp/build/perf
  mkdir -p /tmp/build/perf
  make -C tools/perf O=/tmp/build/perf/ install
  $ date
  $ date
  Wed 11 Mar 2020 10:24:06 AM -03
  $ man perf-top | tail -1
  perf                    2020-01-14           PERF-TOP(1)
  $

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200311052110.23132-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index adc5a7e44b98..31824d5269cc 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -295,7 +295,10 @@ $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
 $(OUTPUT)%.xml : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage \
-		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
+		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
+		-aperf_date=$(shell git log -1 --pretty="format:%cd" \
+				--date=short $<) \
+		-o $@+ $< && \
 	mv $@+ $@
 
 XSLT = docbook.xsl
-- 
2.21.1

