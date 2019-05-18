Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B222261
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 10:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfERIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 04:53:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfERIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:53:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8rEd61732516
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:53:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8rEd61732516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169595;
        bh=frca8zZd1TVZkjuhyHv2EYJB355SEFXdTb1IFOkc+5g=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=sKBCEypmENa9aleZcyRbvIjVpucWIpDK70aevgQXuO25atUtxRj1Rutseu+sZMHwH
         HQjpXQ+UJPE5cO2Bh1voyxkR5eVHlDf6yv+nCDYOOUL4nnefWhxMgM/8r7c0HYS+XV
         kOSLZ9mIdnRbHVOcWiq6QZNSjid2WMq/5eRAMf6G8HV5ME9OVn07bvxmbs/lVRAPfl
         FXcQE/ZwuzTKPPJ1YYpY9uXljbWZkRz+GzlHQXNcDkF2GD/mcKGBSLYQtVetXjUy7h
         FY0DbNUgwE0iEzFayZhVagy5TIKlGp9phWXWB48GZyIoRQn3OLkrClCWZRO1a53mcH
         PUivaWTmFhDnA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8rDrE1732512;
        Sat, 18 May 2019 01:53:13 -0700
Date:   Sat, 18 May 2019 01:53:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9a9hyuum8c0oggg86xd3sxc5@git.kernel.org>
Cc:     eranian@google.com, adrian.hunter@intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, ak@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, acme@redhat.com, mingo@kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, ak@linux.intel.com, tglx@linutronix.de,
          hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org, eranian@google.com,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf parse-regs: Improve error output when faced
 with unknown register name
Git-Commit-ID: 4c1cf20334ae6e390e1ea787ef76c40a161370d1
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

Commit-ID:  4c1cf20334ae6e390e1ea787ef76c40a161370d1
Gitweb:     https://git.kernel.org/tip/4c1cf20334ae6e390e1ea787ef76c40a161370d1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 13 May 2019 14:28:32 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf parse-regs: Improve error output when faced with unknown register name

Add quotes around the register name and suggest using 'perf record -I?'
to get the list of available registers.

Before:

  # perf record -Idi,xmm20,xmm1
  Warning:
  unknown register xmm20, check man page

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #
  # perf record -Idi,xmm20,xmm1
  Warning:
  unknown register "xmm20", check man page or run "perf record -I?"

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-9a9hyuum8c0oggg86xd3sxc5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-regs-options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index e6599e290f46..9cb187a20fe2 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -48,8 +48,7 @@ parse_regs(const struct option *opt, const char *str, int unset)
 					break;
 			}
 			if (!r->name) {
-				ui__warning("unknown register %s,"
-					    " check man page\n", s);
+				ui__warning("Unknown register \"%s\", check man page or run \"perf record -I?\"\n", s);
 				goto error;
 			}
 
