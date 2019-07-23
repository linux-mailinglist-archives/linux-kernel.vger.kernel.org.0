Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC5721D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392220AbfGWVvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 17:51:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbfGWVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:51:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLo4H2253471
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:50:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLo4H2253471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918605;
        bh=z7GsT5U770crz5ukSnI1EjzNJ7SHob0/daeGGzsaBHQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=i1Ft/gO5HOhR1hg7xN8qEN6CVgWnqlbuI0jE/zfwpcGZKXdjhly4z1Z7deRQX4Tte
         2S+ViuGNbpRwCeGCztPuaK5KgKc052v4tK5Cnd8sl/sXAR3LrxinfcrJsBhD4QrsVG
         deNP4u89BCyjqv5KOMTIMht8MlANrlPyLjQj+eLMOFhWPDpzWXUgV48i4okGixFVOU
         6oQGWcgVo6R49xP3f9Rqwx6KRbMoEHkiaTjUamm7jE+OReQ7oDj/yIYYc7e8wGDOK4
         e0zVYq/yrXLGglm1eg9Bvi6RQyv/YhfIGoDMElSIU259MiiYd3pUzjz+KvV9HoeJHQ
         iu+U8XGD3R/XQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLo4R7253468;
        Tue, 23 Jul 2019 14:50:04 -0700
Date:   Tue, 23 Jul 2019 14:50:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Cong Wang <tipbot@zytor.com>
Message-ID: <tip-146540fb545b8464ba1be298e3392daca0d183a2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, xiyou.wangcong@gmail.com,
        ak@linux.intel.com, jolsa@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          jolsa@kernel.org, xiyou.wangcong@gmail.com, ak@linux.intel.com,
          tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Always separate stalled cycles per
 insn
Git-Commit-ID: 146540fb545b8464ba1be298e3392daca0d183a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  146540fb545b8464ba1be298e3392daca0d183a2
Gitweb:     https://git.kernel.org/tip/146540fb545b8464ba1be298e3392daca0d183a2
Author:     Cong Wang <xiyou.wangcong@gmail.com>
AuthorDate: Fri, 17 May 2019 15:10:39 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 09:03:46 -0300

perf stat: Always separate stalled cycles per insn

The "stalled cycles per insn" is appended to "instructions" when the CPU
has this hardware counter directly. We should always make it a separate
line, which also aligns to the output when we hit the "if (total &&
avg)" branch.

Before:

  $ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
  4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
  3396325133,,cycles,64146628546,100.00,,

After:

  $ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
  6721924,,instructions,24026790339,100.00,0.22,insn per cycle
  ,,,,,0.00,stalled cycles per insn
  30939953,,cycles,24025512526,100.00,,

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20190517221039.8975-1-xiyou.wangcong@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 656065af4971..accb1bf1cfd8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -819,7 +819,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					"stalled cycles per insn",
 					ratio);
 		} else if (have_frontend_stalled) {
-			print_metric(config, ctxp, NULL, NULL,
+			out->new_line(config, ctxp);
+			print_metric(config, ctxp, NULL, "%7.2f ",
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
