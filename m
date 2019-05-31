Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A411E30C74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEaKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 06:17:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaKRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w4vrqrDF7W9RqTb6Rqgru/EiLTE4cPWG6ak1MZifZa4=; b=iEkFNxgonBs4Y+I/ZiKzU3r56
        4VPv/zTUAGze8uO37S7CRrVORy8JOYfYoI5RhMJzK7zP5lYtRPbMaOQxKOj+PgvMgjhF2Ji5YwrhP
        HGDOLNFsd6XjlpOX35/ZzudxsLH1sQh+oHSi2whe57rDiJkkBkT6C/VibUcLuQTb3VdqlQMzyjL+c
        zlrfuL4LaI2P7cSAPSUSB4Avlv85AVBt8yTjUbwKB7FXTJtvVXQfmW+lIscKnTnDNzVM2W+NUmHtA
        X5JxiLs47yuWsczojYz6OhMDWfdCyTGuI+1STkai+fnr7fL87FeQ/BZd+Ew3lABs37x+6fp4dA4Dk
        /HCQlDjZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWeb7-0000UV-SJ; Fri, 31 May 2019 10:17:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E94E201CF1CB; Fri, 31 May 2019 12:17:16 +0200 (CEST)
Date:   Fri, 31 May 2019 12:17:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH v2 07/12] smp: Do not mark call_function_data as
 shared
Message-ID: <20190531101716.GN2623@hirez.programming.kicks-ass.net>
References: <20190531063645.4697-1-namit@vmware.com>
 <20190531063645.4697-8-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531063645.4697-8-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:36:40PM -0700, Nadav Amit wrote:
> cfd_data is marked as shared, but although it hold pointers to shared
> data structures, it is private per core.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 6b411ee86ef6..f1a358f9c34c 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -33,7 +33,7 @@ struct call_function_data {
>  	cpumask_var_t		cpumask_ipi;
>  };
>  
> -static DEFINE_PER_CPU_SHARED_ALIGNED(struct call_function_data, cfd_data);
> +static DEFINE_PER_CPU(struct call_function_data, cfd_data);

Should that not be DEFINE_PER_CPU_ALIGNED() then?

>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
>  
> -- 
> 2.20.1
> 
