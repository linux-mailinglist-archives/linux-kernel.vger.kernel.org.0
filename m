Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7895F6AB7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfKJSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 13:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfKJSSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:18:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4EBA20818;
        Sun, 10 Nov 2019 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573409916;
        bh=NUjOCkuG6s+MO4FrRDCYkQ+eHMNeT2BDZrcgnAiwmxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAHgbwyEKyinD2nPXs6VehJUiWWdj5AHc06EAml+gLtqWha0YeNBNCz9SubjMFxw8
         n1urBw6M/vDe590m13nAN1CdKh/LrG0TzT5zaaN44ScNaLCfITrTYB1oH+GQytO1/A
         +E9oHL21XvsfZtW59RsHKO1h8EYHzV5j3AG30MO8=
Date:   Sun, 10 Nov 2019 19:18:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] lkdtm: Remove set but not used variable 'byte'
Message-ID: <20191110181833.GA3088811@kroah.com>
References: <20191110092249.182210-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110092249.182210-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 05:22:49PM +0800, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_LEADING:
> drivers/misc/lkdtm/bugs.c:236:25: warning: variable byte set but not used [-Wunused-but-set-variable]
> drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_TRAILING:
> drivers/misc/lkdtm/bugs.c:250:25: warning: variable byte set but not used [-Wunused-but-set-variable]
> 
> byte is never used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/misc/lkdtm/bugs.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 7284a22b1a09..fcd943725b66 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -249,12 +249,9 @@ void lkdtm_STACK_GUARD_PAGE_LEADING(void)
>  {
>  	const unsigned char *stack = task_stack_page(current);
>  	const unsigned char *ptr = stack - 1;
> -	volatile unsigned char byte;
>  
>  	pr_info("attempting bad read from page below current stack\n");
>  
> -	byte = *ptr;
> -

You do realize just what this code is trying to do _is_ a bug, so it's
ok to leave it, right?  You just broke the code here with your change as
you are trying to "fix" it :)

thanks,

greg k-h
