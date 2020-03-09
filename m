Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D536217E507
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 17:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCIQvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 12:51:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgCIQvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:51:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A9A11FB;
        Mon,  9 Mar 2020 09:51:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDE713F534;
        Mon,  9 Mar 2020 09:51:47 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:51:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Phong Tran <tranmanphong@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, alexios.zavras@intel.com, tglx@linutronix.de,
        akpm@linux-foundation.org, steven.price@arm.com,
        steve.capper@arm.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] arm64: add check_wx_pages debugfs for CHECK_WX
Message-ID: <20200309165125.GA44566@lakrids.cambridge.arm.com>
References: <20200307093926.27145-1-tranmanphong@gmail.com>
 <20200309121713.GA26309@lakrids.cambridge.arm.com>
 <202003090914.F6720CFF13@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003090914.F6720CFF13@keescook>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 09:15:10AM -0700, Kees Cook wrote:
> On Mon, Mar 09, 2020 at 12:17:14PM +0000, Mark Rutland wrote:
> > On Sat, Mar 07, 2020 at 04:39:26PM +0700, Phong Tran wrote:
> > > follow the suggestion from
> > > https://github.com/KSPP/linux/issues/35
> > 
> > That says:
> > 
> > | This should be implemented for all architectures
> > 
> > ... so surely this should be in generic code, rahter than being
> > arm64-specific?
> 
> Not all architectures have implemented CONFIG_DEBUG_WX...

Sure; I assumed the generic code could be gated with:

#ifdef CONFIG_DEBUG_WX
	debug_checkwx()
#endif

... or something to that effect, so that the common code could handle
all the sysfs bits and ensure that part was consistent.

Thanksm
Mark.
> 
> -Kees
> 
> > 
> > Thanks,
> > Mark.
> > 
> > > 
> > > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> > > ---
> > >  arch/arm64/Kconfig.debug        |  3 ++-
> > >  arch/arm64/include/asm/ptdump.h |  2 ++
> > >  arch/arm64/mm/dump.c            |  1 +
> > >  arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
> > >  4 files changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> > > index 1c906d932d6b..be552fa351e2 100644
> > > --- a/arch/arm64/Kconfig.debug
> > > +++ b/arch/arm64/Kconfig.debug
> > > @@ -48,7 +48,8 @@ config DEBUG_WX
> > >  	  of other unfixed kernel bugs easier.
> > >  
> > >  	  There is no runtime or memory usage effect of this option
> > > -	  once the kernel has booted up - it's a one time check.
> > > +	  once the kernel has booted up - it's a one time check and
> > > +	  can be checked by echo "1" to "check_wx_pages" debugfs in runtime.
> > >  
> > >  	  If in doubt, say "Y".
> > >  
> > > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > > index 38187f74e089..b80d6b4fc508 100644
> > > --- a/arch/arm64/include/asm/ptdump.h
> > > +++ b/arch/arm64/include/asm/ptdump.h
> > > @@ -24,9 +24,11 @@ struct ptdump_info {
> > >  void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
> > >  #ifdef CONFIG_PTDUMP_DEBUGFS
> > >  void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> > > +int ptdump_check_wx_init(void);
> > >  #else
> > >  static inline void ptdump_debugfs_register(struct ptdump_info *info,
> > >  					   const char *name) { }
> > > +static inline int ptdump_check_wx_init(void) { return 0; }
> > >  #endif
> > >  void ptdump_check_wx(void);
> > >  #endif /* CONFIG_PTDUMP_CORE */
> > > diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> > > index 860c00ec8bd3..60c99a047763 100644
> > > --- a/arch/arm64/mm/dump.c
> > > +++ b/arch/arm64/mm/dump.c
> > > @@ -378,6 +378,7 @@ static int ptdump_init(void)
> > >  #endif
> > >  	ptdump_initialize();
> > >  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> > > +	ptdump_check_wx_init();
> > >  	return 0;
> > >  }
> > >  device_initcall(ptdump_init);
> > > diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> > > index 1f2eae3e988b..73cddc12c3c2 100644
> > > --- a/arch/arm64/mm/ptdump_debugfs.c
> > > +++ b/arch/arm64/mm/ptdump_debugfs.c
> > > @@ -16,3 +16,21 @@ void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> > >  {
> > >  	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
> > >  }
> > > +
> > > +static int check_wx_debugfs_set(void *data, u64 val)
> > > +{
> > > +	if (val != 1ULL)
> > > +		return -EINVAL;
> > > +
> > > +	ptdump_check_wx();
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
> > > +
> > > +int ptdump_check_wx_init(void)
> > > +{
> > > +	return debugfs_create_file("check_wx_pages", 0200, NULL,
> > > +				   NULL, &check_wx_fops) ? 0 : -ENOMEM;
> > > +}
> > > -- 
> > > 2.20.1
> > > 
> 
> -- 
> Kees Cook
