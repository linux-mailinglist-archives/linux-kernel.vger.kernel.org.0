Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B92D0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfE1VZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 17:25:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfE1VZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:25:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLPU2j2240168
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:25:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLPU2j2240168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078730;
        bh=BHFswm328hwysMDs/6CuLlvN4IAwBP17ftSZCSSjkBs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=ItWNDl/LyMbrKwYJtbi4BobHPsFWyBXUQPP+pWtgkN6Sveollhg4yCOw2LN5tmbyy
         Qm5FD7A9BaWYkGik1Y9tFdCgiY0dZkzqwnPaiMHQkJ4lY3mMYbZqBLWEYCPb28iPGo
         ro4j5HHiwRTIH4WRDGFDJLG3LpLuOxgPg03hABntRhdG8kRZ1RR5Qsm6uCG86DV8LW
         +v2yR+BAhVvCk9K8nSrV/t/jhu97LVlq9IYEUBShfuOd7yg+LtvXjGEtQefz2M9uH5
         NfWB2UnGRd/vJlb+/LJXPJDselS7lmLKTnHM0ODrIAXl07VxrsEdQfUhqEdWldTfRh
         QxcpG7K5jRrUg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLPUnE2240165;
        Tue, 28 May 2019 14:25:30 -0700
Date:   Tue, 28 May 2019 14:25:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-at3uoqcvmqdkwaysmvbj1wpv@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, lclaudio@redhat.com,
        jolsa@kernel.org, brendan.d.gregg@gmail.com,
        torvalds@linux-foundation.org, amir73il@gmail.com,
        tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: namhyung@kernel.org, acme@redhat.com, lclaudio@redhat.com,
          jolsa@kernel.org, brendan.d.gregg@gmail.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, amir73il@gmail.com,
          adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync linux/fs.h with the
 kernel
Git-Commit-ID: b5b999dca673bd7b2d4c267faf3478dca7baff7f
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

Commit-ID:  b5b999dca673bd7b2d4c267faf3478dca7baff7f
Gitweb:     https://git.kernel.org/tip/b5b999dca673bd7b2d4c267faf3478dca7baff7f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 17:07:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

tools headers UAPI: Sync linux/fs.h with the kernel

To pick up the changes in:

  c553ea4fdf27 ("fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback")

That should be used to beautify the 'sync_file_range' syscall 'flags'
arg.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-at3uoqcvmqdkwaysmvbj1wpv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 121e82ce296b..59c71fa8c553 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -320,6 +320,9 @@ struct fscrypt_key {
 #define SYNC_FILE_RANGE_WAIT_BEFORE	1
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
+#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
+					 SYNC_FILE_RANGE_WAIT_BEFORE | \
+					 SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
  * Flags for preadv2/pwritev2:
