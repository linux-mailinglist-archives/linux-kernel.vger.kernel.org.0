Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1CF2A81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfKGJYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:24:48 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49520 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKGJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/G1GEDLhPKjhMsQBLJzbxhUOUWxoYe3bO4Cg8QUdDA=; b=a4RHWOxeKTocGLXwlV+YBajKb
        xvOQJpj9mY9NRqOyxpli/TBZM4fhYnDhV+f9h/3fYQleTVOoXVA8aG0YmtbeEo1ybWkPh2M0asFBc
        f0u3AnkatWgxFt3kXJkxyzCkh+XcjCNAx7bqbXvwfZSJBnYs0aGiNGknBaMpL0jMvjvbfVi3kfT7i
        76O+GnoVcRuwu9eK4O9k+7NL7NHZ4TOtfFqdrOY2X4TuoXLL/rlvo+lN29KSWgJ9gxHcMNApZsN6q
        zqLQ+vWIYIbqTz1q6cgtLzPhRTyPAvGHaQgNag8rPhynN5qS8tH8k4TA3N89gbR4Pbqi84qvyotc7
        ebxQai80g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36372)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iSe1V-0002Wx-GV; Thu, 07 Nov 2019 09:24:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iSe1M-0004tP-DR; Thu, 07 Nov 2019 09:24:04 +0000
Date:   Thu, 7 Nov 2019 09:24:04 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lvqiang <Lvqiang.Huang@unisoc.com>
Cc:     ebiederm@xmission.com, dave.hansen@linux.intel.com,
        anshuman.khandual@arm.com, akpm@linux-foundation.org,
        f.fainelli@gmail.com, will@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: check __ex_table in do_bad()
Message-ID: <20191107092404.GV25745@shell.armlinux.org.uk>
References: <1573112713-10115-1-git-send-email-Lvqiang.Huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573112713-10115-1-git-send-email-Lvqiang.Huang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 03:45:13PM +0800, Lvqiang wrote:
> 
> We got many crashs in for_each_frame+0x18 arch/arm/lib/backtrace.S
>     1003: ldr r2, [sv_pc, #-4]
> 
> The backtrace is
>     dump_backtrace
>     show_stack
>     sched_show_task
>     show_state_filter
>     sysrq_handle_showstate_blocked
>     __handle_sysrq
>     write_sysrq_trigger
>     proc_reg_write
>     __vfs_write
>     vfs_write
>     sys_write
> 
> Related Kernel config
>     CONFIG_CPU_SW_DOMAIN_PAN=y
>     # CONFIG_ARM_UNWIND is not set
>     CONFIG_FRAME_POINTER=y
> 
> The task A was dumping the stack of an UN task B. However, the task B

What is "an UN task B"?

> scheduled to run on another CPU, which cause it stack content changed.
> Then, task A may hit a page domain fault and die().
>     [520.661314] Unhandled fault: page domain fault (0x01b) at 0x32848c02

So, the backtrace code is trying to access userspace.  It isn't supposed
to be accessing userspace - there are no guarantees that userspace will
be using frame pointers.  That is the bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
