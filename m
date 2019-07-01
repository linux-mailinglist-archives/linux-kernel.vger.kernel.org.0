Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B9AF1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfD3HvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 03:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3HvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:51:13 -0400
Received: from linux-8ccs (unknown [95.90.219.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C79A20835;
        Tue, 30 Apr 2019 07:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556610672;
        bh=wYko4k9enIB2pNsP3VANKP6hvZL2c+kCSOeRtqgooLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gxo8Wm/J96X+SHMnvlPUQIYI2PGgm6KIqsSkwYVCShxR19EYl2X0HZ41dCILHMzcE
         Ok8hJ9c7TMkZaGOc6f2QaBWRhn1+GTJ7jq7hXCLA0gayxL4rNuOVrCz/0KSvFQIZUB
         d8H/0wEJ1BOWK85h0zh6yYocojLO0Ft5y0e/jdok=
Date:   Tue, 30 Apr 2019 09:51:08 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Reschedule while waiting for modules to
 finish loading
Message-ID: <20190430075108.GA21092@linux-8ccs>
References: <20190429151751.15424-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190429151751.15424-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [29/04/19 11:17 -0400]:
>Heiko, do you want a Signed-off-by or a Reported-by?  Either one works
>for me.
>
>P.

I think you forgot to CC Heiko :)

>----8<----
>
>On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>loading the s390_trng.ko module.
>
>Add a reschedule point to the loop that waits for modules to complete
>loading.
>
>Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>---
> kernel/module.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 410eeb7e4f1d..48748cfec991 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3585,6 +3585,7 @@ static int add_unformed_module(struct module *mod)
> 					       finished_loading(mod->name));
> 			if (err)
> 				goto out_unlocked;
>+			cond_resched();
> 			goto again;
> 		}
> 		err = -EEXIST;
>-- 
>2.18.1
>
