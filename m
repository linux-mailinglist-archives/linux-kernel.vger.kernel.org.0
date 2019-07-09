Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6AED634EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfGILbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:31:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37005 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGILbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:31:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BUeY11892939
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:30:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BUeY11892939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671842;
        bh=VFcNXTLYUizH895YRIZufcIjwLWdx95bNS514OgMu0E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hBP9uf7Zjb1yuL3UjUW1M6immLWJKAgmA50KVbCjhaayclMS5xzeAA1zhj2DAeIH1
         s7IRprYgUdTF5uSkD9CmZun15DHX9gWy9OgvIk9auGkBGaMq2ccaOrXmJjIxWCPf0e
         FK99AH3gNWezPyegVz7WH4OrHZgk2EwDI8jfRdT04moUzpFd7x46hUjJ15LfwPiI5R
         ZUggiwK7sglWwVy/3yai53VxaLZDG9D2DtPvEiHetrlDt/edjTOpaC3hu9ElS0pM2n
         0o3Hfjcc4B7r7CPBMg46NPyuJQyK9Cv7aInFO5tm1BfUAGH3AzgblsAae5jTXw4RJx
         sBbK3qOVXrFuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BUdfv1892931;
        Tue, 9 Jul 2019 04:30:39 -0700
Date:   Tue, 9 Jul 2019 04:30:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cd136189370cc8a5aec0ea4b4ec517e5ee38d8a0@git.kernel.org>
Cc:     kim.phillips@amd.com, acme@redhat.com, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
        Hi-Angel@yandex.ru, quentin.monnet@netronome.com, jolsa@kernel.org
Reply-To: Hi-Angel@yandex.ru, quentin.monnet@netronome.com,
          tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
          peterz@infradead.org, hpa@zytor.com, acme@redhat.com,
          kim.phillips@amd.com, ak@linux.intel.com, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190703080949.10356-1-jolsa@kernel.org>
References: <20190703080949.10356-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Do not rely on errno values for
 precise_ip fallback
Git-Commit-ID: cd136189370cc8a5aec0ea4b4ec517e5ee38d8a0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cd136189370cc8a5aec0ea4b4ec517e5ee38d8a0
Gitweb:     https://git.kernel.org/tip/cd136189370cc8a5aec0ea4b4ec517e5ee38d8a0
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 3 Jul 2019 10:09:49 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 14:30:30 -0300

perf evsel: Do not rely on errno values for precise_ip fallback

Konstantin reported problem with default perf record command, which
fails on some AMD servers, because of the default maximum precise
config.

The current fallback mechanism counts on getting ENOTSUP errno for
precise_ip fails, but that's not the case on some AMD servers.

We can fix this by removing the errno check completely, because the
precise_ip fallback is separated. We can just try  (if requested by
evsel->precise_max) all possible precise_ip, and if one succeeds we win,
if not, we continue with standard fallback.

Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Link: http://lkml.kernel.org/r/20190703080949.10356-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a5947625c5c..69beb9f80f07 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1785,14 +1785,8 @@ static int perf_event_open(struct perf_evsel *evsel,
 		if (fd >= 0)
 			break;
 
-		/*
-		 * Do quick precise_ip fallback if:
-		 *  - there is precise_ip set in perf_event_attr
-		 *  - maximum precise is requested
-		 *  - sys_perf_event_open failed with ENOTSUP error,
-		 *    which is associated with wrong precise_ip
-		 */
-		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
+		/* Do not try less precise if not requested. */
+		if (!evsel->precise_max)
 			break;
 
 		/*
