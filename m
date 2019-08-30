Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9514A37FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfH3Nsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 09:48:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34792 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfH3Nsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3eifwY/5zE6nCnZ1a23bExwsvLi8xvyrQfUlmgCq+N4=; b=SWf/M74KjJGQ+0qWoqQqqcu/w
        FdcY9GuJkV90qZPrxiZiQbScX4eNkPxI/XUimR/iQAEKiTTRHRyftu5Aw4GEeang1af1Gjr63bPv3
        VCTseUldgs7tZ8IQM+7kHxg0HCnZhfEq4mLuZpFfVo9fcDQIQBj1vDGa8ZEQoJWP6PR5AqO7Vmy6k
        0RHCdl4ZYHq+GAcpvpCywSCYWwwamwfooWieT9BSAJB3CtIvcZWh9IQgfeDuy50iRy/atY/PMg4Cf
        TsdL2hglDBsMbYD7IeIyHnsvTyYLIa+l8Sf2QW01GvtTHwh4jw4S4Y2HLnArfOD4hwy/LCIroRIZT
        cNA3Kv3ng==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:35310)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i3hGR-00079z-DU; Fri, 30 Aug 2019 14:48:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i3hGP-0000BO-2I; Fri, 30 Aug 2019 14:48:29 +0100
Date:   Fri, 30 Aug 2019 14:48:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     kstewart@linuxfoundation.org, gustavo@embeddedor.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ebiederm@xmission.com,
        sakari.ailus@linux.intel.com, bhelgaas@google.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: fix page faults in do_alignment
Message-ID: <20190830134828.GC13294@shell.armlinux.org.uk>
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
 <20190830133522.GZ13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830133522.GZ13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix your email.

  jingxiangfeng@huawei.com
      host mx7.huawei.com [168.195.93.46]
      SMTP error from remote mail server after pipelined DATA:
      554 5.7.1 spf check result is none

SPF is *not* required for email.

If you wish to impose such restrictions on email, then I reserve the
right to ignore your patches until this issue is resolved! ;)

On Fri, Aug 30, 2019 at 02:35:22PM +0100, Russell King - ARM Linux admin wrote:
> On Fri, Aug 30, 2019 at 09:31:17PM +0800, Jing Xiangfeng wrote:
> > The function do_alignment can handle misaligned address for user and
> > kernel space. If it is a userspace access, do_alignment may fail on
> > a low-memory situation, because page faults are disabled in
> > probe_kernel_address.
> > 
> > Fix this by using __copy_from_user stead of probe_kernel_address.
> > 
> > Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
> > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> 
> NAK.
> 
> The "scheduling while atomic warning in alignment handling code" is
> caused by fixing up the page fault while trying to handle the
> mis-alignment fault generated from an instruction in atomic context.
> 
> Your patch re-introduces that bug.
> 
> > ---
> >  arch/arm/mm/alignment.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> > index 04b3643..2ccabd3 100644
> > --- a/arch/arm/mm/alignment.c
> > +++ b/arch/arm/mm/alignment.c
> > @@ -774,6 +774,7 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
> >  	unsigned long instr = 0, instrptr;
> >  	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
> >  	unsigned int type;
> > +	mm_segment_t fs;
> >  	unsigned int fault;
> >  	u16 tinstr = 0;
> >  	int isize = 4;
> > @@ -784,16 +785,22 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
> >  
> >  	instrptr = instruction_pointer(regs);
> >  
> > +	fs = get_fs();
> > +	set_fs(KERNEL_DS);
> >  	if (thumb_mode(regs)) {
> >  		u16 *ptr = (u16 *)(instrptr & ~1);
> > -		fault = probe_kernel_address(ptr, tinstr);
> > +		fault = __copy_from_user(tinstr,
> > +				(__force const void __user *)ptr,
> > +				sizeof(tinstr));
> >  		tinstr = __mem_to_opcode_thumb16(tinstr);
> >  		if (!fault) {
> >  			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
> >  			    IS_T32(tinstr)) {
> >  				/* Thumb-2 32-bit */
> >  				u16 tinst2 = 0;
> > -				fault = probe_kernel_address(ptr + 1, tinst2);
> > +				fault = __copy_from_user(tinst2,
> > +						(__force const void __user *)(ptr+1),
> > +						sizeof(tinst2));
> >  				tinst2 = __mem_to_opcode_thumb16(tinst2);
> >  				instr = __opcode_thumb32_compose(tinstr, tinst2);
> >  				thumb2_32b = 1;
> > @@ -803,10 +810,13 @@ static ssize_t alignment_proc_write(struct file *file, const char __user *buffer
> >  			}
> >  		}
> >  	} else {
> > -		fault = probe_kernel_address((void *)instrptr, instr);
> > +		fault = __copy_from_user(instr,
> > +				(__force const void __user *)instrptr,
> > +				sizeof(instr));
> >  		instr = __mem_to_opcode_arm(instr);
> >  	}
> >  
> > +	set_fs(fs);
> >  	if (fault) {
> >  		type = TYPE_FAULT;
> >  		goto bad_or_fault;
> > -- 
> > 1.8.3.1
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
