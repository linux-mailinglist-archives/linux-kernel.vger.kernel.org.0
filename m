Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C576F1698E5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 18:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBWR1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 12:27:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:48835 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgBWR1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:27:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 09:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="229650172"
Received: from ajbergin-mobl.ger.corp.intel.com (HELO localhost) ([10.252.23.203])
  by fmsmga007.fm.intel.com with ESMTP; 23 Feb 2020 09:27:40 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v27 11/22] selftests/x86: Recurse into subdirectories
Date:   Sun, 23 Feb 2020 19:25:48 +0200
Message-Id: <20200223172559.6912-12-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
References: <20200223172559.6912-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recurse into a list of subdirectories defined by SUBDIRS when running
x86 selftests. Override run_tests, install, emit_tests and clean
targets to implement this behaviour.

A possible alternative would be to add "x86/sgx" to TARGETS. However,
this would be problematic because detecting 64-bit build would have
to duplicated.

The implementation is derived from the makefiles of powerpc and sparc64
selftests.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 tools/testing/selftests/x86/Makefile | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d49bfec1e9a..dee6dadeba61 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -10,6 +10,8 @@ CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
+SUBDIRS := sgx
+
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			protection_keys test_vdso test_vsyscall mov_ss_trap \
@@ -59,6 +61,48 @@ endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
 all: all_64
+	@for DIR in $(SUBDIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$DIR; \
+		mkdir $$BUILD_TARGET  -p; \
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@; \
+	done
+
+DEFAULT_RUN_TESTS := $(RUN_TESTS)
+override define RUN_TESTS
+	$(DEFAULT_RUN_TESTS)
+	@for TARGET in $(SUBDIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests; \
+	done;
+endef
+
+DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
+override define INSTALL_RULE
+	$(DEFAULT_INSTALL_RULE)
+	@for TARGET in $(SUBDIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install; \
+	done;
+endef
+
+DEFAULT_EMIT_TESTS := $(EMIT_TESTS)
+override define EMIT_TESTS
+	$(DEFAULT_EMIT_TESTS)
+	@for TARGET in $(SUBDIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests; \
+	done;
+endef
+
+DEFAULT_CLEAN := $(CLEAN)
+override define CLEAN
+	$(DEFAULT_CLEAN)
+	@for TARGET in $(SUBDIRS); do \
+		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean; \
+	done;
+endef
+
 TEST_PROGS += $(BINARIES_64)
 EXTRA_CFLAGS += -DCAN_BUILD_64
 $(foreach t,$(TARGETS_C_64BIT_ALL),$(eval $(call gen-target-rule-64,$(t))))
-- 
2.20.1

