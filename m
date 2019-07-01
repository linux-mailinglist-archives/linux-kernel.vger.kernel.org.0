Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9B47DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfFQI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 04:58:53 -0400
Received: from foss.arm.com ([217.140.110.172]:42176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfFQI6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:58:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E397028;
        Mon, 17 Jun 2019 01:58:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652F03F246;
        Mon, 17 Jun 2019 01:58:52 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:58:50 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: build warnings after merge of the clockevents tree
Message-ID: <20190617085850.GH20984@e119886-lin.cambridge.arm.com>
References: <20190617145245.0e03163d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617145245.0e03163d@canb.auug.org.au>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:52:45PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the clockevents tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
> 
> In file included from arch/arm/kernel/vdso.c:30:
> arch/arm/include/asm/arch_timer.h: In function 'arch_timer_set_evtstrm_feature':
> arch/arm/include/asm/arch_timer.h:131:1: warning: no return statement in function returning non-void [-Wreturn-type]
>  }
>  ^
> In file included from drivers/clocksource/arm_arch_timer.c:31:
> arch/arm/include/asm/arch_timer.h: In function 'arch_timer_set_evtstrm_feature':
> arch/arm/include/asm/arch_timer.h:131:1: warning: no return statement in function returning non-void [-Wreturn-type]
>  }
>  ^
> 
> Introduced by commit
> 
>   11e34eca5d0a ("clocksource/arm_arch_timer: Extract elf_hwcap use to arch-helper")

This was also picked up by the kbuild robot, I'll sent a patch shortly - apologies.

Thanks,

Andrew Murray

> 
> Look like a missed "return".
> 
> -- 
> Cheers,
> Stephen Rothwell


