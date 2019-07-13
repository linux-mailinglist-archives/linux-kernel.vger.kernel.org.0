Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1661A679D3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGMLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 07:04:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfGMLEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:04:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB3pjn3839117
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:03:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB3pjn3839117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015832;
        bh=l7YBeiil97fJnQYrMWgIoLrmOJa7C1+dhW8EvzR9Bbc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p2butWx9snMnubMkovim5lI8uMp89v8St+jXgQTYXAc5r5vW5kd74A/rOCE3cXbFz
         kVc3IxpBvINGx7T5xu+Irx2IRwc5PtRvpAokjmzNynX2kRctYA1uHLab9o2Rty3gIN
         9TJb44HKcNuxQF5s4CZE5dYY/B2evCrjPMsqQDlwH5ClQ6DSER8ZCeaJYV4DHxOpWc
         XzzDLF5/WYQVFh3RKpT3qjoAe1FEObDbttzhGSQCWZ5ZLIC+XS0vqc4aMV0bqdYLw6
         Aav93al17r+z6s6no8gZsMgfL4hDpYZloWOos9gvb2OG+Ir4U4zQmVW37K3Xf4Q5dR
         YyKVKXYoMlYDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB3oBs3839114;
        Sat, 13 Jul 2019 04:03:50 -0700
Date:   Sat, 13 Jul 2019 04:03:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Luke Mujica <tipbot@zytor.com>
Message-ID: <tip-34c9af571e51466fbcc423fb955277c82f03ce92@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, lukemujica@google.com,
        eranian@google.com, mingo@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, peterz@infradead.org, irogers@google.com,
        jolsa@redhat.com, hpa@zytor.com
Reply-To: mingo@kernel.org, eranian@google.com, lukemujica@google.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
          peterz@infradead.org, irogers@google.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, tglx@linutronix.de
In-Reply-To: <20190703222509.109616-1-lukemujica@google.com>
References: <20190703222509.109616-1-lukemujica@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf parse-events: Remove unused variable 'i'
Git-Commit-ID: 34c9af571e51466fbcc423fb955277c82f03ce92
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  34c9af571e51466fbcc423fb955277c82f03ce92
Gitweb:     https://git.kernel.org/tip/34c9af571e51466fbcc423fb955277c82f03ce92
Author:     Luke Mujica <lukemujica@google.com>
AuthorDate: Wed, 3 Jul 2019 15:25:08 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf parse-events: Remove unused variable 'i'

Remove the 'int i' because it is declared but not used in parse-events.y
or in the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190703222509.109616-1-lukemujica@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6ad8d4914969..172dbb73941f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -626,7 +626,6 @@ PE_TERM
 PE_NAME array '=' PE_NAME
 {
 	struct parse_events_term *term;
-	int i;
 
 	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
 					$1, $4, &@1, &@4));
