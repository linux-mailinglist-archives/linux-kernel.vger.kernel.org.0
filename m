Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6F118CFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 15:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCTOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 10:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTOMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:12:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A5782072D;
        Fri, 20 Mar 2020 14:12:00 +0000 (UTC)
Date:   Fri, 20 Mar 2020 10:11:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     guoren@kernel.org
Cc:     mingo@redhat.co, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] arm/ftrace: Remove duplicate function
Message-ID: <20200320101159.60037586@gandalf.local.home>
In-Reply-To: <20200320065340.32685-1-guoren@kernel.org>
References: <20200320065340.32685-1-guoren@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 14:53:40 +0800
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> There is no arch implementation of ftrace_arch_code_modify_prepare in arm,
> so just use the __weak one in kernel/trace/ftrace.c.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/arm/kernel/ftrace.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 10499d44964a..f66ade28eb8a 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -56,11 +56,6 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
>  	return addr;
>  }
>  
> -int ftrace_arch_code_modify_prepare(void)
> -{
> -	return 0;
> -}
> -
>  int ftrace_arch_code_modify_post_process(void)
>  {
>  	/* Make sure any TLB misses during machine stop are cleared. */

