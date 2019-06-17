Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA148DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfFQTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:16:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:16:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJG2d33559573
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:16:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJG2d33559573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798963;
        bh=gVx3hXuIFJYkKAmvrfR0/2oh0i2DkF7PbVn1wdKkfOg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=eyKsgNoiqR1XJ+eek7Uzdh4gtpNzVL1XHWXc9GnhHRBpRqvtcbGDh4089l7/1sWtJ
         HHGvE+3EfRN+dAxOohciVHXD3skvvZxm2xTLLBRuGGokn2+9hYrnwwMBjZpDv7jnHd
         qR20qboXhnrXehoq68oI+3kTc52+Rjzp5WzkaOJ0hPDP/ZNeZSoCPm3tbhH6CXhZnG
         IhsJVeAEF7Ppd+OMW0GH5pJMFHrh7mWLWRIlm6wFgSes/vvUy4iquvRAKZO+1Ppm4Z
         QDPoIjpyy7OK3fCOAlQHKwilNUuiYAdaXowvo0OyXdVw3QP4KSxCXgVCtyRZcPQQ7o
         Llbi8APjnD4Hg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJG2TB3559570;
        Mon, 17 Jun 2019 12:16:02 -0700
Date:   Mon, 17 Jun 2019 12:16:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4e4cmzyjxb3wkonfo1x9a27y@git.kernel.org>
Cc:     namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        adrian.hunter@intel.com, brendan.d.gregg@gmail.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
        lclaudio@redhat.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
          mingo@kernel.org, lclaudio@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, namhyung@kernel.org, brendan.d.gregg@gmail.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Consume the augmented_raw_syscalls
 payload
Git-Commit-ID: 8195168e877948bb9a943ce11ad3e6ee71014bd5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8195168e877948bb9a943ce11ad3e6ee71014bd5
Gitweb:     https://git.kernel.org/tip/8195168e877948bb9a943ce11ad3e6ee71014bd5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 5 Jun 2019 10:34:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 10:52:19 -0300

perf trace: Consume the augmented_raw_syscalls payload

To support the SCA_FILENAME beautifier in more than one syscall arg, as
needed for syscalls such as the rename* family, we need to, after
processing one such arg, bump the augmented pointers so that the next
augmented arg don't reuse data for the previous augmented arguments.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4e4cmzyjxb3wkonfo1x9a27y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 19f22127f02e..905e57c336b0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1233,8 +1233,17 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
+	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	/*
+	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
+	 * we would have two strings, each prefixed by its size.
+	 */
+	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
-	return scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	arg->augmented.args += consumed;
+	arg->augmented.size -= consumed;
+
+	return printed;
 }
 
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
