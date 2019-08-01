Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73027DC5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHANPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 09:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHANPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:15:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA05206B8;
        Thu,  1 Aug 2019 13:15:03 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:15:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     <mingo@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190801091502.4efdbcae@gandalf.local.home>
In-Reply-To: <20190801083340.57075-1-jiping.ma2@windriver.com>
References: <20190801083340.57075-1-jiping.ma2@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019 16:33:40 +0800
Jiping Ma <jiping.ma2@windriver.com> wrote:

> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5d16f73898db..ed80b95abf06 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -40,16 +40,28 @@ static void print_max_stack(void)
>  
>  	pr_emerg("        Depth    Size   Location    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> +#ifdef CONFIG_ARM64
> +			   stack_trace_nr_entries - 1);
> +#else
>  			   stack_trace_nr_entries);
> -

NACK! I do not allow arch specific code in generic code like this.

The stack saving should be the same across all archs. If it is not, it
is a bug with the arch that is different.

-- Steve
