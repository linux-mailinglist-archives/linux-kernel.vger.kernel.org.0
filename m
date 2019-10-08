Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30445CF9CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfJHMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbfJHMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF604C0546FF;
        Tue,  8 Oct 2019 12:31:09 +0000 (UTC)
Received: from krava (unknown [10.40.205.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E5B0600CE;
        Tue,  8 Oct 2019 12:31:05 +0000 (UTC)
Date:   Tue, 8 Oct 2019 14:31:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Mao Han <han_mao@c-sky.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf tools: avoid sample_reg_masks being const + weak
Message-ID: <20191008123104.GA16241@krava>
References: <20190927214341.170683-1-irogers@google.com>
 <20191001003623.255186-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001003623.255186-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 08 Oct 2019 12:31:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 05:36:23PM -0700, Ian Rogers wrote:
> Being const + weak breaks with some compilers that constant-propagate
> from the weak symbol. This behavior is outside of the specification, but
> in LLVM is chosen to match GCC's behavior.
> 
> LLVM's implementation was set in this patch:
> https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
> A const + weak symbol is set to be weak_odr:
> https://llvm.org/docs/LangRef.html
> ODR is one definition rule, and given there is one constant definition
> constant-propagation is possible. It is possible to get this code to
> miscompile with LLVM when applying link time optimization. As compilers
> become more aggressive, this is likely to break in more instances.

is this just aprecaution or you actualy saw some breakage?

> 
> Move the definition of sample_reg_masks to the conditional part of
> perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
> weak symbol.
> 
> Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.
> In v3, add perf_regs.c for architectures that HAVE_PERF_REGS_SUPPORT but
> don't declare sample_regs_masks.

looks good to me (again ;-)), let's see if it passes Arnaldo's farm

thanks,
jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm/util/Build         | 2 ++
>  tools/perf/arch/arm/util/perf_regs.c   | 6 ++++++
>  tools/perf/arch/arm64/util/Build       | 1 +
>  tools/perf/arch/arm64/util/perf_regs.c | 6 ++++++
>  tools/perf/arch/csky/util/Build        | 2 ++
>  tools/perf/arch/csky/util/perf_regs.c  | 6 ++++++
>  tools/perf/arch/riscv/util/Build       | 2 ++
>  tools/perf/arch/riscv/util/perf_regs.c | 6 ++++++
>  tools/perf/arch/s390/util/Build        | 1 +
>  tools/perf/arch/s390/util/perf_regs.c  | 6 ++++++
>  tools/perf/util/parse-regs-options.c   | 8 ++++++--
>  tools/perf/util/perf_regs.c            | 4 ----
>  tools/perf/util/perf_regs.h            | 4 ++--
>  13 files changed, 46 insertions(+), 8 deletions(-)
>  create mode 100644 tools/perf/arch/arm/util/perf_regs.c
>  create mode 100644 tools/perf/arch/arm64/util/perf_regs.c
>  create mode 100644 tools/perf/arch/csky/util/perf_regs.c
>  create mode 100644 tools/perf/arch/riscv/util/perf_regs.c
>  create mode 100644 tools/perf/arch/s390/util/perf_regs.c
> 
> diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
> index 296f0eac5e18..37fc63708966 100644
> --- a/tools/perf/arch/arm/util/Build
> +++ b/tools/perf/arch/arm/util/Build
> @@ -1,3 +1,5 @@
> +perf-y += perf_regs.o
> +
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  
>  perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
> diff --git a/tools/perf/arch/arm/util/perf_regs.c b/tools/perf/arch/arm/util/perf_regs.c
> new file mode 100644
> index 000000000000..2864e2e3776d
> --- /dev/null
> +++ b/tools/perf/arch/arm/util/perf_regs.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../../util/perf_regs.h"
> +
> +const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG_END
> +};
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 3cde540d2fcf..0a7782c61209 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,4 +1,5 @@
>  perf-y += header.o
> +perf-y += perf_regs.o
>  perf-y += sym-handling.o
>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
> new file mode 100644
> index 000000000000..2864e2e3776d
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/perf_regs.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../../util/perf_regs.h"
> +
> +const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG_END
> +};
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> index 1160bb2332ba..7d3050134ae0 100644
> --- a/tools/perf/arch/csky/util/Build
> +++ b/tools/perf/arch/csky/util/Build
> @@ -1,2 +1,4 @@
> +perf-y += perf_regs.o
> +
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/csky/util/perf_regs.c b/tools/perf/arch/csky/util/perf_regs.c
> new file mode 100644
> index 000000000000..2864e2e3776d
> --- /dev/null
> +++ b/tools/perf/arch/csky/util/perf_regs.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../../util/perf_regs.h"
> +
> +const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG_END
> +};
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
> index 1160bb2332ba..7d3050134ae0 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -1,2 +1,4 @@
> +perf-y += perf_regs.o
> +
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
> new file mode 100644
> index 000000000000..2864e2e3776d
> --- /dev/null
> +++ b/tools/perf/arch/riscv/util/perf_regs.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../../util/perf_regs.h"
> +
> +const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG_END
> +};
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
> index 22797f043b84..3d9d0f4f72ca 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -1,5 +1,6 @@
>  perf-y += header.o
>  perf-y += kvm-stat.o
> +perf-y += perf_regs.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/s390/util/perf_regs.c b/tools/perf/arch/s390/util/perf_regs.c
> new file mode 100644
> index 000000000000..2864e2e3776d
> --- /dev/null
> +++ b/tools/perf/arch/s390/util/perf_regs.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "../../util/perf_regs.h"
> +
> +const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG_END
> +};
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> index ef46c2848808..e687497b3aac 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -13,7 +13,7 @@ static int
>  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  {
>  	uint64_t *mode = (uint64_t *)opt->value;
> -	const struct sample_reg *r;
> +	const struct sample_reg *r = NULL;
>  	char *s, *os = NULL, *p;
>  	int ret = -1;
>  	uint64_t mask;
> @@ -46,19 +46,23 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  
>  			if (!strcmp(s, "?")) {
>  				fprintf(stderr, "available registers: ");
> +#ifdef HAVE_PERF_REGS_SUPPORT
>  				for (r = sample_reg_masks; r->name; r++) {
>  					if (r->mask & mask)
>  						fprintf(stderr, "%s ", r->name);
>  				}
> +#endif
>  				fputc('\n', stderr);
>  				/* just printing available regs */
>  				return -1;
>  			}
> +#ifdef HAVE_PERF_REGS_SUPPORT
>  			for (r = sample_reg_masks; r->name; r++) {
>  				if ((r->mask & mask) && !strcasecmp(s, r->name))
>  					break;
>  			}
> -			if (!r->name) {
> +#endif
> +			if (!r || !r->name) {
>  				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
>  					    s, intr ? "-I" : "--user-regs=");
>  				goto error;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 2774cec1f15f..5ee47ae1509c 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -3,10 +3,6 @@
>  #include "perf_regs.h"
>  #include "event.h"
>  
> -const struct sample_reg __weak sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>  				 char **new_op __maybe_unused)
>  {
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 47fe34e5f7d5..e014c2c038f4 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -15,8 +15,6 @@ struct sample_reg {
>  #define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
>  #define SMPL_REG_END { .name = NULL }
>  
> -extern const struct sample_reg sample_reg_masks[];
> -
>  enum {
>  	SDT_ARG_VALID = 0,
>  	SDT_ARG_SKIP,
> @@ -27,6 +25,8 @@ uint64_t arch__intr_reg_mask(void);
>  uint64_t arch__user_reg_mask(void);
>  
>  #ifdef HAVE_PERF_REGS_SUPPORT
> +extern const struct sample_reg sample_reg_masks[];
> +
>  #include <perf_regs.h>
>  
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
