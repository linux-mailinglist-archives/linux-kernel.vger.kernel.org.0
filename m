Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619CF180FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 06:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCKFVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 01:21:18 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42020 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCKFVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:21:18 -0400
Received: by mail-pl1-f201.google.com with SMTP id t4so581961plz.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 22:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mwewHnZ8oCFxwWkW+DlnQSVOJjhGJHXTFUPER+mQbIA=;
        b=OFRiBPM+ZPqYrOeTPkjqyPOnmyRbOxNRuAf5Lu6Br+m7r8DI/ugBMREnoPgZRVUG0v
         nfiv4ocMaPWX+xzGnytXRfAVvQ52aSsVPbA83J/9zudG4nhl3KDC+czo2G1XVWpsiyrM
         ErBmqcQ5dG3mweYbnPPXxYcvKbPhFOexLwLkwgNn46DEnDLWxL3Wq4kBC90dFrUTYyUb
         RrQtxs5H55JihZRrEjg1NdiuS2KBBevh69CxxMVy2UnJcTrErNEjgkMMjleh4BSA/Dwm
         zb8sWNWD+n+hfChmJFLP1jPx5E0uAxgntZXxHbx1Iyw6uYUDe9fNLKJRRYcYKEWE+GBD
         1nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mwewHnZ8oCFxwWkW+DlnQSVOJjhGJHXTFUPER+mQbIA=;
        b=P3mQ/zVR5EbmTIYO2g6rKT9BwxmMgeItIqpn5s56oJj/o2BAwTabkyN38e1rOma5w+
         fcPSgZu5lDTKI6UqVZ5FZaTZBDERKj+o/rMcvlJw1iSAOHXvbsHoCh7eZPRxeavhKx9Z
         boFKh9UVDcBTE9UunqxXEXsu1HmmAqAGt7XOtVeLRhIKwERCwPEJ7STlW96vaLpe1qb8
         jHV3hwQl1izzUVPOLZGPUb+U2SoOpOtMczpDzlmVV3JkNwLPZl9ncZ+zJAhcRW0eb+Uq
         mOfdYPOtWkoH5Obrfo3Y1mGKxgXeK6LpUQItJTu9L0Wbiw/hm4+5Kn/Q98yUW3dPPLAU
         7loA==
X-Gm-Message-State: ANhLgQ22jSh0HVG+OUOKT/77Qost6fZ1OQmnm79bMknDc0kOckYjtjWN
        5iW9lOrBCdzAxgJXgENcZq4ZxyDJLhXc
X-Google-Smtp-Source: ADFU+vttutOyTpwozPTGflZIulSLLyJH3X9KfkE7nRphJD4ZXr9No5IkNRTd5mmDoSLewuRYUZFO8YFvfGiG
X-Received: by 2002:a17:90a:e648:: with SMTP id ep8mr1571751pjb.42.1583904075305;
 Tue, 10 Mar 2020 22:21:15 -0700 (PDT)
Date:   Tue, 10 Mar 2020 22:21:10 -0700
Message-Id: <20200311052110.23132-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] perf doc: Set man page date to last git commit
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the man page dates reflect the date the man pages were built.
This patch adjusts the date so that the date is when then man page
last had a commit against it. The date is generated using 'git log'.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.25.1.481.gfbce0eb801-goog

