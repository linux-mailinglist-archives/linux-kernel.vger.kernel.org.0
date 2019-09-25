Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E240BDF22
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406676AbfIYNi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 09:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406057AbfIYNi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:38:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0812146E;
        Wed, 25 Sep 2019 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569418708;
        bh=nz2r43778u7sfnI6CaMK0ADS1GXFkn20EezdpVQkkcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SF+6M42HvtsxE3dBrenPEAErd+UgnKRlYWWf+NxekW6xuJMD0vFYLhVHoiwJ74FsN
         smbVIXCIZak++6swKZg2/lE5w2o7XC7Kfh6leE8+GDAWuWWHvPY+0kiFCZ7bN2RbHk
         qJNgw+mXBGWhrvZjqmeyrYDcLcPrCAJLo4xnHOeo=
Date:   Wed, 25 Sep 2019 15:38:26 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     bvanassche@acm.org, bhelgaas@google.com, dsterba@suse.com,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        alexander.h.duyck@linux.intel.com, sakari.ailus@linux.intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
Message-ID: <20190925133826.GA1496885@kroah.com>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:52:26PM +0800, Yunfeng Ye wrote:
> It's not necessary to put kfree() in the critical area of the lock, so
> let it out.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
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
>  }
> -- 
> 2.7.4
> 

Does this result any any measurable performance changes?

thanks,

greg k-h
