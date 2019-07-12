Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08502664EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 05:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfGLDZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 23:25:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:47160 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbfGLDZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:25:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 20:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="365035416"
Received: from gonegri-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.192])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2019 20:25:17 -0700
Date:   Fri, 12 Jul 2019 06:25:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Cedric Xing <cedric.xing@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        kai.svahn@intel.com, kai.huang@intel.com
Subject: Re: [RFC PATCH v2 3/3] selftests/x86: Augment SGX selftest to test
 new __vdso_sgx_enter_enclave() and its callback interface
Message-ID: <20190712032516.cpiouzzz4f4pjvqm@linux.intel.com>
References: <cover.1555965327.git.cedric.xing@intel.com>
 <20190424062623.4345-4-cedric.xing@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424062623.4345-4-cedric.xing@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:26:23PM -0700, Cedric Xing wrote:
> This patch augments SGX selftest with two new tests.
> 
> The first test exercises the newly added callback interface, by marking the
> whole enclave range as PROT_READ, then calling mprotect() upon #PFs to add
> necessary PTE permissions per PFEC (#PF Error Code) until the enclave finishes.
> This test also serves as an example to demonstrate the callback interface.
> 
> The second test single-steps through __vdso_sgx_enter_enclave() to make sure
> the call stack can be unwound at every instruction within that vDSO API. Its
> purpose is to validate the hand-crafted CFI directives in the assembly.
> 
> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
> ---
>  tools/testing/selftests/x86/sgx/Makefile   |   6 +-
>  tools/testing/selftests/x86/sgx/main.c     | 323 ++++++++++++++++++---
>  tools/testing/selftests/x86/sgx/sgx_call.S |  40 ++-
>  3 files changed, 322 insertions(+), 47 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/sgx/Makefile b/tools/testing/selftests/x86/sgx/Makefile
> index 3af15d7c8644..31f937e220c4 100644
> --- a/tools/testing/selftests/x86/sgx/Makefile
> +++ b/tools/testing/selftests/x86/sgx/Makefile
> @@ -14,16 +14,16 @@ TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
>  all_64: $(TEST_CUSTOM_PROGS)
>  
>  $(TEST_CUSTOM_PROGS): main.c sgx_call.S $(OUTPUT)/encl_piggy.o
> -	$(CC) $(HOST_CFLAGS) -o $@ $^
> +	$(CC) $(HOST_CFLAGS) -o $@ $^ -lunwind -ldl -Wl,--defsym,__image_base=0 -pie
>  
>  $(OUTPUT)/encl_piggy.o: encl_piggy.S $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss
>  	$(CC) $(HOST_CFLAGS) -I$(OUTPUT) -c $< -o $@
>  
>  $(OUTPUT)/encl.bin: $(OUTPUT)/encl.elf
> -	objcopy --remove-section=.got.plt -O binary $< $@
> +	objcopy -O binary $< $@
>  
>  $(OUTPUT)/encl.elf: encl.lds encl.c encl_bootstrap.S
> -	$(CC) $(ENCL_CFLAGS) -T $^ -o $@
> +	$(CC) $(ENCL_CFLAGS) -T $^ -o $@ -Wl,--build-id=none
>  
>  $(OUTPUT)/encl.ss: $(OUTPUT)/sgxsign signing_key.pem $(OUTPUT)/encl.bin
>  	$^ $@
> diff --git a/tools/testing/selftests/x86/sgx/main.c b/tools/testing/selftests/x86/sgx/main.c
> index e2265f841fb0..d3e53c71306d 100644
> --- a/tools/testing/selftests/x86/sgx/main.c
> +++ b/tools/testing/selftests/x86/sgx/main.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  // Copyright(c) 2016-18 Intel Corporation.
>  
> +#define _GNU_SOURCE
>  #include <elf.h>
>  #include <fcntl.h>
>  #include <stdbool.h>
> @@ -9,16 +10,31 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <errno.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
> -#include <sys/time.h>
> +#include <sys/auxv.h>
> +#include <signal.h>
> +#include <sys/ucontext.h>
> +
> +#define UNW_LOCAL_ONLY
> +#include <libunwind.h>
> +
>  #include "encl_piggy.h"
>  #include "defines.h"
>  #include "../../../../../arch/x86/kernel/cpu/sgx/arch.h"
>  #include "../../../../../arch/x86/include/uapi/asm/sgx.h"
>  
> -static const uint64_t MAGIC = 0x1122334455667788ULL;
> +#define _Q(x)	__Q(x)
> +#define __Q(x)	#x
> +#define ERRLN	"Line " _Q(__LINE__)
> +
> +#define X86_EFLAGS_TF	(1ul << 8)
> +
> +extern char __image_base[];
> +size_t eenter;
> +static size_t vdso_base;
>  
>  struct vdso_symtab {
>  	Elf64_Sym *elf_symtab;
> @@ -26,20 +42,11 @@ struct vdso_symtab {
>  	Elf64_Word *elf_hashtab;
>  };
>  
> -static void *vdso_get_base_addr(char *envp[])
> +static void vdso_init(void)
>  {
> -	Elf64_auxv_t *auxv;
> -	int i;
> -
> -	for (i = 0; envp[i]; i++);
> -	auxv = (Elf64_auxv_t *)&envp[i + 1];
> -
> -	for (i = 0; auxv[i].a_type != AT_NULL; i++) {
> -		if (auxv[i].a_type == AT_SYSINFO_EHDR)
> -			return (void *)auxv[i].a_un.a_val;
> -	}
> -
> -	return NULL;
> +	vdso_base = getauxval(AT_SYSINFO_EHDR);
> +	if (!vdso_base)
> +		exit(1);
>  }

The clean up makes sense but should be a separate patch i.e. one
logical change per patch. Right now the patch does other mods
than the ones explcitly stated in the commit message.

I'd suggest open coding vdso_init() to the call site in that
patch.

Please try to always minimize for diff's.

>  
>  static Elf64_Dyn *vdso_get_dyntab(void *addr)
> @@ -66,8 +73,9 @@ static void *vdso_get_dyn(void *addr, Elf64_Dyn *dyntab, Elf64_Sxword tag)
>  	return NULL;
>  }
>  
> -static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
> +static bool vdso_get_symtab(struct vdso_symtab *symtab)
>  {
> +	void *addr = (void *)vdso_base;
>  	Elf64_Dyn *dyntab = vdso_get_dyntab(addr);
>  
>  	symtab->elf_symtab = vdso_get_dyn(addr, dyntab, DT_SYMTAB);
> @@ -138,7 +146,7 @@ static bool encl_create(int dev_fd, unsigned long bin_size,
>  	base = mmap(NULL, secs->size, PROT_READ | PROT_WRITE | PROT_EXEC,
>  		    MAP_SHARED, dev_fd, 0);
>  	if (base == MAP_FAILED) {
> -		perror("mmap");
> +		perror(ERRLN);
>  		return false;
>  	}
>  
> @@ -224,35 +232,271 @@ static bool encl_load(struct sgx_secs *secs, unsigned long bin_size)
>  	return false;
>  }
>  
> -void sgx_call(void *rdi, void *rsi, void *tcs,
> -	      struct sgx_enclave_exception *exception,
> -	      void *eenter);
> +int sgx_call(void *rdi, void *rsi, long rdx, void *rcx, void *r8, void *r9,
> +	     void *tcs, struct sgx_enclave_exinfo *ei, void *cb);
> +
> +static void show_enclave_exinfo(const struct sgx_enclave_exinfo *exinfop,
> +				const char *header)
> +{
> +	static const char * const enclu_leaves[] = {
> +		"EREPORT",
> +		"EGETKEY",
> +		"EENTER",
> +		"ERESUME",
> +		"EEXIT"
> +	};
> +	static const char * const exception_names[] = {
> +		"#DE",
> +		"#DB",
> +		"NMI",
> +		"#BP",
> +		"#OF",
> +		"#BR",
> +		"#UD",
> +		"#NM",
> +		"#DF",
> +		"CSO",
> +		"#TS",
> +		"#NP",
> +		"#SS",
> +		"#GP",
> +		"#PF",
> +		"Unknown",
> +		"#MF",
> +		"#AC",
> +		"#MC",
> +		"#XM",
> +		"#VE",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown",
> +		"Unknown"
> +	};
> +
> +	printf("%s: leaf:%s(%d)", header,
> +		enclu_leaves[exinfop->leaf], exinfop->leaf);
> +	if (exinfop->leaf != 4)
> +		printf(" trap:%s(%d) ec:%d addr:0x%llx\n",
> +			exception_names[exinfop->trapnr], exinfop->trapnr,
> +			exinfop->error_code, exinfop->address);
> +	else
> +		printf("\n");
> +}
> +
> +static const uint64_t MAGIC = 0x1122334455667788ULL;
>  
> -int main(int argc, char *argv[], char *envp[])
> +static void test1(struct sgx_secs *secs)

test1, test2 and test3 are not too descriptive names. Every patch should
make the code base cleaner, not messier.

/Jarkko
