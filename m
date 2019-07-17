Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2F6C32E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfGQWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 18:37:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:4184 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfGQWhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:37:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 15:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559545200"; 
   d="scan'208";a="366717388"
Received: from bxing-desk.ccr.corp.intel.com (HELO [134.134.148.187]) ([134.134.148.187])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2019 15:37:02 -0700
Subject: Re: [PATCH v21 24/28] selftests/x86: Add a selftest for SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com
References: <20190713170804.2340-1-jarkko.sakkinen@linux.intel.com>
 <20190713170804.2340-25-jarkko.sakkinen@linux.intel.com>
From:   "Xing, Cedric" <cedric.xing@intel.com>
Message-ID: <e7b51875-c190-bab6-28ec-0eaa6caf2955@intel.com>
Date:   Wed, 17 Jul 2019 15:37:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190713170804.2340-25-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/2019 10:08 AM, Jarkko Sakkinen wrote:
> Add a selftest for SGX. It is a trivial test where a simple enclave
> copies one 64-bit word of memory between two memory locations given to
> the enclave as arguments.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   tools/testing/selftests/x86/Makefile          |  10 +
>   tools/testing/selftests/x86/sgx/Makefile      |  48 ++
>   tools/testing/selftests/x86/sgx/defines.h     |  39 ++
>   tools/testing/selftests/x86/sgx/encl.c        |  20 +
>   tools/testing/selftests/x86/sgx/encl.lds      |  33 ++
>   .../selftests/x86/sgx/encl_bootstrap.S        |  94 ++++
>   tools/testing/selftests/x86/sgx/encl_piggy.S  |  18 +
>   tools/testing/selftests/x86/sgx/encl_piggy.h  |  14 +
>   tools/testing/selftests/x86/sgx/main.c        | 301 +++++++++++
>   tools/testing/selftests/x86/sgx/sgx_call.S    |  49 ++
>   tools/testing/selftests/x86/sgx/sgxsign.c     | 508 ++++++++++++++++++
>   .../testing/selftests/x86/sgx/signing_key.pem |  39 ++
>   12 files changed, 1173 insertions(+)
>   create mode 100644 tools/testing/selftests/x86/sgx/Makefile
>   create mode 100644 tools/testing/selftests/x86/sgx/defines.h
>   create mode 100644 tools/testing/selftests/x86/sgx/encl.c
>   create mode 100644 tools/testing/selftests/x86/sgx/encl.lds
>   create mode 100644 tools/testing/selftests/x86/sgx/encl_bootstrap.S
>   create mode 100644 tools/testing/selftests/x86/sgx/encl_piggy.S
>   create mode 100644 tools/testing/selftests/x86/sgx/encl_piggy.h
>   create mode 100644 tools/testing/selftests/x86/sgx/main.c
>   create mode 100644 tools/testing/selftests/x86/sgx/sgx_call.S
>   create mode 100644 tools/testing/selftests/x86/sgx/sgxsign.c
>   create mode 100644 tools/testing/selftests/x86/sgx/signing_key.pem
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index fa07d526fe39..a1831406fd01 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -1,4 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
> +
> +SUBDIRS_64 := sgx
> +
>   all:
>   
>   include ../lib.mk
> @@ -68,6 +71,13 @@ all_32: $(BINARIES_32)
>   
>   all_64: $(BINARIES_64)
>   
> +all_64: $(SUBDIRS_64)

$(SUBDIRS_64) aren't targets. No need for all_64 to depend on them.

> +	@for DIR in $(SUBDIRS_64); do			\
> +		BUILD_TARGET=$(OUTPUT)/$$DIR;		\
> +		mkdir $$BUILD_TARGET  -p;		\
> +		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;	\

Please use $(MAKE), otherwise command line options cannot be passed onto 
sub-makes.

> +	done

The above only builds but will not run SGX tests.

Also, 'clean' target will not descend into sgx folder either.

> +
>   EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
>   
>   $(BINARIES_32): $(OUTPUT)/%_32: %.c
> diff --git a/tools/testing/selftests/x86/sgx/Makefile b/tools/testing/selftests/x86/sgx/Makefile
> new file mode 100644
> index 000000000000..10136b73096b
> --- /dev/null
> +++ b/tools/testing/selftests/x86/sgx/Makefile
> @@ -0,0 +1,48 @@
> +top_srcdir = ../../../../..
> +
> +include ../../lib.mk
> +
> +HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
> +ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
> +	       -fno-stack-protector -mrdrnd $(INCLUDES)
> +
> +TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
> +all_64: $(TEST_CUSTOM_PROGS)
> +
> +$(TEST_CUSTOM_PROGS): $(OUTPUT)/main.o $(OUTPUT)/sgx_call.o \
> +		      $(OUTPUT)/encl_piggy.o
> +	$(CC) $(HOST_CFLAGS) -o $@ $^
> +
> +$(OUTPUT)/main.o: main.c
> +	$(CC) $(HOST_CFLAGS) -c $< -o $@

.o files don't have to be generated/kept. And to be consistent with 
other selftests, please don't generate/keep them.

> +
> +$(OUTPUT)/sgx_call.o: sgx_call.S
> +	$(CC) $(HOST_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/encl_piggy.o: $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss
> +	$(CC) $(HOST_CFLAGS) -c encl_piggy.S -o $@

Without -I, the above command breaks when "O=<target dir>" is specified.

> +
> +$(OUTPUT)/encl.bin: $(OUTPUT)/encl.elf $(OUTPUT)/sgxsign
> +	objcopy --remove-section=.got.plt -O binary $< $@

.got.plt section will never be present for statically linked binaries.

> +
> +$(OUTPUT)/encl.elf: $(OUTPUT)/encl.o $(OUTPUT)/encl_bootstrap.o
> +	$(CC) $(ENCL_CFLAGS) -T encl.lds -o $@ $^

Please fix the warning of ".note.gnu.build-id section discarded".

> +
> +$(OUTPUT)/encl.o: encl.c
> +	$(CC) $(ENCL_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/encl_bootstrap.o: encl_bootstrap.S
> +	$(CC) $(ENCL_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/encl.ss: $(OUTPUT)/encl.bin  $(OUTPUT)/sgxsign
> +	$(OUTPUT)/sgxsign signing_key.pem $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss
> +
> +$(OUTPUT)/sgxsign: sgxsign.c
> +	$(CC) -o $@ $< -lcrypto
> +
> +EXTRA_CLEAN := $(OUTPUT)/sgx-selftest $(OUTPUT)/sgx-selftest.o \
> +	       $(OUTPUT)/sgx_call.o $(OUTPUT)/encl.bin $(OUTPUT)/encl.ss \
> +	       $(OUTPUT)/encl.elf $(OUTPUT)/encl.o $(OUTPUT)/encl_bootstrap.o \
> +	       $(OUTPUT)/sgxsign
> +

encl_piggy.o, main.o and test_sgx are not cleaned.

> +.PHONY: clean
