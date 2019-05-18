Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB84522298
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfERJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 05:20:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfERJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:20:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9J0mw1738521
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:19:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9J0mw1738521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171141;
        bh=xZ/VRyCOrAE295V/4ATX0FBf1ij1uBlrKwFGtlzSEFs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Kh5yNZJ4Xm4jz/I6PHLXgmDA0YbdzvjNCCf28aAW1bejvFY9fQzGyjgtRbsKB+MVv
         cwN2mGTW3dwfBM514aaM9mCiqz0+gPjcOud73mMB+TfTKfCKcbStuDR5zoR7jElTgK
         YTsZn3pTElZb4FWU018dQ/43rys/K0KXa02kR54M9QR9XSJ8LGtdnT55rBkSUjdvUu
         e8DSaYYsmXHcb+BNLCWYBcRrcbFC1eMm+Hkdo8OhRtUjMx7Fsv5QtxWelh5qxBDHGH
         5jvy0XEXk0wdZLvbAoowlI2765PtF4kEfkfgqk8RhgZAxOrmy94PWkwJ+hxI42pN5w
         tpXvJ8JilLJjQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Ixx61738518;
        Sat, 18 May 2019 02:18:59 -0700
Date:   Sat, 18 May 2019 02:18:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7o65mfl10wlvm8v3f0ombxd1@git.kernel.org>
Cc:     jolsa@kernel.org, alexey.budankov@linux.intel.com, acme@redhat.com,
        mingo@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, alexey.budankov@linux.intel.com,
          jolsa@kernel.org, hpa@zytor.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, ak@linux.intel.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build tests: Add NO_LIBZSTD=1 to make_minimal
Git-Commit-ID: 5b6f5aef10f65863151fd4daed61657ad2681f98
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5b6f5aef10f65863151fd4daed61657ad2681f98
Gitweb:     https://git.kernel.org/tip/5b6f5aef10f65863151fd4daed61657ad2681f98
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 14 May 2019 16:48:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf build tests: Add NO_LIBZSTD=1 to make_minimal

So that we can test the ifdef parts for this feature.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-7o65mfl10wlvm8v3f0ombxd1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index e46723568516..5363a12a8b9b 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -107,7 +107,7 @@ make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
-make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
+make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 
 # $(run) contains all available tests
 run := make_pure
