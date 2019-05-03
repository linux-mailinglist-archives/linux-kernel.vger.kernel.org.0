Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3C131D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfECQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:05:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfECQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FTFiUSSV2ElfGaJcHHBVJkPSE+Zxkjl/EpFRL2fm7FY=; b=faIKOUYZnwbeLnk9HcxF4Q3tx
        Rfb1JiZ3kL6YoDbor2Pk2lu3Ln3yKVwhYgOzFw5684L+Nl9YfGeGuWP8N/6juZIsvBIBM2EsfNo22
        lLMCj87aEsw2CawjQgZ50SxvBFpVCYcgiW4C9zSY//mIGGTSOKPHZuWbTmFDBDdhgXgM80mHmvPVF
        DyzUQCileSdFcFqLq7YxB9VnRrcF1NNWry2qMUOcwsftFx2B+SM+exdbj/CU37lqtPybzYK+v9lSO
        qLauMrAkBuiLm1c6kIbHVwxe/ZaMmvPo6ZYI0g7nMFvE3S+vuThb7YfJiAHOcjrDcUBtR4fZV+lEm
        jlT2+fM0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMagG-0001dL-55; Fri, 03 May 2019 16:05:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3611329ABBCFC; Fri,  3 May 2019 18:04:58 +0200 (CEST)
Date:   Fri, 3 May 2019 18:04:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:sched/core 24/27] kernel/power/suspend.c:431:10: error:
 implicit declaration of function 'suspend_disable_secondary_cpus'
Message-ID: <20190503160458.GF2606@hirez.programming.kicks-ass.net>
References: <201905032053.KmG848Ye%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905032053.KmG848Ye%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 08:34:57PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   65874bd36e6ae3028539e989bfb5c28ad457368e
> commit: c2cb30bfceceba8a2a0d5713230a250dd6140e22 [24/27] power/suspend: Add function to disable secondaries for suspend
> config: x86_64-randconfig-l3-05031806 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         git checkout c2cb30bfceceba8a2a0d5713230a250dd6140e22
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 

The below appears to fix.


--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -150,6 +150,8 @@ static inline void suspend_enable_second
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
+static inline int suspend_disable_secondary_cpus(void) { return 0; }
+static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
 void cpu_startup_entry(enum cpuhp_state state);
