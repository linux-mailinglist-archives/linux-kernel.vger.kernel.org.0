Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD3E67B76
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfGMRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 13:12:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:18319 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbfGMRMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:12:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 10:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,487,1557212400"; 
   d="scan'208";a="341981649"
Received: from hbriegel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.48])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2019 10:12:43 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v21 24/28] selftests/x86: Add a selftest for SGX
Date:   Sat, 13 Jul 2019 20:08:00 +0300
Message-Id: <20190713170804.2340-25-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a selftest for SGX. It is a trivial test where a simple enclave
copies one 64-bit word of memory between two memory locations given to
the enclave as arguments.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 tools/testing/selftests/x86/Makefile          |  10 +
 tools/testing/selftests/x86/sgx/Makefile      |  48 ++
 tools/testing/selftests/x86/sgx/defines.h     |  39 ++
 tools/testing/selftests/x86/sgx/encl.c        |  20 +
 tools/testing/selftests/x86/sgx/encl.lds      |  33 ++
 .../selftests/x86/sgx/encl_bootstrap.S        |  94 ++++
 tools/testing/selftests/x86/sgx/encl_piggy.S  |  18 +
 tools/testing/selftests/x86/sgx/encl_piggy.h  |  14 +
 tools/testing/selftests/x86/sgx/main.c        | 301 +++++++++++
 tools/testing/selftests/x86/sgx/sgx_call.S    |  49 ++
 tools/testing/selftests/x86/sgx/sgxsign.c     | 508 ++++++++++++++++++
 .../testing/selftests/x86/sgx/signing_key.pem |  39 ++
 12 files changed, 1173 insertions(+)
 create mode 100644 tools/testing/selftests/x86/sgx/Makefile
 create mode 100644 tools/testing/selftests/x86/sgx/defines.h
 create mode 100644 tools/testing/selftests/x86/sgx/encl.c
 create mode 100644 tools/testing/selftests/x86/sgx/encl.lds
 create mode 100644 tools/testing/selftests/x86/sgx/encl_bootstrap.S
 create mode 100644 tools/testing/selftests/x86/sgx/encl_piggy.S
 create mode 100644 tools/testing/selftests/x86/sgx/encl_piggy.h
 create mode 100644 tools/testing/selftests/x86/sgx/main.c
 create mode 100644 tools/testing/selftests/x86/sgx/sgx_call.S
 create mode 100644 tools/testing/selftests/x86/sgx/sgxsign.c
 create mode 100644 tools/testing/selftests/x86/sgx/signing_key.pem

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index fa07d526fe39..a1831406fd01 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+SUBDIRS_64 := sgx
+
 all:
 
 include ../lib.mk
@@ -68,6 +71,13 @@ all_32: $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
+all_64: $(SUBDIRS_64)
+	@for DIR in $(SUBDIRS_64); do			\
+		BUILD_TARGET=$(OUTPUT)/$$DIR;		\
+		mkdir $$BUILD_TARGET  -p;		\
+		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;	\
+	done
+
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c
diff --git a/tools/testing/selftests/x86/sgx/Makefile b/tools/testing/selftests/x86/sgx/Makefile
new file mode 100644
index 000000000000..10136b73096b
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/Makefile
@@ -0,0 +1,48 @@
+top_srcdir = ../../../../..
+
+include ../../lib.mk
+
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
+ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+	       -fno-stack-protector -mrdrnd $(INCLUDES)
+
+TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
+all_64: $(TEST_CUSTOM_PROGS)
+
+$(TEST_CUSTOM_PROGS): $(OUTPUT)/main.o $(OUTPUT)/sgx_call.o \
+		      $(OUTPUT)/encl_piggy.o
+	$(CC) $(HOST_CFLAGS) -o $@ $^
+
+$(OUTPUT)/main.o: main.c
+	$(CC) $(HOST_CFLAGS) -c $< -o $@
+
+$(OUTPUT)/sgx_call.o: sgx_call.S
+	$(CC) $(HOST_CFLAGS) -c $< -o $@
+
+$(OUTPUT)/encl_piggy.o: $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss
+	$(CC) $(HOST_CFLAGS) -c encl_piggy.S -o $@
+
+$(OUTPUT)/encl.bin: $(OUTPUT)/encl.elf $(OUTPUT)/sgxsign
+	objcopy --remove-section=.got.plt -O binary $< $@
+
+$(OUTPUT)/encl.elf: $(OUTPUT)/encl.o $(OUTPUT)/encl_bootstrap.o
+	$(CC) $(ENCL_CFLAGS) -T encl.lds -o $@ $^
+
+$(OUTPUT)/encl.o: encl.c
+	$(CC) $(ENCL_CFLAGS) -c $< -o $@
+
+$(OUTPUT)/encl_bootstrap.o: encl_bootstrap.S
+	$(CC) $(ENCL_CFLAGS) -c $< -o $@
+
+$(OUTPUT)/encl.ss: $(OUTPUT)/encl.bin  $(OUTPUT)/sgxsign
+	$(OUTPUT)/sgxsign signing_key.pem $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss
+
+$(OUTPUT)/sgxsign: sgxsign.c
+	$(CC) -o $@ $< -lcrypto
+
+EXTRA_CLEAN := $(OUTPUT)/sgx-selftest $(OUTPUT)/sgx-selftest.o \
+	       $(OUTPUT)/sgx_call.o $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss \
+	       $(OUTPUT)/encl.elf $(OUTPUT)/encl.o $(OUTPUT)/encl_bootstrap.o \
+	       $(OUTPUT)/sgxsign
+
+.PHONY: clean
diff --git a/tools/testing/selftests/x86/sgx/defines.h b/tools/testing/selftests/x86/sgx/defines.h
new file mode 100644
index 000000000000..3ff73a9d9b93
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/defines.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2016-19 Intel Corporation.
+ */
+
+#ifndef TYPES_H
+#define TYPES_H
+
+#include <stdint.h>
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+
+#define __aligned(x) __attribute__((__aligned__(x)))
+#define __packed __attribute__((packed))
+
+/* Derived from asm-generic/bitsperlong.h. */
+#if __x86_64__
+#define BITS_PER_LONG 64
+#else
+#define BITS_PER_LONG 32
+#endif
+#define BITS_PER_LONG_LONG 64
+
+/* Taken from linux/bits.h. */
+#define BIT(nr)	(1UL << (nr))
+#define BIT_ULL(nr) (1ULL << (nr))
+#define GENMASK(h, l) \
+	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK_ULL(h, l) \
+	(((~0ULL) - (1ULL << (l)) + 1) & \
+	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+
+#include "../../../../../arch/x86/kernel/cpu/sgx/arch.h"
+#include "../../../../../arch/x86/include/uapi/asm/sgx.h"
+
+#endif /* TYPES_H */
diff --git a/tools/testing/selftests/x86/sgx/encl.c b/tools/testing/selftests/x86/sgx/encl.c
new file mode 100644
index 000000000000..ede915399742
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/encl.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-18 Intel Corporation.
+
+#include <stddef.h>
+#include "defines.h"
+
+static void *memcpy(void *dest, const void *src, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = ((char *)src)[i];
+
+	return dest;
+}
+
+void encl_body(void *rdi, void *rsi)
+{
+	memcpy(rsi, rdi, 8);
+}
diff --git a/tools/testing/selftests/x86/sgx/encl.lds b/tools/testing/selftests/x86/sgx/encl.lds
new file mode 100644
index 000000000000..2ee01ac3ec79
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/encl.lds
@@ -0,0 +1,33 @@
+OUTPUT_FORMAT(elf64-x86-64)
+
+SECTIONS
+{
+	. = 0;
+	.tcs : {
+		*(.tcs*)
+	}
+
+	. = ALIGN(4096);
+	.text : {
+		*(.text*)
+		*(.rodata*)
+	}
+
+	. = ALIGN(4096);
+	.data : {
+		*(.data*)
+	}
+
+	/DISCARD/ : {
+		*(.data*)
+		*(.comment*)
+		*(.note*)
+		*(.debug*)
+		*(.eh_frame*)
+	}
+}
+
+ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in enclaves")
+ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in enclaves")
+ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in enclaves")
+ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in enclaves")
diff --git a/tools/testing/selftests/x86/sgx/encl_bootstrap.S b/tools/testing/selftests/x86/sgx/encl_bootstrap.S
new file mode 100644
index 000000000000..d07f970ccdf9
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/encl_bootstrap.S
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2016-18 Intel Corporation.
+ */
+
+	.macro ENCLU
+	.byte 0x0f, 0x01, 0xd7
+	.endm
+
+	.section ".tcs", "a"
+	.balign	4096
+
+	.fill	1, 8, 0			# STATE (set by CPU)
+	.fill	1, 8, 0			# FLAGS
+	.quad	encl_ssa		# OSSA
+	.fill	1, 4, 0			# CSSA (set by CPU)
+	.fill	1, 4, 1			# NSSA
+	.quad	encl_entry		# OENTRY
+	.fill	1, 8, 0			# AEP (set by EENTER and ERESUME)
+	.fill	1, 8, 0			# OFSBASE
+	.fill	1, 8, 0			# OGSBASE
+	.fill	1, 4, 0xFFFFFFFF 	# FSLIMIT
+	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
+	.fill	4024, 1, 0		# Reserved
+
+	.text
+
+encl_entry:
+	# RBX contains the base address for TCS, which is also the first address
+	# inside the enclave. By adding the value of le_stack_end to it, we get
+	# the absolute address for the stack.
+	lea	(encl_stack)(%rbx), %rax
+	xchg	%rsp, %rax
+	push	%rax
+
+	push	%rcx # push the address after EENTER
+	push	%rbx # push the enclave base address
+
+	call	encl_body
+
+	pop	%rbx # pop the enclave base address
+
+	# Restore XSAVE registers to a synthetic state.
+	mov     $0xFFFFFFFF, %rax
+	mov     $0xFFFFFFFF, %rdx
+	lea	(xsave_area)(%rbx), %rdi
+	fxrstor	(%rdi)
+
+	# Clear GPRs.
+	xor     %rcx, %rcx
+	xor     %rdx, %rdx
+	xor     %rdi, %rdi
+	xor     %rsi, %rsi
+	xor     %r8, %r8
+	xor     %r9, %r9
+	xor     %r10, %r10
+	xor     %r11, %r11
+	xor     %r12, %r12
+	xor     %r13, %r13
+	xor     %r14, %r14
+	xor     %r15, %r15
+
+	# Reset status flags.
+	add     %rdx, %rdx # OF = SF = AF = CF = 0; ZF = PF = 1
+
+	# Prepare EEXIT target by popping the address of the instruction after
+	# EENTER to RBX.
+	pop	%rbx
+
+	# Restore the caller stack.
+	pop	%rax
+	mov	%rax, %rsp
+
+	# EEXIT
+	mov	$4, %rax
+	enclu
+
+	.section ".data", "aw"
+
+encl_ssa:
+	.space 4096
+
+xsave_area:
+	.fill	1, 4, 0x037F		# FCW
+	.fill	5, 4, 0
+	.fill	1, 4, 0x1F80		# MXCSR
+	.fill	1, 4, 0xFFFF		# MXCSR_MASK
+	.fill	123, 4, 0
+	.fill	1, 4, 0x80000000	# XCOMP_BV[63] = 1, compaction mode
+	.fill	12, 4, 0
+
+	.balign 4096
+	.space 8192
+encl_stack:
diff --git a/tools/testing/selftests/x86/sgx/encl_piggy.S b/tools/testing/selftests/x86/sgx/encl_piggy.S
new file mode 100644
index 000000000000..542001658afb
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/encl_piggy.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2016-18 Intel Corporation.
+ */
+
+	.section ".rodata", "a"
+
+encl_bin:
+	.globl encl_bin
+	.incbin	"encl.bin"
+encl_bin_end:
+	.globl encl_bin_end
+
+encl_ss:
+	.globl encl_ss
+	.incbin	"encl.ss"
+encl_ss_end:
+	.globl encl_ss_end
diff --git a/tools/testing/selftests/x86/sgx/encl_piggy.h b/tools/testing/selftests/x86/sgx/encl_piggy.h
new file mode 100644
index 000000000000..ee8224f8cc8d
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/encl_piggy.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2016-18 Intel Corporation.
+ */
+
+#ifndef ENCL_PIGGY_H
+#define ENCL_PIGGY_H
+
+extern unsigned char encl_bin[];
+extern unsigned char encl_bin_end[];
+extern unsigned char encl_ss[];
+extern unsigned char encl_ss_end[];
+
+#endif /* ENCL_PIGGY_H */
diff --git a/tools/testing/selftests/x86/sgx/main.c b/tools/testing/selftests/x86/sgx/main.c
new file mode 100644
index 000000000000..effcdb3380ad
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/main.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-18 Intel Corporation.
+
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include "encl_piggy.h"
+#include "defines.h"
+#include "../../../../../arch/x86/kernel/cpu/sgx/arch.h"
+#include "../../../../../arch/x86/include/uapi/asm/sgx.h"
+
+#define PAGE_SIZE  4096
+
+static const uint64_t MAGIC = 0x1122334455667788ULL;
+void *eenter;
+
+struct vdso_symtab {
+	Elf64_Sym *elf_symtab;
+	const char *elf_symstrtab;
+	Elf64_Word *elf_hashtab;
+};
+
+static void *vdso_get_base_addr(char *envp[])
+{
+	Elf64_auxv_t *auxv;
+	int i;
+
+	for (i = 0; envp[i]; i++)
+		;
+
+	auxv = (Elf64_auxv_t *)&envp[i + 1];
+
+	for (i = 0; auxv[i].a_type != AT_NULL; i++) {
+		if (auxv[i].a_type == AT_SYSINFO_EHDR)
+			return (void *)auxv[i].a_un.a_val;
+	}
+
+	return NULL;
+}
+
+static Elf64_Dyn *vdso_get_dyntab(void *addr)
+{
+	Elf64_Ehdr *ehdr = addr;
+	Elf64_Phdr *phdrtab = addr + ehdr->e_phoff;
+	int i;
+
+	for (i = 0; i < ehdr->e_phnum; i++)
+		if (phdrtab[i].p_type == PT_DYNAMIC)
+			return addr + phdrtab[i].p_offset;
+
+	return NULL;
+}
+
+static void *vdso_get_dyn(void *addr, Elf64_Dyn *dyntab, Elf64_Sxword tag)
+{
+	int i;
+
+	for (i = 0; dyntab[i].d_tag != DT_NULL; i++)
+		if (dyntab[i].d_tag == tag)
+			return addr + dyntab[i].d_un.d_ptr;
+
+	return NULL;
+}
+
+static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
+{
+	Elf64_Dyn *dyntab = vdso_get_dyntab(addr);
+
+	symtab->elf_symtab = vdso_get_dyn(addr, dyntab, DT_SYMTAB);
+	if (!symtab->elf_symtab)
+		return false;
+
+	symtab->elf_symstrtab = vdso_get_dyn(addr, dyntab, DT_STRTAB);
+	if (!symtab->elf_symstrtab)
+		return false;
+
+	symtab->elf_hashtab = vdso_get_dyn(addr, dyntab, DT_HASH);
+	if (!symtab->elf_hashtab)
+		return false;
+
+	return true;
+}
+
+static unsigned long elf_sym_hash(const char *name)
+{
+	unsigned long h = 0, high;
+
+	while (*name) {
+		h = (h << 4) + *name++;
+		high = h & 0xf0000000;
+
+		if (high)
+			h ^= high >> 24;
+
+		h &= ~high;
+	}
+
+	return h;
+}
+
+static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
+{
+	Elf64_Word bucketnum = symtab->elf_hashtab[0];
+	Elf64_Word *buckettab = &symtab->elf_hashtab[2];
+	Elf64_Word *chaintab = &symtab->elf_hashtab[2 + bucketnum];
+	Elf64_Sym *sym;
+	Elf64_Word i;
+
+	for (i = buckettab[elf_sym_hash(name) % bucketnum]; i != STN_UNDEF;
+	     i = chaintab[i]) {
+		sym = &symtab->elf_symtab[i];
+		if (!strcmp(name, &symtab->elf_symstrtab[sym->st_name]))
+			return sym;
+	}
+
+	return NULL;
+}
+
+static bool encl_create(int dev_fd, unsigned long bin_size,
+			struct sgx_secs *secs)
+{
+	struct sgx_enclave_create ioc;
+	void *base;
+	int rc;
+
+	memset(secs, 0, sizeof(*secs));
+	secs->ssa_frame_size = 1;
+	secs->attributes = SGX_ATTR_MODE64BIT;
+	secs->xfrm = 3;
+
+	for (secs->size = 4096; secs->size < bin_size; )
+		secs->size <<= 1;
+
+	base = mmap(NULL, secs->size, PROT_NONE, MAP_SHARED, dev_fd, 0);
+	if (base == MAP_FAILED) {
+		perror("mmap");
+		return false;
+	}
+
+	secs->base = (uint64_t)base;
+
+	ioc.src = (unsigned long)secs;
+	rc = ioctl(dev_fd, SGX_IOC_ENCLAVE_CREATE, &ioc);
+	if (rc) {
+		fprintf(stderr, "ECREATE failed rc=%d, err=%d.\n", rc, errno);
+		munmap(base, secs->size);
+		return false;
+	}
+
+	return true;
+}
+
+static bool encl_add_page(int dev_fd, unsigned long addr, void *data,
+			  uint64_t flags)
+{
+	struct sgx_enclave_add_page ioc;
+	struct sgx_secinfo secinfo;
+	int rc;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+	secinfo.flags = flags;
+
+	ioc.secinfo = (unsigned long)&secinfo;
+	ioc.mrmask = 0xFFFF;
+	ioc.addr = addr;
+	ioc.src = (uint64_t)data;
+	memset(ioc.reserved, 0, sizeof(ioc.reserved));
+
+	rc = ioctl(dev_fd, SGX_IOC_ENCLAVE_ADD_PAGE, &ioc);
+	if (rc) {
+		fprintf(stderr, "EADD failed rc=%d.\n", rc);
+		return false;
+	}
+
+	return true;
+}
+
+static bool encl_load(struct sgx_secs *secs, unsigned long bin_size)
+{
+	struct sgx_enclave_init ioc;
+	uint64_t offset;
+	uint64_t flags;
+	void *addr;
+	int dev_fd;
+	int rc;
+
+	dev_fd = open("/dev/sgx/enclave", O_RDWR);
+	if (dev_fd < 0) {
+		fprintf(stderr, "Unable to open /dev/sgx\n");
+		return false;
+	}
+
+	if (!encl_create(dev_fd, bin_size, secs))
+		goto out_dev_fd;
+
+	for (offset = 0; offset < bin_size; offset += 0x1000) {
+		if (!offset)
+			flags = SGX_SECINFO_TCS;
+		else
+			flags = SGX_SECINFO_REG | SGX_SECINFO_R |
+				SGX_SECINFO_W | SGX_SECINFO_X;
+
+		if (!encl_add_page(dev_fd, secs->base + offset,
+				   encl_bin + offset, flags))
+			goto out_map;
+	}
+
+	ioc.sigstruct = (uint64_t)&encl_ss;
+	rc = ioctl(dev_fd, SGX_IOC_ENCLAVE_INIT, &ioc);
+	if (rc) {
+		printf("EINIT failed rc=%d\n", rc);
+		goto out_map;
+	}
+
+	addr = mmap((void *)secs->base, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_SHARED | MAP_FIXED, dev_fd, 0);
+	if (addr == MAP_FAILED) {
+		fprintf(stderr, "mmap() failed on TCS, errno=%d.\n", errno);
+		return false;
+	}
+
+	addr = mmap((void *)(secs->base + PAGE_SIZE), bin_size - PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_SHARED | MAP_FIXED, dev_fd, 0);
+	if (addr == MAP_FAILED) {
+		fprintf(stderr, "mmap() failed, errno=%d.\n", errno);
+		return false;
+	}
+
+
+	close(dev_fd);
+	return true;
+out_map:
+	munmap((void *)secs->base, secs->size);
+out_dev_fd:
+	close(dev_fd);
+	return false;
+}
+
+int sgx_call(void *rdi, void *rsi, long rdx, void *rcx, void *r8, void *r9,
+	     void *tcs, struct sgx_enclave_exception *ei, void *cb);
+
+int main(int argc, char *argv[], char *envp[])
+{
+	unsigned long bin_size = encl_bin_end - encl_bin;
+	unsigned long ss_size = encl_ss_end - encl_ss;
+	struct sgx_enclave_exception exception;
+	Elf64_Sym *eenter_sym;
+	struct vdso_symtab symtab;
+	struct sgx_secs secs;
+	uint64_t result = 0;
+	void *addr;
+
+	memset(&exception, 0, sizeof(exception));
+
+	addr = vdso_get_base_addr(envp);
+	if (!addr)
+		exit(1);
+
+	if (!vdso_get_symtab(addr, &symtab))
+		exit(1);
+
+	eenter_sym = vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave");
+	if (!eenter_sym)
+		exit(1);
+	eenter = addr + eenter_sym->st_value;
+
+	printf("Binary size %lu (0x%lx), SIGSTRUCT size %lu\n", bin_size,
+	       bin_size, ss_size);
+	if (ss_size != sizeof(struct sgx_sigstruct)) {
+		fprintf(stderr, "The size of SIGSTRUCT should be %lu\n",
+			sizeof(struct sgx_sigstruct));
+		exit(1);
+	}
+
+	printf("Loading the enclave.\n");
+	if (!encl_load(&secs, bin_size))
+		exit(1);
+
+	printf("Input: 0x%lx\n", MAGIC);
+	sgx_call((void *)&MAGIC, &result, 0, NULL, NULL, NULL,
+		 (void *)secs.base, &exception, NULL);
+
+	if (result != MAGIC) {
+		fprintf(stderr, "0x%lx != 0x%lx\n", result, MAGIC);
+		exit(1);
+	}
+
+	printf("Output: 0x%lx\n", result);
+	exit(0);
+}
diff --git a/tools/testing/selftests/x86/sgx/sgx_call.S b/tools/testing/selftests/x86/sgx/sgx_call.S
new file mode 100644
index 000000000000..ca2c0c947758
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/sgx_call.S
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/**
+* Copyright(c) 2016-18 Intel Corporation.
+*/
+
+	.text
+
+	.global sgx_call
+sgx_call:
+	.cfi_startproc
+	push	%r15
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r15, 0
+	push	%r14
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r14, 0
+	push	%r13
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r13, 0
+	push	%r12
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%r12, 0
+	push	%rbx
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%rbx, 0
+	push	$0
+	.cfi_adjust_cfa_offset	8
+	push	0x48(%rsp)
+	.cfi_adjust_cfa_offset	8
+	push	0x48(%rsp)
+	.cfi_adjust_cfa_offset	8
+	push	0x48(%rsp)
+	.cfi_adjust_cfa_offset	8
+	mov	$2, %eax
+	call	*eenter(%rip)
+	add	$0x20, %rsp
+	.cfi_adjust_cfa_offset	-0x20
+	pop	%rbx
+	.cfi_adjust_cfa_offset	-8
+	pop	%r12
+	.cfi_adjust_cfa_offset	-8
+	pop	%r13
+	.cfi_adjust_cfa_offset	-8
+	pop	%r14
+	.cfi_adjust_cfa_offset	-8
+	pop	%r15
+	.cfi_adjust_cfa_offset	-8
+	ret
+	.cfi_endproc
diff --git a/tools/testing/selftests/x86/sgx/sgxsign.c b/tools/testing/selftests/x86/sgx/sgxsign.c
new file mode 100644
index 000000000000..0b89823fc703
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/sgxsign.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-18 Intel Corporation.
+
+#define _GNU_SOURCE
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <openssl/err.h>
+#include <openssl/pem.h>
+#include "defines.h"
+
+struct sgx_sigstruct_payload {
+	struct sgx_sigstruct_header header;
+	struct sgx_sigstruct_body body;
+};
+
+static const char *sign_key_pass;
+
+static bool check_crypto_errors(void)
+{
+	int err;
+	bool had_errors = false;
+	const char *filename;
+	int line;
+	char str[256];
+
+	for ( ; ; ) {
+		if (ERR_peek_error() == 0)
+			break;
+
+		had_errors = true;
+		err = ERR_get_error_line(&filename, &line);
+		ERR_error_string_n(err, str, sizeof(str));
+		fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, line);
+	}
+
+	return had_errors;
+}
+
+static void exit_usage(const char *program)
+{
+	fprintf(stderr,
+		"Usage: %s/sign-le <key> <enclave> <sigstruct>\n", program);
+	exit(1);
+}
+
+static int pem_passwd_cb(char *buf, int size, int rwflag, void *u)
+{
+	if (!sign_key_pass)
+		return -1;
+
+	strncpy(buf, sign_key_pass, size);
+	/* no retry */
+	sign_key_pass = NULL;
+
+	return strlen(buf) >= size ? size - 1 : strlen(buf);
+}
+
+static inline const BIGNUM *get_modulus(RSA *key)
+{
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
+	return key->n;
+#else
+	const BIGNUM *n;
+
+	RSA_get0_key(key, &n, NULL, NULL);
+	return n;
+#endif
+}
+
+static RSA *load_sign_key(const char *path)
+{
+	FILE *f;
+	RSA *key;
+
+	f = fopen(path, "rb");
+	if (!f) {
+		fprintf(stderr, "Unable to open %s\n", path);
+		return NULL;
+	}
+	key = RSA_new();
+	if (!PEM_read_RSAPrivateKey(f, &key, pem_passwd_cb, NULL))
+		return NULL;
+	fclose(f);
+
+	if (BN_num_bytes(get_modulus(key)) != SGX_MODULUS_SIZE) {
+		fprintf(stderr, "Invalid key size %d\n",
+			BN_num_bytes(get_modulus(key)));
+		RSA_free(key);
+		return NULL;
+	}
+
+	return key;
+}
+
+static void reverse_bytes(void *data, int length)
+{
+	int i = 0;
+	int j = length - 1;
+	uint8_t temp;
+	uint8_t *ptr = data;
+
+	while (i < j) {
+		temp = ptr[i];
+		ptr[i] = ptr[j];
+		ptr[j] = temp;
+		i++;
+		j--;
+	}
+}
+
+enum mrtags {
+	MRECREATE = 0x0045544145524345,
+	MREADD = 0x0000000044444145,
+	MREEXTEND = 0x00444E4554584545,
+};
+
+static bool mrenclave_update(EVP_MD_CTX *ctx, const void *data)
+{
+	if (!EVP_DigestUpdate(ctx, data, 64)) {
+		fprintf(stderr, "digest update failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool mrenclave_commit(EVP_MD_CTX *ctx, uint8_t *mrenclave)
+{
+	unsigned int size;
+
+	if (!EVP_DigestFinal_ex(ctx, (unsigned char *)mrenclave, &size)) {
+		fprintf(stderr, "digest commit failed\n");
+		return false;
+	}
+
+	if (size != 32) {
+		fprintf(stderr, "invalid digest size = %u\n", size);
+		return false;
+	}
+
+	return true;
+}
+
+struct mrecreate {
+	uint64_t tag;
+	uint32_t ssaframesize;
+	uint64_t size;
+	uint8_t reserved[44];
+} __attribute__((__packed__));
+
+
+static bool mrenclave_ecreate(EVP_MD_CTX *ctx, uint64_t blob_size)
+{
+	struct mrecreate mrecreate;
+	uint64_t encl_size;
+
+	for (encl_size = 0x1000; encl_size < blob_size; )
+		encl_size <<= 1;
+
+	memset(&mrecreate, 0, sizeof(mrecreate));
+	mrecreate.tag = MRECREATE;
+	mrecreate.ssaframesize = 1;
+	mrecreate.size = encl_size;
+
+	if (!EVP_DigestInit_ex(ctx, EVP_sha256(), NULL))
+		return false;
+
+	return mrenclave_update(ctx, &mrecreate);
+}
+
+struct mreadd {
+	uint64_t tag;
+	uint64_t offset;
+	uint64_t flags; /* SECINFO flags */
+	uint8_t reserved[40];
+} __attribute__((__packed__));
+
+static bool mrenclave_eadd(EVP_MD_CTX *ctx, uint64_t offset, uint64_t flags)
+{
+	struct mreadd mreadd;
+
+	memset(&mreadd, 0, sizeof(mreadd));
+	mreadd.tag = MREADD;
+	mreadd.offset = offset;
+	mreadd.flags = flags;
+
+	return mrenclave_update(ctx, &mreadd);
+}
+
+struct mreextend {
+	uint64_t tag;
+	uint64_t offset;
+	uint8_t reserved[48];
+} __attribute__((__packed__));
+
+static bool mrenclave_eextend(EVP_MD_CTX *ctx, uint64_t offset, uint8_t *data)
+{
+	struct mreextend mreextend;
+	int i;
+
+	for (i = 0; i < 0x1000; i += 0x100) {
+		memset(&mreextend, 0, sizeof(mreextend));
+		mreextend.tag = MREEXTEND;
+		mreextend.offset = offset + i;
+
+		if (!mrenclave_update(ctx, &mreextend))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0x00]))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0x40]))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0x80]))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0xC0]))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * measure_encl - measure enclave
+ * @path: path to the enclave
+ * @mrenclave: measurement
+ *
+ * Calculates MRENCLAVE. Assumes that the very first page is a TCS page and
+ * following pages are regular pages. Does not measure the contents of the
+ * enclave as the signing tool is used at the moment only for the launch
+ * enclave, which is pass-through (everything gets a token).
+ */
+static bool measure_encl(const char *path, uint8_t *mrenclave)
+{
+	FILE *file;
+	struct stat sb;
+	EVP_MD_CTX *ctx;
+	uint64_t flags;
+	uint64_t offset;
+	uint8_t data[0x1000];
+	int rc;
+
+	ctx = EVP_MD_CTX_create();
+	if (!ctx)
+		return false;
+
+	file = fopen(path, "rb");
+	if (!file) {
+		perror("fopen");
+		EVP_MD_CTX_destroy(ctx);
+		return false;
+	}
+
+	rc = stat(path, &sb);
+	if (rc) {
+		perror("stat");
+		goto out;
+	}
+
+	if (!sb.st_size || sb.st_size & 0xfff) {
+		fprintf(stderr, "Invalid blob size %lu\n", sb.st_size);
+		goto out;
+	}
+
+	if (!mrenclave_ecreate(ctx, sb.st_size))
+		goto out;
+
+	for (offset = 0; offset < sb.st_size; offset += 0x1000) {
+		if (!offset)
+			flags = SGX_SECINFO_TCS;
+		else
+			flags = SGX_SECINFO_REG | SGX_SECINFO_R |
+				SGX_SECINFO_W | SGX_SECINFO_X;
+
+		if (!mrenclave_eadd(ctx, offset, flags))
+			goto out;
+
+		rc = fread(data, 1, 0x1000, file);
+		if (!rc)
+			break;
+		if (rc < 0x1000)
+			goto out;
+
+		if (!mrenclave_eextend(ctx, offset, data))
+			goto out;
+	}
+
+	if (!mrenclave_commit(ctx, mrenclave))
+		goto out;
+
+	fclose(file);
+	EVP_MD_CTX_destroy(ctx);
+	return true;
+out:
+	fclose(file);
+	EVP_MD_CTX_destroy(ctx);
+	return false;
+}
+
+/**
+ * sign_encl - sign enclave
+ * @sigstruct: pointer to SIGSTRUCT
+ * @key: 3072-bit RSA key
+ * @signature: byte array for the signature
+ *
+ * Calculates EMSA-PKCSv1.5 signature for the given SIGSTRUCT. The result is
+ * stored in big-endian format so that it can be further passed to OpenSSL
+ * libcrypto functions.
+ */
+static bool sign_encl(const struct sgx_sigstruct *sigstruct, RSA *key,
+		      uint8_t *signature)
+{
+	struct sgx_sigstruct_payload payload;
+	unsigned int siglen;
+	uint8_t digest[SHA256_DIGEST_LENGTH];
+	bool ret;
+
+	memcpy(&payload.header, &sigstruct->header, sizeof(sigstruct->header));
+	memcpy(&payload.body, &sigstruct->body, sizeof(sigstruct->body));
+
+	SHA256((unsigned char *)&payload, sizeof(payload), digest);
+
+	ret = RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH, signature,
+		       &siglen, key);
+
+	return ret;
+}
+
+struct q1q2_ctx {
+	BN_CTX *bn_ctx;
+	BIGNUM *m;
+	BIGNUM *s;
+	BIGNUM *q1;
+	BIGNUM *qr;
+	BIGNUM *q2;
+};
+
+static void free_q1q2_ctx(struct q1q2_ctx *ctx)
+{
+	BN_CTX_free(ctx->bn_ctx);
+	BN_free(ctx->m);
+	BN_free(ctx->s);
+	BN_free(ctx->q1);
+	BN_free(ctx->qr);
+	BN_free(ctx->q2);
+}
+
+static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
+			   struct q1q2_ctx *ctx)
+{
+	ctx->bn_ctx = BN_CTX_new();
+	ctx->s = BN_bin2bn(s, SGX_MODULUS_SIZE, NULL);
+	ctx->m = BN_bin2bn(m, SGX_MODULUS_SIZE, NULL);
+	ctx->q1 = BN_new();
+	ctx->qr = BN_new();
+	ctx->q2 = BN_new();
+
+	if (!ctx->bn_ctx || !ctx->s || !ctx->m || !ctx->q1 || !ctx->qr ||
+	    !ctx->q2) {
+		free_q1q2_ctx(ctx);
+		return false;
+	}
+
+	return true;
+}
+
+static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
+		      uint8_t *q2)
+{
+	struct q1q2_ctx ctx;
+
+	if (!alloc_q1q2_ctx(s, m, &ctx)) {
+		fprintf(stderr, "Not enough memory for Q1Q2 calculation\n");
+		return false;
+	}
+
+	if (!BN_mul(ctx.q1, ctx.s, ctx.s, ctx.bn_ctx))
+		goto out;
+
+	if (!BN_div(ctx.q1, ctx.qr, ctx.q1, ctx.m, ctx.bn_ctx))
+		goto out;
+
+	if (BN_num_bytes(ctx.q1) > SGX_MODULUS_SIZE) {
+		fprintf(stderr, "Too large Q1 %d bytes\n",
+			BN_num_bytes(ctx.q1));
+		goto out;
+	}
+
+	if (!BN_mul(ctx.q2, ctx.s, ctx.qr, ctx.bn_ctx))
+		goto out;
+
+	if (!BN_div(ctx.q2, NULL, ctx.q2, ctx.m, ctx.bn_ctx))
+		goto out;
+
+	if (BN_num_bytes(ctx.q2) > SGX_MODULUS_SIZE) {
+		fprintf(stderr, "Too large Q2 %d bytes\n",
+			BN_num_bytes(ctx.q2));
+		goto out;
+	}
+
+	BN_bn2bin(ctx.q1, q1);
+	BN_bn2bin(ctx.q2, q2);
+
+	free_q1q2_ctx(&ctx);
+	return true;
+out:
+	free_q1q2_ctx(&ctx);
+	return false;
+}
+
+static bool save_sigstruct(const struct sgx_sigstruct *sigstruct,
+			   const char *path)
+{
+	FILE *f = fopen(path, "wb");
+
+	if (!f) {
+		fprintf(stderr, "Unable to open %s\n", path);
+		return false;
+	}
+
+	fwrite(sigstruct, sizeof(*sigstruct), 1, f);
+	fclose(f);
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	uint64_t header1[2] = {0x000000E100000006, 0x0000000000010000};
+	uint64_t header2[2] = {0x0000006000000101, 0x0000000100000060};
+	struct sgx_sigstruct ss;
+	const char *program;
+	int opt;
+	RSA *sign_key;
+
+	memset(&ss, 0, sizeof(ss));
+	ss.header.header1[0] = header1[0];
+	ss.header.header1[1] = header1[1];
+	ss.header.header2[0] = header2[0];
+	ss.header.header2[1] = header2[1];
+	ss.exponent = 3;
+
+#ifndef CONFIG_EINITTOKENKEY
+	ss.body.attributes = SGX_ATTR_MODE64BIT;
+#else
+	ss.body.attributes = SGX_ATTR_MODE64BIT | SGX_ATTR_EINITTOKENKEY;
+#endif
+	ss.body.xfrm = 3,
+
+	sign_key_pass = getenv("KBUILD_SGX_SIGN_PIN");
+	program = argv[0];
+
+	do {
+		opt = getopt(argc, argv, "");
+		switch (opt) {
+		case -1:
+			break;
+		default:
+			exit_usage(program);
+		}
+	} while (opt != -1);
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 3)
+		exit_usage(program);
+
+	/* sanity check only */
+	if (check_crypto_errors())
+		exit(1);
+
+	sign_key = load_sign_key(argv[0]);
+	if (!sign_key)
+		goto out;
+
+	BN_bn2bin(get_modulus(sign_key), ss.modulus);
+
+	if (!measure_encl(argv[1], ss.body.mrenclave))
+		goto out;
+
+	if (!sign_encl(&ss, sign_key, ss.signature))
+		goto out;
+
+	if (!calc_q1q2(ss.signature, ss.modulus, ss.q1, ss.q2))
+		goto out;
+
+	/* convert to little endian */
+	reverse_bytes(ss.signature, SGX_MODULUS_SIZE);
+	reverse_bytes(ss.modulus, SGX_MODULUS_SIZE);
+	reverse_bytes(ss.q1, SGX_MODULUS_SIZE);
+	reverse_bytes(ss.q2, SGX_MODULUS_SIZE);
+
+	if (!save_sigstruct(&ss, argv[2]))
+		goto out;
+	exit(0);
+out:
+	check_crypto_errors();
+	exit(1);
+}
diff --git a/tools/testing/selftests/x86/sgx/signing_key.pem b/tools/testing/selftests/x86/sgx/signing_key.pem
new file mode 100644
index 000000000000..d76f21f19187
--- /dev/null
+++ b/tools/testing/selftests/x86/sgx/signing_key.pem
@@ -0,0 +1,39 @@
+-----BEGIN RSA PRIVATE KEY-----
+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
+-----END RSA PRIVATE KEY-----
-- 
2.20.1

