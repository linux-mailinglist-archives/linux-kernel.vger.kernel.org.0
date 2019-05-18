Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2F2226E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfERI7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 04:59:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERI7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:59:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8xQac1733631
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:59:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8xQac1733631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169967;
        bh=kOyIquCES62qVwjpvjQUxORX/NFCMLbrExH/YWU31R0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=n+TgXIKq62/fImrnYgLKtQa1ty1HZcpqD3rmza3MdhH6NyrHewL9+KBxjBfvHYtoO
         PiM0yJoVuqNMqsO8Vha2yR9UXYDeEHZu6DOMhMX2VqGUfzcT1a/0pFe3a0YiwaNSRz
         7092Yb5c28yKqYbBFRd4+KRSxAcpQtaAd7frEYxPy0x5f87MUnPuBCAnix6JvJ8Wg2
         PG9snvq0m6uDb88l9P9qWkMY7ZD6vS0BV9pGP/OfJ37wahF7dBunmWan9RpPEYS0vw
         VLqZ6PU1XqjJvNr7w09rAwTaCsGE9Bj24W+sYbc9b3nCwq/hlh8SC9hpkphj46ECo0
         J8Dz/tTCJJ47w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8xQMi1733628;
        Sat, 18 May 2019 01:59:26 -0700
Date:   Sat, 18 May 2019 01:59:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Donald Yandt <tipbot@zytor.com>
Message-ID: <tip-30ba5b0e66c872faa416a458d32cc3956ecb548a@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        yanmin_zhang@linux.intel.com, acme@redhat.com, jolsa@redhat.com,
        tglx@linutronix.de, donald.yandt@gmail.com, avi@scylladb.com
Reply-To: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, donald.yandt@gmail.com,
          hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, avi@scylladb.com, acme@redhat.com,
          yanmin_zhang@linux.intel.com
In-Reply-To: <20190514110100.22019-1-donald.yandt@gmail.com>
References: <20190514110100.22019-1-donald.yandt@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Null-terminate version char array
 upon fgets(/proc/version) error
Git-Commit-ID: 30ba5b0e66c872faa416a458d32cc3956ecb548a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  30ba5b0e66c872faa416a458d32cc3956ecb548a
Gitweb:     https://git.kernel.org/tip/30ba5b0e66c872faa416a458d32cc3956ecb548a
Author:     Donald Yandt <donald.yandt@gmail.com>
AuthorDate: Tue, 14 May 2019 07:01:00 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf machine: Null-terminate version char array upon fgets(/proc/version) error

If fgets() fails due to any other error besides end-of-file, the version
char array may not even be null-terminated.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Link: http://lkml.kernel.org/r/20190514110100.22019-1-donald.yandt@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa198c..28a9541c4835 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
 	if (!file)
 		return NULL;
 
-	version[0] = '\0';
 	tmp = fgets(version, sizeof(version), file);
+	if (!tmp)
+		*version = '\0';
 	fclose(file);
 
 	name = strstr(version, prefix);
