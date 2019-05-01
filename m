Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB3105EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEAHtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 03:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfEAHtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 03:49:05 -0400
Received: from linux-8ccs (ip5f5ade58.dynamic.kabel-deutschland.de [95.90.222.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E161120835;
        Wed,  1 May 2019 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556696944;
        bh=T7T/LYH0oG6Mc669/vIbBfSwXFvp8DN+Ci6R4EJ8Qn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz5ZywLQtC5O4MQJgeBS7YOcoYeVeHsk+DL/bwKbOfvzXsrel5rxxDm2pzWIm2yAN
         dBA8E7qK7EfaCFd1HInwQci20NcAAH8osWtQusbk1xKb0pGZ1yZh0IasTNeV/g/PHd
         bFhrdLjYHakCsLHmG7Ym1QFbgYvBeTbYCoostYYM=
Date:   Wed, 1 May 2019 09:49:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3] kernel/module: Reschedule while waiting for modules
 to finish loading
Message-ID: <20190501074900.GA10762@linux-8ccs>
References: <20190430222207.3002-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190430222207.3002-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [30/04/19 18:22 -0400]:
>On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>loading the s390_trng.ko module.
>
>Add a reschedule point to the loop that waits for modules to complete
>loading.
>
>v3: cleanup Fixes line.

Thanks, this patch has been re-applied to modules-next.

Jessica

>Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>Fixes: f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
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
