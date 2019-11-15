Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B25FE4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKOScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 13:32:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44376 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:32:48 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVgOR-0005QE-69; Fri, 15 Nov 2019 19:32:27 +0100
Date:   Fri, 15 Nov 2019 19:32:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     Bart Van Assche <bvanassche@acm.org>, dsterba@suse.cz,
        bhelgaas@google.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sakari.ailus@linux.intel.com,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] async: Let kfree() out of the critical area of the
 lock
In-Reply-To: <9bfecf17-3c1b-414e-b271-4fd2d884faa3@huawei.com>
Message-ID: <alpine.DEB.2.21.1911151931420.28787@nanos.tec.linutronix.de>
References: <ae3b790d-9883-0ec0-425d-5ac9b32c2d0f@huawei.com> <9bfecf17-3c1b-414e-b271-4fd2d884faa3@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Oct 2019, Yunfeng Ye wrote:

> The async_lock is big global lock, and kfree() is not always cheap, it
> will increase lock contention. it's better let kfree() outside the lock
> to keep the critical area as short as possible.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> v1 -> v2:
>  - update the description
>  - add "Reviewed-by"
> 
>  kernel/async.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/async.c b/kernel/async.c
> index 4f9c1d6..1de270d 100644
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -135,12 +135,12 @@ static void async_run_entry_fn(struct work_struct *work)
>  	list_del_init(&entry->domain_list);
>  	list_del_init(&entry->global_list);
> 
> -	/* 3) free the entry */
> -	kfree(entry);
>  	atomic_dec(&entry_count);
> -
>  	spin_unlock_irqrestore(&async_lock, flags);
> 
> +	/* 3) free the entry */
> +	kfree(entry);
> +
>  	/* 4) wake up any waiters */
>  	wake_up(&async_done);

The wakeup should happen before the kfree() for the very same reasons.

Thanks,

	tglx
