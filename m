Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7724A2F863
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfE3IPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:15:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3IPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:15:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8FTLP2905079
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:15:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8FTLP2905079
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204130;
        bh=SCYMXrbHCocyfPzXCCuOMuKzjQ/bE/bgm/lZzNov28Y=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=UdPMPcc0D6f7nI0gEMJl4PijfUfaE/fD+j25pdyXllrKHKVmmoQfABIxElIzZX6hm
         bomuLOI6ZhZGtj0ncIBYFf0KXZvrwCQwwl7x4fE/YzAZiZzjtOl7/mD59gJWyumqUW
         lC+i0Ce+WQNMQC1ELfu9da26uYs/cKBmQhHwsWa+bS+hMPJQSTZCW8sDONvHUkxijN
         1/qVejl4a06UABgjlwn7dE/1c5/ECuDbVGmJjFRoZ5PbKf+4guVjqEU9r5atUqYlJC
         lBOIzhBeoD0fRNYM8WSw9Pl4P3tb7rTF98yXP9E74N4zPgfy/SfNcYKabsSx/f0kpZ
         M314QK90NikIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8FThe2905076;
        Thu, 30 May 2019 01:15:29 -0700
Date:   Thu, 30 May 2019 01:15:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f9nexro58q62l3o9hez8hr0i@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com
Reply-To: mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate TUI browser: Do not use member from
 variable within its own initialization
Git-Commit-ID: da2019633f0b5c105ce658aada333422d8cb28fe
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

Commit-ID:  da2019633f0b5c105ce658aada333422d8cb28fe
Gitweb:     https://git.kernel.org/tip/da2019633f0b5c105ce658aada333422d8cb28fe
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 May 2019 16:02:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf annotate TUI browser: Do not use member from variable within its own initialization

Some compilers will complain when using a member of a struct to
initialize another member, in the same struct initialization.

For instance:

  debian:8      Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  oraclelinux:7 clang version 3.4.2 (tags/RELEASE_34/dot2-final)

Produce:

  ui/browsers/annotate.c:104:12: error: variable 'ops' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
                                              (!ops.current_entry ||
                                                ^~~
  1 error generated.

So use an extra variable, initialized just before that struct, to have
the value used in the expressions used to init two of the struct
members.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: c298304bd747 ("perf annotate: Use a ops table for annotation_line__write()")
Link: https://lkml.kernel.org/n/tip-f9nexro58q62l3o9hez8hr0i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 98d934a36d86..b0d089a95dac 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -97,11 +97,12 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct annotation *notes = browser__annotation(browser);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
+	const bool is_current_entry = ui_browser__is_current_entry(browser, row);
 	struct annotation_write_ops ops = {
 		.first_line		 = row == 0,
-		.current_entry		 = ui_browser__is_current_entry(browser, row),
+		.current_entry		 = is_current_entry,
 		.change_color		 = (!notes->options->hide_src_code &&
-					    (!ops.current_entry ||
+					    (!is_current_entry ||
 					     (browser->use_navkeypressed &&
 					      !browser->navkeypressed))),
 		.width			 = browser->width,
