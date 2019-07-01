Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612DB44DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfFMUo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 16:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfFMUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5140308A9BE;
        Thu, 13 Jun 2019 20:44:56 +0000 (UTC)
Received: from krava (ovpn-204-98.brq.redhat.com [10.40.204.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40F5D54474;
        Thu, 13 Jun 2019 20:44:55 +0000 (UTC)
Date:   Thu, 13 Jun 2019 22:44:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build failure with newer glibc headers
Message-ID: <20190613204454.GB18963@krava>
References: <4c0a4264-7142-2e6d-540d-aa354700e0bb@redhat.com>
 <20190612205611.GA2149@redhat.com>
 <20190613151925.GA2834@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613151925.GA2834@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Jun 2019 20:44:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:19:25PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 12, 2019 at 05:56:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> > So, we'll have to have a feature test, that defines some HAVE_GETTID
> > that then ifdefs out our inline copy, working on it.
> 
> This should take care of it, please check, perhaps providing a
> Tested-by: to add to this,
> 
> Thanks,
> 
> - Arnaldo
> 
> commit a04ef2eb0a66d9479e75e536d919c8c9cd618ee3
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Jun 13 12:04:19 2019 -0300
> 
>     tools build: Check if gettid() is available before providing helper
>     
>     Laura reported that the perf build failed in fedora when we got a glibc
>     that provides gettid(), which I reproduced using fedora rawhide with the
>     glibc-devel-2.29.9000-26.fc31.x86_64 package.
>     
>     Add a feature check to avoid providing a gettid() helper in such
>     systems.
>     
>     On a fedora rawhide system with this patch applied we now get:
>     
>       [root@7a5f55352234 perf]# grep gettid /tmp/build/perf/FEATURE-DUMP
>       feature-gettid=1
>       [root@7a5f55352234 perf]# cat /tmp/build/perf/feature/test-gettid.make.output
>       [root@7a5f55352234 perf]# ldd /tmp/build/perf/feature/test-gettid.bin
>               linux-vdso.so.1 (0x00007ffc6b1f6000)
>               libc.so.6 => /lib64/libc.so.6 (0x00007f04e0a74000)
>               /lib64/ld-linux-x86-64.so.2 (0x00007f04e0c47000)
>       [root@7a5f55352234 perf]# nm /tmp/build/perf/feature/test-gettid.bin | grep -w gettid
>                        U gettid@@GLIBC_2.30
>       [root@7a5f55352234 perf]#
>     
>     While on a fedora:29 system:
>     
>       [acme@quaco perf]$ grep gettid /tmp/build/perf/FEATURE-DUMP
>       feature-gettid=0
>       [acme@quaco perf]$ cat /tmp/build/perf/feature/test-gettid.make.output
>       test-gettid.c: In function ‘main’:
>       test-gettid.c:8:9: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>         return gettid();
>                ^~~~~~
>                getgid
>       cc1: all warnings being treated as errors
>       [acme@quaco perf]$
>     
>     Reported-by: Laura Abbott <labbott@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Florian Weimer <fweimer@redhat.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Stephane Eranian <eranian@google.com>
>     Link: https://lkml.kernel.org/n/tip-yfy3ch53agmklwu9o7rlgf9c@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

looks good to me, if needed:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 3b24231c58a2..50377cc2f5f9 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -36,6 +36,7 @@ FEATURE_TESTS_BASIC :=                  \
>          fortify-source                  \
>          sync-compare-and-swap           \
>          get_current_dir_name            \
> +        gettid				\
>          glibc                           \
>          gtk2                            \
>          gtk2-infobar                    \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 4b8244ee65ce..523ee42db0c8 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -54,6 +54,7 @@ FILES=                                          \
>           test-get_cpuid.bin                     \
>           test-sdt.bin                           \
>           test-cxx.bin                           \
> +         test-gettid.bin			\
>           test-jvmti.bin				\
>           test-jvmti-cmlr.bin			\
>           test-sched_getcpu.bin			\
> @@ -267,6 +268,9 @@ $(OUTPUT)test-sdt.bin:
>  $(OUTPUT)test-cxx.bin:
>  	$(BUILDXX) -std=gnu++11
>  
> +$(OUTPUT)test-gettid.bin:
> +	$(BUILD)
> +
>  $(OUTPUT)test-jvmti.bin:
>  	$(BUILD)
>  
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index a59c53705093..3b3d5d72124a 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -38,6 +38,10 @@
>  # include "test-get_current_dir_name.c"
>  #undef main
>  
> +#define main main_test_gettid
> +# include "test-gettid.c"
> +#undef main
> +
>  #define main main_test_glibc
>  # include "test-glibc.c"
>  #undef main
> @@ -195,6 +199,7 @@ int main(int argc, char *argv[])
>  	main_test_libelf();
>  	main_test_libelf_mmap();
>  	main_test_get_current_dir_name();
> +	main_test_gettid();
>  	main_test_glibc();
>  	main_test_dwarf();
>  	main_test_dwarf_getlocations();
> diff --git a/tools/build/feature/test-gettid.c b/tools/build/feature/test-gettid.c
> new file mode 100644
> index 000000000000..ef24e42d3f1b
> --- /dev/null
> +++ b/tools/build/feature/test-gettid.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +
> +int main(void)
> +{
> +	return gettid();
> +}
> +
> +#undef _GNU_SOURCE
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 51dd00f65709..5f16a20cae86 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -332,6 +332,10 @@ ifeq ($(feature-get_current_dir_name), 1)
>    CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
>  endif
>  
> +ifeq ($(feature-gettid), 1)
> +  CFLAGS += -DHAVE_GETTID
> +endif
> +
>  ifdef NO_LIBELF
>    NO_DWARF := 1
>    NO_DEMANGLE := 1
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index f7eb63cbbc65..88108598d6e9 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -45,10 +45,12 @@
>  static char jit_path[PATH_MAX];
>  static void *marker_addr;
>  
> +#ifndef HAVE_GETTID
>  static inline pid_t gettid(void)
>  {
>  	return (pid_t)syscall(__NR_gettid);
>  }
> +#endif
>  
>  static int get_e_machine(struct jitheader *hdr)
>  {
