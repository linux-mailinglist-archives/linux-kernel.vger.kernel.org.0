Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC93EE262
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfKDO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:29:08 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:43266 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfKDO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:29:04 -0500
Received: by mail-ua1-f73.google.com with SMTP id b12so2661666uan.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pDhjw8llKKibkxwiEHjLwKfV0zoLrBjVR8XQZovar/g=;
        b=LohiqOAcn6QB64L+xHNmTrNt1oKq4UZRkk4ZOhNrkaIxT1TltVDgpaprtEdibTc9pU
         A3DldvhOSHYm9RKiNhv/6sRm2D1JbPCRDzgE3/c1GpAU2Jyv8tXRPLu2UNpc6Ukyiz51
         SOtLkgj8OZ5YtevqEFEQ6iIBKMWD+3/xzWtyrdxl0scSH5KcQ6ctsCphAu7ip6gQBDL1
         Knbbpb+HuMTblcij2UwwdOwlf2vvecyoBV8ZwKls56j6P+XNjjTsTjRq87vdKZE0Xb5r
         LBfonj+OTaHHrtkacnJyj6KX3UQabQ3eWMCKP9kxDsoEJ4NXEn7JlCddkDBVEI/NHXRh
         d44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pDhjw8llKKibkxwiEHjLwKfV0zoLrBjVR8XQZovar/g=;
        b=epdkFaPziDEU7/jhivZNFoppZ7TLOYgUEidjH4pA9ASKpcudQxe3o3I0vSH4ACh5KC
         P2/0BW8Vqt6/yLIUBwPCKCDnFZeHyxYSi7MFjiauVo3m6K/QF4qAkMrz8BI18WQgO+Db
         tr6Z4EpCtc4wxEgmXNDIiZ7PPj+rP59hr3gJGIkqdUT4+aYVQWPJEp/vIauA17IQxUTM
         /KcvIi5dATwB4thqO2pVai1vgSuPoRgtHzRycuYfFz/iIRYgMRsZTEROYDjtebTeitwu
         0aTv1zXdrWU3Cb6Sra9NxOqDX6x8xskmaOAgfrIgpKFonO69UPkinRUaTO+knEwHMx/S
         aP4w==
X-Gm-Message-State: APjAAAUm9732QmOFFUaarzyqevJ+RFBNorXns9E5g9aiMNmpBRD2wI54
        K0615ohdliqAMJ5S6j8K4diNbljsAg==
X-Google-Smtp-Source: APXvYqzw3sxkDPv1YzCqpxSha4ijHDPuL+Rfk58iD5OOS4HLDTOu4FfiMAruziYhLL/nRX03UYWRc/epwg==
X-Received: by 2002:a67:fd8b:: with SMTP id k11mr11860157vsq.43.1572877742637;
 Mon, 04 Nov 2019 06:29:02 -0800 (PST)
Date:   Mon,  4 Nov 2019 15:27:40 +0100
In-Reply-To: <20191104142745.14722-1-elver@google.com>
Message-Id: <20191104142745.14722-5-elver@google.com>
Mime-Version: 1.0
References: <20191104142745.14722-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v3 4/9] build, kcsan: Add KCSAN build exceptions
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This blacklists several compilation units from KCSAN. See the respective
inline comments for the reasoning.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Moved EFI stub build exception hunk from x86-specific patch, since
  it's not x86-specific.
* Spelling "data-race" -> "data race".
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 kernel/Makefile                       | 5 +++++
 kernel/sched/Makefile                 | 6 ++++++
 mm/Makefile                           | 8 ++++++++
 4 files changed, 21 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ee0661ddb25b..5d0a645c0de8 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -31,7 +31,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 74ab46e2ebd1..cc53f7c25446 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -23,6 +23,9 @@ endif
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
 # in coverage traces.
 KCOV_INSTRUMENT_softirq.o := n
+# Avoid KCSAN instrumentation in softirq ("No shared variables, all the data
+# are CPU local" => assume no data races), to reduce overhead in interrupts.
+KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
@@ -30,6 +33,7 @@ KCOV_INSTRUMENT_extable.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
+KCSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
@@ -118,6 +122,7 @@ obj-$(CONFIG_RSEQ) += rseq.o
 
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
+KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 $(obj)/configs.o: $(obj)/config_data.gz
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..e9307a9c54e7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,6 +7,12 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
+# There are numerous races here, however, most of them due to plain accesses.
+# This would make it even harder for syzbot to find reproducers, because these
+# bugs trigger without specific input. Disable by default, but should re-enable
+# eventually.
+KCSAN_SANITIZE := n
+
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..56c1964bb3a1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -7,6 +7,14 @@ KASAN_SANITIZE_slab_common.o := n
 KASAN_SANITIZE_slab.o := n
 KASAN_SANITIZE_slub.o := n
 
+# These produce frequent data race reports: most of them are due to races on
+# the same word but accesses to different bits of that word. Re-enable KCSAN
+# for these when we have more consensus on what to do about them.
+KCSAN_SANITIZE_slab_common.o := n
+KCSAN_SANITIZE_slab.o := n
+KCSAN_SANITIZE_slub.o := n
+KCSAN_SANITIZE_page_alloc.o := n
+
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

