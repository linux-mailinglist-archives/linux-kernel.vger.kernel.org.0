Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54E167973
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgBUJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 04:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgBUJcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:32:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0991720722;
        Fri, 21 Feb 2020 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582277573;
        bh=G4BWbdqWgqHFB1vkSMV5GmPqtmPSg9T3gpSeqLcAYsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLN0eLpYfl8hy2hEwzb08K4iT2od9gFOzpN8bv1ooPZxOor7mSzbjdLJUv9xmaUuL
         lBkm7pXcqu4Il7LT9/TK7eRQ3R8PWrsMfu1psLYMuhRsGb35MJ1xSHva/Oic/BR5Cz
         vuP7eOKvuIGbEbpv9vDXYY9eyZ8hRK1SaUV7hiVg=
Date:   Fri, 21 Feb 2020 10:32:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] vt: selection, remove 2 local variables from
 set_selection_kernel
Message-ID: <20200221093251.GA90355@kroah.com>
References: <20200219073951.16151-1-jslaby@suse.cz>
 <20200219073951.16151-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219073951.16151-3-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 08:39:45AM +0100, Jiri Slaby wrote:
> multiplier and mode are not actually needed:
> * multiplier is used only in kmalloc_array, so use "use_unicode ? 4 : 1"
>   directly
> * mode is used only to assign a bool in this manner:
>   if (cond)
>     x = true;
>   else
>     x = false;
>   So do "x = cond" directly.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/vt/selection.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 714992693974..6541c09d8bba 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -191,9 +191,9 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
>  	struct vc_data *vc = vc_cons[fg_console].d;
>  	int new_sel_start, new_sel_end, spc;
>  	char *bp, *obp;
> -	int i, ps, pe, multiplier;
> +	int i, ps, pe;
>  	u32 c;
> -	int mode, ret = 0;
> +	int ret = 0;
>  
>  	poke_blanked_console();
>  
> @@ -224,11 +224,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
>  		clear_selection();
>  		sel_cons = vc_cons[fg_console].d;
>  	}
> -	mode = vt_do_kdgkbmode(fg_console);
> -	if (mode == K_UNICODE)
> -		use_unicode = 1;
> -	else
> -		use_unicode = 0;
> +	use_unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
>  
>  	switch (v->sel_mode)
>  	{
> @@ -312,8 +308,8 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
>  	sel_end = new_sel_end;
>  
>  	/* Allocate a new buffer before freeing the old one ... */
> -	multiplier = use_unicode ? 4 : 1;  /* chars can take up to 4 bytes */
> -	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, multiplier,
> +	/* chars can take up to 4 bytes with unicode */
> +	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, use_unicode ? 4 : 1,
>  			   GFP_KERNEL);
>  	if (!bp) {
>  		printk(KERN_WARNING "selection: kmalloc() failed\n");
> -- 
> 2.25.0
> 

This patch fails to apply to my tree, so I stopped here.  Can you rebase
and resend the rest of these?

thanks,

greg k-h
