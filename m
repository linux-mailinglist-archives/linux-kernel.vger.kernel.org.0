Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC02EA38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfD2Sf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 14:35:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfD2Sf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:35:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIXM1M1027359
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:33:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIXM1M1027359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562804;
        bh=x8WNcoaGARUCBLFd77Kf/cOMvJFpzF7M2O4bHK1xiyY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N7IZqHzaHJ38rq/r7uxVNCG3D3TROJ6fip1scD55+bDnVuQliJ4ut/znhfS5ikNXD
         krmenxc4aVKyGRYrdyPRpkF4r7cbqSNpqQjIFrouN7qYo5tXMXwmv2s6lxWqVB+RwY
         rrhupGJOz19be0vh5mAWsfc4GRf/Fr4BVhW+69RNagFOHi9MhpFNOYsI4X2g4Ts4/x
         7pbkdtSCrEIiPjwiuclB4Zp4aFD9c34UXsqD0mTcERaflXz7xNdEGZmLoNKwazj9mo
         +HaQZElfbAlr7Gx0JktHrrngqOO5Arx7SVnWtktuzZt7t+SyHjfzslmEEHeu3H1b9w
         8EZIZNb1Ky4Aw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIXMbF1027355;
        Mon, 29 Apr 2019 11:33:22 -0700
Date:   Mon, 29 Apr 2019 11:33:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1b59562d3ab09dcef188eb8055d05f0336380394@git.kernel.org>
Cc:     jthumshirn@suse.de, mbenes@suse.cz, dvyukov@google.com, clm@fb.com,
        josef@toxicpanda.com, snitzer@redhat.com, cl@linux.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        dsterba@suse.com, mingo@kernel.org, akpm@linux-foundation.org,
        robin.murphy@arm.com, rppt@linux.vnet.ibm.com, airlied@linux.ie,
        rientjes@google.com, penberg@kernel.org, hpa@zytor.com,
        daniel@ffwll.ch, glider@google.com, akinobu.mita@gmail.com,
        catalin.marinas@arm.com, jani.nikula@linux.intel.com,
        luto@kernel.org, m.szyprowski@samsung.com, adobriyan@gmail.com,
        hch@lst.de, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com, tom.zanussi@linux.intel.com,
        agk@redhat.com, rostedt@goodmis.org,
        maarten.lankhorst@linux.intel.com, aryabinin@virtuozzo.com,
        tglx@linutronix.de
Reply-To: cl@linux.com, linux-kernel@vger.kernel.org, josef@toxicpanda.com,
          snitzer@redhat.com, clm@fb.com, dvyukov@google.com,
          mbenes@suse.cz, jthumshirn@suse.de, daniel@ffwll.ch,
          glider@google.com, rientjes@google.com, penberg@kernel.org,
          hpa@zytor.com, robin.murphy@arm.com, mingo@kernel.org,
          dsterba@suse.com, akpm@linux-foundation.org,
          rppt@linux.vnet.ibm.com, airlied@linux.ie, jpoimboe@redhat.com,
          luto@kernel.org, jani.nikula@linux.intel.com,
          akinobu.mita@gmail.com, catalin.marinas@arm.com,
          aryabinin@virtuozzo.com, maarten.lankhorst@linux.intel.com,
          tglx@linutronix.de, joonas.lahtinen@linux.intel.com,
          rodrigo.vivi@intel.com, tom.zanussi@linux.intel.com,
          agk@redhat.com, rostedt@goodmis.org, m.szyprowski@samsung.com,
          adobriyan@gmail.com, hch@lst.de
In-Reply-To: <20190425094801.501919093@linutronix.de>
References: <20190425094801.501919093@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] backtrace-test: Simplify stack trace handling
Git-Commit-ID: 1b59562d3ab09dcef188eb8055d05f0336380394
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

Commit-ID:  1b59562d3ab09dcef188eb8055d05f0336380394
Gitweb:     https://git.kernel.org/tip/1b59562d3ab09dcef188eb8055d05f0336380394
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:44:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:47 +0200

backtrace-test: Simplify stack trace handling

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094801.501919093@linutronix.de

---
 kernel/backtracetest.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/backtracetest.c b/kernel/backtracetest.c
index 1323360d90e3..a563c8fdad0d 100644
--- a/kernel/backtracetest.c
+++ b/kernel/backtracetest.c
@@ -48,19 +48,14 @@ static void backtrace_test_irq(void)
 #ifdef CONFIG_STACKTRACE
 static void backtrace_test_saved(void)
 {
-	struct stack_trace trace;
 	unsigned long entries[8];
+	unsigned int nr_entries;
 
 	pr_info("Testing a saved backtrace.\n");
 	pr_info("The following trace is a kernel self test and not a bug!\n");
 
-	trace.nr_entries = 0;
-	trace.max_entries = ARRAY_SIZE(entries);
-	trace.entries = entries;
-	trace.skip = 0;
-
-	save_stack_trace(&trace);
-	print_stack_trace(&trace, 0);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	stack_trace_print(entries, nr_entries, 0);
 }
 #else
 static void backtrace_test_saved(void)
