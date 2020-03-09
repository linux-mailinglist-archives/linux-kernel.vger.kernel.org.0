Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A852217E01C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 13:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCIMVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 08:21:46 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47529 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgCIMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:21:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 34D381365;
        Mon,  9 Mar 2020 08:21:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Mar 2020 08:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=BCMBiPrCo1x258U10zWiv/x8MXq
        dMoavcniKhTrs81s=; b=I9kaRzON9+ykXOtdOV8S8BiZlkUcJtW5y0vuPwIagC6
        xVJabMl5MsqwOM4J5EjYpagU7mmDAuJEu/Y53KG2XUrlQmCpeVCZbnfCQpxP3jeX
        tZuIuGF6XHPSCiscR7yXiKYS1UfvmY+afXTb5sRA1rHhQa10bqRyZEJk+Nv5Jw8y
        9De7oc/VvumX8Of/kLJlsqqapH1bNfPRE7wstWPEzbjGfl4P36eByQVCFpvhKB0j
        5FNyHhASwsC3YcXIZcd05Ec+8pmwpXmC/Iyd8kPGoO3FgYFwp4u1hBlhYk4cOV/Z
        o2cYsY+ROTfSHDRBdouud05Ap5MsQFWKHXInazxQZvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BCMBiP
        rCo1x258U10zWiv/x8MXqdMoavcniKhTrs81s=; b=iMn0MJOkt/FR2T+s/BWYrL
        blD06GQqZk4b43TttiV+/Nf7oa/xO6z/4Xcw1BXGp8m5oMlUmSAF82vXeV7VV28z
        SldpCEV9SMiWfQC35ROyMJAWEKfCU77iwOd2hPs3lmqkIzWCuHU0naYWAOSLLKwA
        GprlwDKOY8oyLEEv++J0oEzi978DvPAHU/ITRM9I8k8iQbZApDjKzSTUGKzTrDVM
        h5yogM6Q6nnxLlF460PIsg2DMjUuyjXd6T6qVuLjtR7QklX89u06QQEs3z5vFXaQ
        uUV5cpVKQ+Vk3UtLGKG5Ht86iJzZeqX/NOE0fddZ9R7utiz6H+fyD3iPzpMQu2qg
        ==
X-ME-Sender: <xms:1zRmXtH-yKQMWpuF3IyyqnICVVcysVb3uIMmRi2Z4gFKR5mnqI5dkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:1zRmXoGKVtAQerX8aGN6EOt2sQp9wEoBXq4D89SQ4JpW4lptpFhl3Q>
    <xmx:1zRmXl-AY3daGj8NRfq5wIhDIgSx1cKnY9CxFRm6TYI3XI-fntGoHA>
    <xmx:1zRmXqSZ16_FnCEBU9uEJEwdvITbtQ56hn1Cd_d_i1qMEQEFqNxjJg>
    <xmx:2TRmXlP85Fx5jAXXBL1epi8AW3aA9x4e18TyRonSUdgo6ZCBy8M_-g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E84833280059;
        Mon,  9 Mar 2020 08:21:42 -0400 (EDT)
Date:   Mon, 9 Mar 2020 13:21:38 +0100
From:   Greg KH <greg@kroah.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, alexios.zavras@intel.com, tglx@linutronix.de,
        akpm@linux-foundation.org, steven.price@arm.com,
        steve.capper@arm.com, broonie@kernel.org, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] arm64: add check_wx_pages debugfs for CHECK_WX
Message-ID: <20200309122138.GA206943@kroah.com>
References: <20200307093926.27145-1-tranmanphong@gmail.com>
 <20200309121713.GA26309@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309121713.GA26309@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:17:14PM +0000, Mark Rutland wrote:
> On Sat, Mar 07, 2020 at 04:39:26PM +0700, Phong Tran wrote:
> > follow the suggestion from
> > https://github.com/KSPP/linux/issues/35
> 
> That says:
> 
> | This should be implemented for all architectures
> 
> ... so surely this should be in generic code, rahter than being
> arm64-specific?
> 
> Thanks,
> Mark.
> 
> > 
> > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> > ---
> >  arch/arm64/Kconfig.debug        |  3 ++-
> >  arch/arm64/include/asm/ptdump.h |  2 ++
> >  arch/arm64/mm/dump.c            |  1 +
> >  arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
> >  4 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> > index 1c906d932d6b..be552fa351e2 100644
> > --- a/arch/arm64/Kconfig.debug
> > +++ b/arch/arm64/Kconfig.debug
> > @@ -48,7 +48,8 @@ config DEBUG_WX
> >  	  of other unfixed kernel bugs easier.
> >  
> >  	  There is no runtime or memory usage effect of this option
> > -	  once the kernel has booted up - it's a one time check.
> > +	  once the kernel has booted up - it's a one time check and
> > +	  can be checked by echo "1" to "check_wx_pages" debugfs in runtime.
> >  
> >  	  If in doubt, say "Y".
> >  
> > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > index 38187f74e089..b80d6b4fc508 100644
> > --- a/arch/arm64/include/asm/ptdump.h
> > +++ b/arch/arm64/include/asm/ptdump.h
> > @@ -24,9 +24,11 @@ struct ptdump_info {
> >  void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
> >  #ifdef CONFIG_PTDUMP_DEBUGFS
> >  void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> > +int ptdump_check_wx_init(void);
> >  #else
> >  static inline void ptdump_debugfs_register(struct ptdump_info *info,
> >  					   const char *name) { }
> > +static inline int ptdump_check_wx_init(void) { return 0; }
> >  #endif
> >  void ptdump_check_wx(void);
> >  #endif /* CONFIG_PTDUMP_CORE */
> > diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> > index 860c00ec8bd3..60c99a047763 100644
> > --- a/arch/arm64/mm/dump.c
> > +++ b/arch/arm64/mm/dump.c
> > @@ -378,6 +378,7 @@ static int ptdump_init(void)
> >  #endif
> >  	ptdump_initialize();
> >  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> > +	ptdump_check_wx_init();
> >  	return 0;
> >  }
> >  device_initcall(ptdump_init);
> > diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> > index 1f2eae3e988b..73cddc12c3c2 100644
> > --- a/arch/arm64/mm/ptdump_debugfs.c
> > +++ b/arch/arm64/mm/ptdump_debugfs.c
> > @@ -16,3 +16,21 @@ void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> >  {
> >  	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
> >  }
> > +
> > +static int check_wx_debugfs_set(void *data, u64 val)
> > +{
> > +	if (val != 1ULL)
> > +		return -EINVAL;
> > +
> > +	ptdump_check_wx();
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
> > +
> > +int ptdump_check_wx_init(void)
> > +{
> > +	return debugfs_create_file("check_wx_pages", 0200, NULL,
> > +				   NULL, &check_wx_fops) ? 0 : -ENOMEM;

Do not check the return value of this function, especially as it is
returning a pointer, not an int!

Just call the function and move on, you should not do anything different
if it returns an error or not.

thanks,

greg k-h
