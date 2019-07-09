Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5D634F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfGILcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:32:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGILcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:32:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BW5eo1893066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:32:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BW5eo1893066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671926;
        bh=CoVYh7RQcHEdJFMYLr9zPdY9n2b7cEdPgptgdwzXnfg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Dm1QEsQ+Fq1Hag7BRArKTqkJnnd4qQBjORuW08MQn2E+9Jv3jqJCojithRfGloQ8P
         /ZG1Aj8J5YPwRnrpzk7t8XMYNn+CWBc5IyDd/djok0NjxGU5btxpLpAa0csi1f1p+r
         lMQpG9Y0r4S8NTYzrMPUyXoBv3QFD5dqlLJ93HfL0us3XMf2PiTD8WjFzTXec84raO
         OriH1vy5mu1rgKdKB08ZYcouk46IBlamUr5VAtoTSn1i5LVLY1RhTDl7v+51vcD9yt
         dTlgQJ08iZRgUpL6C1sMFKJ4R+CUtQwzqHZVqTQMI/j9Cl8mp+UUwK4YE7ayu56Dz6
         4lF3RG/+Iss0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BW5nj1893063;
        Tue, 9 Jul 2019 04:32:05 -0700
Date:   Tue, 9 Jul 2019 04:32:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f9nexro58q62l3o9hez8hr0i@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          namhyung@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate TUI browser: Do not use member from
 variable within its own initialization
Git-Commit-ID: d5b2179d6a675ee8cdbd3250d42f1e32d5a45fb1
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

Commit-ID:  d5b2179d6a675ee8cdbd3250d42f1e32d5a45fb1
Gitweb:     https://git.kernel.org/tip/d5b2179d6a675ee8cdbd3250d42f1e32d5a45fb1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 May 2019 16:02:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 16:59:11 -0300

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
