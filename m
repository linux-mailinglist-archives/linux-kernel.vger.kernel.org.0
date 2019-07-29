Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA37890D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfG2KAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 06:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfG2KAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:00:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C2A206DD;
        Mon, 29 Jul 2019 10:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564394447;
        bh=tjmolPTc29GDDlVhstCNDA965qRQR0mrcfv5TkVOaFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsDvFPrF529TTN8MIbJOaN82wViv22NBjZWqnAsx+Bh45mXqyaWBJkJi7TVimrTyL
         lgQVUnE36Use4y1D19Q2hwjtIa4r13QaMmQHwLUcWU7RIWeqsSw3/KEHVw/8IJIm9o
         vWJ0CWp9c9GoI89K3RdNZkATAq0INKkD/PrHAry4=
Date:   Mon, 29 Jul 2019 11:00:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mark expected switch fall-through
Message-ID: <20190729100043.keo3kfsbgbbcthml@willie-the-truck>
References: <20190728230310.5924-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190728230310.5924-1-mcroce@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:03:10AM +0200, Matteo Croce wrote:
> Move the "fallthrough" comment just because the case keyword,
> fixes the following warning:
> 
> In file included from ./include/linux/kernel.h:15,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/kobject.h:19,
>                  from ./include/linux/of.h:17,
>                  from ./include/linux/irqdomain.h:35,
>                  from ./include/linux/acpi.h:13,
>                  from arch/arm64/kernel/smp.c:9:
> arch/arm64/kernel/smp.c: In function ‘__cpu_up’:
> ./include/linux/printk.h:302:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/smp.c:156:4: note: in expansion of macro ‘pr_crit’
>     pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
>     ^~~~~~~
> arch/arm64/kernel/smp.c:157:3: note: here
>    case CPU_STUCK_IN_KERNEL:
>    ^~~~
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed via [1]. Please can you people work together?

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/668934.html
