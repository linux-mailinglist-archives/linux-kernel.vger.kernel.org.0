Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA092F826
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfE3H6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:58:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57853 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfE3H6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:58:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7tXNg2899989
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:55:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7tXNg2899989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559202934;
        bh=2MQ5twDQclop9Lhg3OvxGH0hHZhtQ57iu1DY2lcjYYo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FNoQF98Oor6fJoRP1zleewAh0atv1+M9wsBKraueC0MS2VFWWtiIvTtZANn7C2Vx9
         oPEkr5XdoZ5jawk+d8HVxNaJLedQ+k9/MdWyOQsIiYr8uBFm06ZafWLEk3gtgAoDF+
         j5AfGMSVOZGlJwUio1cDarpdPph2hI0IGDt8rexVd3f18ZlQWxRgYULUzvJ95nBOnU
         QKN+mXa6VDIhZV2wA9oa64Fve/4kQPQPEve4MhRx7Yaj1/7jSugMFnS4XxGK0dZ3Do
         w6ZErJ99NNo9a4Tlnjj8C1Rvf6W1cvMNwVo9EPwZzkJhozhiNHkD/Pe5Xh0s95Rd7a
         EFXXQ8kYKR90Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7tWCu2899986;
        Thu, 30 May 2019 00:55:32 -0700
Date:   Thu, 30 May 2019 00:55:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8529f2e67313fb623da7ce81bc14cf12ccc0e12f@git.kernel.org>
Cc:     ak@linux.intel.com, adrian.hunter@intel.com, hpa@zytor.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, songliubraving@fb.com, sdf@google.com,
        jolsa@kernel.org, namhyung@kernel.org
Reply-To: peterz@infradead.org, ak@linux.intel.com,
          adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org,
          songliubraving@fb.com, sdf@google.com, jolsa@kernel.org,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          acme@redhat.com
In-Reply-To: <20190508132010.14512-7-jolsa@kernel.org>
References: <20190508132010.14512-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Keep zero in pgoff BPF map
Git-Commit-ID: 8529f2e67313fb623da7ce81bc14cf12ccc0e12f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8529f2e67313fb623da7ce81bc14cf12ccc0e12f
Gitweb:     https://git.kernel.org/tip/8529f2e67313fb623da7ce81bc14cf12ccc0e12f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf machine: Keep zero in pgoff BPF map

With pgoff set to zero, the map__map_ip function will return BPF
addresses based from 0, which is what we need when we read the data from
a BPF DSO.

Adding BPF symbols with mapped IP addresses as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc7aafe45a2b..f5569f005cf3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -704,12 +704,12 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			return -ENOMEM;
 
 		map->start = event->ksymbol_event.addr;
-		map->pgoff = map->start;
 		map->end = map->start + event->ksymbol_event.len;
 		map_groups__insert(&machine->kmaps, map);
 	}
 
-	sym = symbol__new(event->ksymbol_event.addr, event->ksymbol_event.len,
+	sym = symbol__new(map->map_ip(map, map->start),
+			  event->ksymbol_event.len,
 			  0, 0, event->ksymbol_event.name);
 	if (!sym)
 		return -ENOMEM;
