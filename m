Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5D2F825
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfE3H6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:58:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfE3H6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:58:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7v4Qd2900267
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:57:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7v4Qd2900267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203024;
        bh=jbf3XcYfxyCgAXOhApp0wlWPMeqMtizkG4Ujp/eVvRA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=ef3LSbK0+kd6+hy0RdVsKFhuzhWdYEvT/aogDcPk4T50E1HfrZ92YFILgJntM46nn
         SL6HqQ5aWwHOwl3d+XFQxzhJ0+Yl6nQiTcRspGSNzi1M2lhwy5KLNy/hUIViFwufSx
         hg7AdAFjd9Ez0GRMKSAX6IuIhVTQv3rrtmvF/2Qx5mwppOEbs423vHC7XtpCbLQ8jH
         SeX3F2co8++QGQRnPrXCxTI7OJOTPDZQSu/WUMvWED4+8NwCGxJXI1xz9UB+iKZHgF
         TwD4JoEjSKxn2Q1kWPe3oLZ93QAu0ktHoHUY3QIdjcnbwE7aFqybeZcqtj/4i4gkX+
         dCs1YCSZn0V9Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7v3052900205;
        Thu, 30 May 2019 00:57:03 -0700
Date:   Thu, 30 May 2019 00:57:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zo5s6rloy42u41acsf6q3pvi@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Fix up comment
Git-Commit-ID: 8a70c6b162e3112ce87b40b1705da5c4e7566ac8
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

Commit-ID:  8a70c6b162e3112ce87b40b1705da5c4e7566ac8
Gitweb:     https://git.kernel.org/tip/8a70c6b162e3112ce87b40b1705da5c4e7566ac8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 23 May 2019 13:21:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf augmented_raw_syscalls: Fix up comment

Cut'n'paste error, the second comment is about the syscalls that have as
its second arg a string.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zo5s6rloy42u41acsf6q3pvi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 2422894a8194..b292e763f3c7 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -87,7 +87,7 @@ struct augmented_filename {
 #define SYS_SYMLINKAT          266
 #define SYS_MEMFD_CREATE       319
 
-/* syscalls where the first arg is a string */
+/* syscalls where the second arg is a string */
 
 #define SYS_PWRITE64            18
 #define SYS_EXECVE              59
