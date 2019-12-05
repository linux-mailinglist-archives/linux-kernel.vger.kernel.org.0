Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5750113974
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 02:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfLEB6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 20:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbfLEB6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:58:23 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F0D20659;
        Thu,  5 Dec 2019 01:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575511103;
        bh=m4om41388Poq2Glq55LX3ImwnlIpx7VvriV/Qajv7j8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZ6UhdG6rz2h8Chr18lH9FwJ4igIQK2HG/CLxN61OxkQJMvGYycfi+x5LzvpjdlmT
         TRXBkKxntdXPqilcFqz+q+IFMqdjPqEXrgT8qGSijc8TimZ+b+ZAxCUY7FRjVpbXHR
         Q7OZzvSdz71ubK7V6q6HdhTo0mXYp9eXVpiGDVOo=
Date:   Thu, 5 Dec 2019 02:58:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Flavio Leitner <fbl@sysclose.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/stat: fix wrong cpustat gnice value
Message-ID: <20191205015819.GA14589@lenoir>
References: <20191205003936.2635315-1-fbl@sysclose.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205003936.2635315-1-fbl@sysclose.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:39:36PM -0300, Flavio Leitner wrote:
> The value being used for guest_nice should be CPUTIME_GUEST_NICE
> and not CPUTIME_USER.
> 
> Fixes: 26dae145a76c "procfs: Use all-in-one vtime aware kcpustat accessor"
> Signed-off-by: Flavio Leitner <fbl@sysclose.org>

Good catch, thanks!

> ---
>  fs/proc/stat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/stat.c b/fs/proc/stat.c
> index 37bdbec5b402..fd931d3e77be 100644
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -134,7 +134,7 @@ static int show_stat(struct seq_file *p, void *v)
>  		softirq		+= cpustat[CPUTIME_SOFTIRQ];
>  		steal		+= cpustat[CPUTIME_STEAL];
>  		guest		+= cpustat[CPUTIME_GUEST];
> -		guest_nice	+= cpustat[CPUTIME_USER];
> +		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
>  		sum		+= kstat_cpu_irqs_sum(i);
>  		sum		+= arch_irq_stat_cpu(i);
>  
> @@ -175,7 +175,7 @@ static int show_stat(struct seq_file *p, void *v)
>  		softirq		= cpustat[CPUTIME_SOFTIRQ];
>  		steal		= cpustat[CPUTIME_STEAL];
>  		guest		= cpustat[CPUTIME_GUEST];
> -		guest_nice	= cpustat[CPUTIME_USER];
> +		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
>  		seq_printf(p, "cpu%d", i);
>  		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
>  		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
> -- 
> 2.23.0
> 
