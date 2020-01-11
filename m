Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A013820D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 16:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgAKPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 10:36:32 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:23863 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729989AbgAKPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:36:32 -0500
X-IronPort-AV: E=Sophos;i="5.69,421,1571695200"; 
   d="scan'208";a="430910632"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 16:36:29 +0100
Date:   Sat, 11 Jan 2020 16:36:28 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Wen Yang <wenyang@linux.alibaba.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
In-Reply-To: <20200110131526.60180-1-wenyang@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.2001111633130.2568@hadrien>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2020, Wen Yang wrote:

> do_div() does a 64-by-32 division.
> When the divisor is unsigned long, u64, or s64,
> do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
> This semantic patch is inspired by Mateusz Guzik's patch:
> commit b0ab99e7736a ("sched: Fix possible divide by zero in avg_atom() calculation")
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

This looks good to me.

A small detail is that you don't need the parentheses in:

@r depends on (org || report)@

julia

> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Matthias Maennich <maennich@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org
> ---
> v3:
> - also filter out safe consts for context mode.
> - cleanup code.
>
> v2:
> - add a special case for constants and checking whether the value is obviously safe and no warning is needed.
> - fix 'WARNING:' twice in each case.
> - extend the warning to say "consider using div64_xxx instead".
>
>  scripts/coccinelle/misc/do_div.cocci | 155 +++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/do_div.cocci
>
> diff --git a/scripts/coccinelle/misc/do_div.cocci b/scripts/coccinelle/misc/do_div.cocci
> new file mode 100644
> index 000000000000..79db083c5208
> --- /dev/null
> +++ b/scripts/coccinelle/misc/do_div.cocci
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// do_div() does a 64-by-32 division.
> +/// When the divisor is long, unsigned long, u64, or s64,
> +/// do_div() truncates it to 32 bits, this means it can test
> +/// non-zero and be truncated to 0 for division on 64bit platforms.
> +///
> +//# This makes an effort to find those inappropriate do_div() calls.
> +//
> +// Confidence: Moderate
> +// Copyright: (C) 2020 Wen Yang, Alibaba.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +@initialize:python@
> +@@
> +
> +def get_digit_type_and_value(str):
> +    is_digit = False
> +    value = 0
> +
> +    try:
> +        if (str.isdigit()):
> +           is_digit = True
> +           value =  int(str, 0)
> +        elif (str.upper().endswith('ULL')):
> +           is_digit = True
> +           value = int(str[:-3], 0)
> +        elif (str.upper().endswith('LL')):
> +           is_digit = True
> +           value = int(str[:-2], 0)
> +        elif (str.upper().endswith('UL')):
> +           is_digit = True
> +           value = int(str[:-2], 0)
> +        elif (str.upper().endswith('L')):
> +           is_digit = True
> +           value = int(str[:-1], 0)
> +        elif (str.upper().endswith('U')):
> +           is_digit = True
> +           value = int(str[:-1], 0)
> +    except Exception as e:
> +          print('Error:',e)
> +          is_digit = False
> +          value = 0
> +    finally:
> +        return is_digit, value
> +
> +def filter_out_safe_constants(str):
> +    is_digit, value = get_digit_type_and_value(str)
> +    if (is_digit):
> +        if (value >= 0x100000000):
> +            return True
> +        else:
> +            return False
> +    else:
> +        return True
> +
> +def construct_warnings(suggested_fun):
> +    msg="WARNING: do_div() does a 64-by-32 division, please consider using %s instead."
> +    return  msg % suggested_fun
> +
> +@depends on context@
> +expression f;
> +long l: script:python() { filter_out_safe_constants(l) };
> +unsigned long ul : script:python() { filter_out_safe_constants(ul) };
> +u64 ul64 : script:python() { filter_out_safe_constants(ul64) };
> +s64 sl64 : script:python() { filter_out_safe_constants(sl64) };
> +
> +@@
> +(
> +* do_div(f, l);
> +|
> +* do_div(f, ul);
> +|
> +* do_div(f, ul64);
> +|
> +* do_div(f, sl64);
> +)
> +
> +@r depends on (org || report)@
> +expression f;
> +position p;
> +long l: script:python() { filter_out_safe_constants(l) };
> +unsigned long ul : script:python() { filter_out_safe_constants(ul) };
> +u64 ul64 : script:python() { filter_out_safe_constants(ul64) };
> +s64 sl64 : script:python() { filter_out_safe_constants(sl64) };
> +@@
> +(
> +do_div@p(f, l);
> +|
> +do_div@p(f, ul);
> +|
> +do_div@p(f, ul64);
> +|
> +do_div@p(f, sl64);
> +)
> +
> +@script:python depends on org@
> +p << r.p;
> +ul << r.ul;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))
> +
> +@script:python depends on org@
> +p << r.p;
> +l << r.l;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_long"))
> +
> +@script:python depends on org@
> +p << r.p;
> +ul64 << r.ul64;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_u64"))
> +
> +@script:python depends on org@
> +p << r.p;
> +sl64 << r.sl64;
> +@@
> +
> +coccilib.org.print_todo(p[0], construct_warnings("div64_s64"))
> +
> +@script:python depends on report@
> +p << r.p;
> +ul << r.ul;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_ul"))
> +
> +@script:python depends on report@
> +p << r.p;
> +l << r.l;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_long"))
> +
> +@script:python depends on report@
> +p << r.p;
> +sl64 << r.sl64;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_s64"))
> +
> +@script:python depends on report@
> +p << r.p;
> +ul64 << r.ul64;
> +@@
> +
> +coccilib.report.print_report(p[0], construct_warnings("div64_u64"))
> --
> 2.23.0
>
>
