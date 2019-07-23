Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601AF71C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfGWQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 12:04:32 -0400
Received: from foss.arm.com ([217.140.110.172]:57036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfGWQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:04:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9540328;
        Tue, 23 Jul 2019 09:04:31 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DE083F71A;
        Tue, 23 Jul 2019 09:04:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] arm64: unwind: Prohibit probing on
 return_address()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
 <156378172702.12011.1144595747474511323.stgit@devnote2>
From:   James Morse <james.morse@arm.com>
Message-ID: <038c4b88-e7ef-aaab-0a79-5d7371719aa5@arm.com>
Date:   Tue, 23 Jul 2019 17:04:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156378172702.12011.1144595747474511323.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/07/2019 08:48, Masami Hiramatsu wrote:
> Prohibit probing on return_address() and subroutines which
> is called from return_address(), since the it is invoked from
> trace_hardirqs_off() which is also kprobe blacklisted.

(Nits: "which are called" and "since it is")


> diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
> index b21cba90f82d..7f8a143268b0 100644
> --- a/arch/arm64/kernel/return_address.c
> +++ b/arch/arm64/kernel/return_address.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/export.h>
>  #include <linux/ftrace.h>
> +#include <linux/kprobes.h>
>  
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
> @@ -17,7 +18,7 @@ struct return_address_data {
>  	void *addr;
>  };
>  
> -static int save_return_addr(struct stackframe *frame, void *d)
> +static nokprobe_inline int save_return_addr(struct stackframe *frame, void *d)

This nokprobe_inline ends up as __always_inline if kprobes is enabled.
What do we expect the compiler to do with this? save_return_addr is passed as a
function-pointer to walk_stackframe()... I don't see how the compiler can inline it!

This would be needed for on_accessible_stack().
Should we cover ftrace_graph_get_ret_stack()?, or is that already in hand?


>  {
>  	struct return_address_data *data = d;
>  
> @@ -52,3 +53,4 @@ void *return_address(unsigned int level)
>  		return NULL;
>  }
>  EXPORT_SYMBOL_GPL(return_address);
> +NOKPROBE_SYMBOL(return_address);


Thanks,

James
