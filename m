Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7683552
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfHFPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:33:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA102070D;
        Tue,  6 Aug 2019 15:33:53 +0000 (UTC)
Date:   Tue, 6 Aug 2019 11:33:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] tracing: Be more clever when dumping hex in
 __print_hex()
Message-ID: <20190806113352.334d81b9@gandalf.local.home>
In-Reply-To: <20190806151543.86061-1-andriy.shevchenko@linux.intel.com>
References: <20190806151543.86061-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Aug 2019 18:15:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Hex dump as many as 16 bytes at once in trace_print_hex_seq()
> instead of byte-by-byte approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fix length calculation, so, when buf_len=16 it won't indefinitely loop
>  kernel/trace/trace_output.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index cab4a5398f1d..d54ce252b05a 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -219,10 +219,10 @@ trace_print_hex_seq(struct trace_seq *p, const unsigned char *buf, int buf_len,
>  {
>  	int i;
>  	const char *ret = trace_seq_buffer_ptr(p);
> +	const char *fmt = concatenate ? "%*phN" : "%*ph";
>  
> -	for (i = 0; i < buf_len; i++)
> -		trace_seq_printf(p, "%s%2.2x", concatenate || i == 0 ? "" : " ",
> -				 buf[i]);
> +	for (i = 0; i < buf_len; i += 16)
> +		trace_seq_printf(p, fmt, min(buf_len - i, 16), &buf[i]);

Cute.

I'll have to wrap my head around it a bit to make sure it's correct.

Thanks for sending this.

-- Steve

>  	trace_seq_putc(p, 0);
>  
>  	return ret;

