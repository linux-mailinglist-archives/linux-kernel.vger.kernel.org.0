Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29149035
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfFQTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:47:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:47:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJlFRs3569664
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:47:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJlFRs3569664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800836;
        bh=AY91mocSbYX9IgBkVDE3FsIsfyrm1nj9Bm40X/SY0NA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UVjIefvOJiEDe5M0r8EVgoLWpAKdQn8dLy/jsDiolrpKhnr+PRt3drXJDbq9b3bdF
         zdIbv8e9PRwZvZTwW/82xbV2Xs+Lo8wjRyh34HDvTgeiyDdWAIgzz0UW1Btfi1e0fE
         TzuDrwo23pIB1/Ic/sg7/LCA2+sl1Vwp7CW0cI4PO2FBTnvubrH1f9TZNVVnCNUYOS
         LSvtYE8oF+kXJXZ6jmR93XLJV31u4BFqhzxuIZhHwrBJz02zowi/KybrWSXYK8quU8
         wgWpHTjrMkJYEHsZIG1qnaDLQQlT9ZxhzlQQ+dOjk8m7xZZrV4hzG3PbMTdn1UlVgs
         GEGLT3tkR7dwg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJlFG73569661;
        Mon, 17 Jun 2019 12:47:15 -0700
Date:   Mon, 17 Jun 2019 12:47:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b16bfeb3db1b50273e95f539953c337be759500d@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: yao.jin@linux.intel.com, adrian.hunter@intel.com,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20190604130017.31207-15-adrian.hunter@intel.com>
References: <20190604130017.31207-15-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Prevent percentage time range
 overlap
Git-Commit-ID: b16bfeb3db1b50273e95f539953c337be759500d
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

Commit-ID:  b16bfeb3db1b50273e95f539953c337be759500d
Gitweb:     https://git.kernel.org/tip/b16bfeb3db1b50273e95f539953c337be759500d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:12 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf time-utils: Prevent percentage time range overlap

Prevent percentage time range overlap. This is only a 1 nanosecond
change but makes the results more logical e.g. a sample cannot be in
both the first 10% and the second 20%.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 69441faab3d0..3e87c21c293c 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -148,6 +148,9 @@ static int set_percent_time(struct perf_time_interval *ptime, double start_pcnt,
 	ptime->start = start + round(start_pcnt * total);
 	ptime->end = start + round(end_pcnt * total);
 
+	if (ptime->end > ptime->start && ptime->end != end)
+		ptime->end -= 1;
+
 	return 0;
 }
 
