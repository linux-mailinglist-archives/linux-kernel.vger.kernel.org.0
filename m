Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0433615F93C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBNWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 17:06:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgBNWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=KQcfPKLdYWiT3Zp7CFHC5wic89S8w7PnmfElVtSNbbA=; b=jlzb2VOh5ORjESCWs0YkcW8KgT
        ZzGdR6QkHFIS/nRHHITMLLSvNsOfogd21PNrw18ScFSXsOGX+wL0ITaTDUvQdzNIRlbRwRrEXiJsM
        4Ta6bpDrCRjDAkHkZvtla7Un5eyNKpRxSy1fSMUy2JC6zlHrX0IYmoF+8Ix4grzDKbMAwh4Dds7Tq
        A0H1MxCtgI2+Bx58kliveSyfIS/NJnhB80LDocAqTC5/tPWBLvm78LlbbVP6Kem7Eb9rcqUrNeL/r
        ZyWG9bTh386g936J19akeiM7SYyc1kEl/MK+qzj9aoFNyOeedP4Wn6d9xI+n8LqNwcHdqAcQxSGCu
        5Evzj+Kg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2j6e-0005TK-CB; Fri, 14 Feb 2020 22:06:40 +0000
Subject: Re: [PATCH v6 2/6] lib: introduce generic min-heap
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20191206231539.227585-1-irogers@google.com>
 <20200214075133.181299-1-irogers@google.com>
 <20200214075133.181299-3-irogers@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05cb6734-79f8-c7bf-0d62-d9417a6f7656@infradead.org>
Date:   Fri, 14 Feb 2020 14:06:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214075133.181299-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/13/20 11:51 PM, Ian Rogers wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1458505192cd..e61e7fee9364 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1771,6 +1771,16 @@ config TEST_LIST_SORT
>  
>  	  If unsure, say N.
>  
> +config TEST_MIN_HEAP
> +	tristate "Min heap test"
> +	depends on DEBUG_KERNEL || m

I realize that this is (likely) copied from other config entries,
but the "depends on DEBUG_KERNEL || m" doesn't make any sense to me.
Seems like it should be "depends on DEBUG_KERNEL && m"...

Why should it be "||"??


> +	help
> +	  Enable this to turn on min heap function tests. This test is
> +	  executed only once during system boot (so affects only boot time),
> +	  or at module load time.
> +
> +	  If unsure, say N.
> +
>  config TEST_SORT
>  	tristate "Array-based sort test"
>  	depends on DEBUG_KERNEL || m


thanks.
-- 
~Randy

