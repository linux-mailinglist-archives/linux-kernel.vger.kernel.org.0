Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D452A48D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 20:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfFQS4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 14:56:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:56:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIuObi3553408
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:56:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIuObi3553408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797785;
        bh=mEyJNqo4FFbaepedw9v87K8lEFqEvaLoJhBUa2TTJ2g=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=q2ztoGVGXijg+gcGn8Yxrw4U1f1t39GajkFiNjGt4AQKMsHFOHprE6cEKPtqAXqNl
         bZk41vqjT2DpvLdUl4W/zux1/2aFWQhJYBdECXf6e3qK9eanHY+TFvjtKcwTjpNmiD
         EFHV9rN47niAzt9tdvd0BAr0T0EqsIyZ2p5/dbODXlsuPSI0EyrCO33p8hhVZChHAV
         jJpLFzpZgI/+CG8p9go+RzM8zq4oOjOGCj1qRwO5RF3RQRYCFRsDwcd+sxGj/YggWh
         4QFDh0ZXJ2GBZPdlsjacwajUdq37M2SHCSLxYdCxbt0Imw47ApfGdwSjjppuw0vrcD
         m+8EDwqY7V/Ng==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIuOma3553405;
        Mon, 17 Jun 2019 11:56:24 -0700
Date:   Mon, 17 Jun 2019 11:56:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-slhnjp06027j3ae17qqetzxj@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        sque@chromium.org, alexander.shishkin@linux.intel.com,
        chongjiang@chromium.org, adrian.hunter@intel.com, acme@redhat.com,
        peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, namhyung@kernel.org, acme@redhat.com,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          chongjiang@chromium.org, adrian.hunter@intel.com,
          ak@linux.intel.com, sque@chromium.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          alexey.budankov@linux.intel.com, hpa@zytor.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Document clockid header: HEADER_CLOCKID
Git-Commit-ID: a9de7cfc7663882e98ec3b2ecf35c546a013b956
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

Commit-ID:  a9de7cfc7663882e98ec3b2ecf35c546a013b956
Gitweb:     https://git.kernel.org/tip/a9de7cfc7663882e98ec3b2ecf35c546a013b956
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 May 2019 15:43:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:53 -0300

perf data: Document clockid header: HEADER_CLOCKID

We forgot to update the perf.data file format document for the
HEADER_CLOCKID header, do it now from comments in the patch introducing
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: cf7905165fee ("perf record: Encode -k clockid frequency into Perf trace")
Link: https://lkml.kernel.org/n/tip-slhnjp06027j3ae17qqetzxj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 99733751695b..600999f89c6d 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -296,6 +296,12 @@ $ perf report --header-only -I
 # memory nodes (nr 1, block size 0x8000000):
 #    0 [7G]: 0-23,32-69
 
+	HEADER_CLOCKID = 23,
+
+One uint64_t for the clockid frequency, specified, for instance, via 'perf
+record -k' (see clock_gettime()), to enable timestamps derived metrics
+conversion into wall clock time on the reporting stage.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
