Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0537B0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfG3RvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:51:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41779 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3RvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:51:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHp7gn3320448
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:51:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHp7gn3320448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509068;
        bh=EMYT1qj9cuDgQr+MZhYkEbdwosSn+t5socgF+KIDgpQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=RR82ppu1KwarKzDr6dsOlMR/pfqcRQ/9NYTgbf1wMyCBtJpmEbZjnvC+QNOYOBgpW
         xgaivoiUKTzQkntSx8PWlRkt+4IAXmPCRMsbYQvyDVmra87bbi+RX1AAGfwFTaUKld
         fupt5dksum7U5rLNNyTyI/FlgKJuxOea2CeRElGcUVM6HXc5df3gmn283pmdgeTC9l
         OdOaxKsdNuVgKIyl9B3VXQBaGSRhoHm7Zopr/MTuveGnLrxa9K727PTcnw99gLdGI+
         gC4QOe8q/vawmC/UOe91xsgM1g4WBDoEui30oUZjP/tju3fNOW3qTO3RSrcHRdBhNT
         bgblr6up6GAJw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHp6jV3320439;
        Tue, 30 Jul 2019 10:51:06 -0700
Date:   Tue, 30 Jul 2019 10:51:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c8hprylp3ai6e0z9burn2r3s@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, lclaudio@redhat.com,
        mingo@kernel.org
Reply-To: namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, lclaudio@redhat.com, hpa@zytor.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Order -e syscalls table
Git-Commit-ID: 83e69b92b10c2a8b75e1919b7074338f8bdbacaf
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

Commit-ID:  83e69b92b10c2a8b75e1919b7074338f8bdbacaf
Gitweb:     https://git.kernel.org/tip/83e69b92b10c2a8b75e1919b7074338f8bdbacaf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 17:28:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Order -e syscalls table

The ev_qualifier is an array with the syscall ids passed via -e on the
command line, sort it as we'll search it when setting up the
BPF_MAP_TYPE_PROG_ARRAY.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c8hprylp3ai6e0z9burn2r3s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bfd739a321d1..9bd5ecd6a8dd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1528,6 +1528,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return syscall__set_arg_fmts(sc);
 }
 
+static int intcmp(const void *a, const void *b)
+{
+	const int *one = a, *another = b;
+
+	return *one - *another;
+}
+
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0;
@@ -1591,6 +1598,7 @@ matches:
 	}
 
 	trace->ev_qualifier_ids.nr = nr_used;
+	qsort(trace->ev_qualifier_ids.entries, nr_used, sizeof(int), intcmp);
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
