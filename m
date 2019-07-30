Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035F37B142
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfG3SHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:07:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3SHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:07:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI6s783324669
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:06:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI6s783324669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564510015;
        bh=IzvdYjuzAzHvkCcwaWbSI0JBAKQdBjDFwWZIhjNUm/k=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=IFe7NC6FYlcDScJH4/mWcew0Y63lhCmBtQMDkFmhS/4CCTl9JlbN7ppSIKI8vDe2P
         T2Jrxl4WUaewXrLu1EXqv2POf0T+9ebBqVWk8o9YAqdWqe+TjIQqc7gH2hncVntGd9
         iKRc+ciykBWw3udLorZgJvtB5S9DZmkrIszP6weYg1n1dEn+0STV0gFB7EZkdtJqZY
         VCDkzCi1019shXJybz/Arfu0ADA3A7YjtO8PhC2kbas6fyDw7axfRtGPGfJG4GWqFj
         ry/Lja0jyexlVrzbql18vmO3wdvgsZNSwr0d4cjdhNMKmRMiunMmU1S+b4af0yULgW
         plwVbwYi6DZhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI6s533324666;
        Tue, 30 Jul 2019 11:06:54 -0700
Date:   Tue, 30 Jul 2019 11:06:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-km2hmg7hru6u4pawi5fi903q@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        lclaudio@redhat.com, acme@redhat.com, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org
Reply-To: lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add "sendfile64" alias to the
 "sendfile" syscall
Git-Commit-ID: e4b00e930bf71ef32189716e6cb6b0565592f078
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

Commit-ID:  e4b00e930bf71ef32189716e6cb6b0565592f078
Gitweb:     https://git.kernel.org/tip/e4b00e930bf71ef32189716e6cb6b0565592f078
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:32:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace: Add "sendfile64" alias to the "sendfile" syscall

We were looking in tracefs for:

  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile/format when

what is there is just

  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile/format

Its the same id, 40 in x86_64, so just add an alias and let the existing
logic take care of that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-km2hmg7hru6u4pawi5fi903q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 200fbe33d5de..ca28c48f812e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -895,6 +895,7 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_SECCOMP_OP,	   /* op */ },
 		   [1] = { .scnprintf = SCA_SECCOMP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "select", .timeout = true, },
+	{ .name	    = "sendfile", .alias = "sendfile64", },
 	{ .name	    = "sendmmsg",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendmsg",
