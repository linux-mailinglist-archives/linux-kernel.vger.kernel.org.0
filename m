Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251142D7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2IfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfE2IfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:35:00 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FF8920665;
        Wed, 29 May 2019 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559118899;
        bh=PwMHl6kzXAgZU6O8Wb+qU/u156Ml30/pnf+ppc3VTXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmLYSOLViieq+93kZwIToL1XKoluaLJxjU4GV+LyPIXUDM3P89DDRuH+XWzGEncGt
         /atHE3S7b1Ly3ABGq+7P6bWPYxxKBW5W+WCuxH3oykDv6qL3L6Qf5IxVHei+2vgcf3
         RhV/6clg6PbTV4GWS7xqBRpXjndvOXUwCqD3G0bc=
Date:   Wed, 29 May 2019 01:34:59 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     airlied@linux.ie, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] amd64-agp: fix arbitrary kernel memory writes
Message-ID: <20190529083459.GA1936@kroah.com>
References: <1559105521-27053-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559105521-27053-1-git-send-email-92siuyang@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:52:01PM +0800, Young Xiao wrote:
> pg_start is copied from userspace on AGPIOC_BIND and AGPIOC_UNBIND ioctl
> cmds of agp_ioctl() and passed to agpioc_bind_wrap().  As said in the
> comment, (pg_start + mem->page_count) may wrap in case of AGPIOC_BIND,
> and it is not checked at all in case of AGPIOC_UNBIND.  As a result, user
> with sufficient privileges (usually "video" group) may generate either
> local DoS or privilege escalation.
> 
> See commit 194b3da873fd ("agp: fix arbitrary kernel memory writes")
> for details.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/char/agp/amd64-agp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index c69e39f..5daa0e3 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -60,7 +60,8 @@ static int amd64_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
>  
>  	/* Make sure we can fit the range in the gatt table. */
>  	/* FIXME: could wrap */
> -	if (((unsigned long)pg_start + mem->page_count) > num_entries)
> +	if (((pg_start + mem->page_count) > num_entries) ||
> +	    ((pg_start + mem->page_count) < pg_start))

Why did you take off the cast for the first test?

And if this really does fix this issue, should you remove the FIXME
line?

thanks,

greg k-h
