Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E3F5E14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfKIIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 03:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfKIIgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 03:36:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4ECC21848;
        Sat,  9 Nov 2019 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573288570;
        bh=Twvv3SnCCHk7pjSt9HqENuPTFyAh/jYwa0AK4ACbBLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JL2Pj0EnPAF/mh6hgPfwfrsqjFJomnaurivpy3Vz/op1tZu24nWW91vRVpJwpkEL
         Nl7AJLoGanUHv9kpY8U/ehsJ8QIS1c/89SSQ1wjdg4mqgAuRBtH/dDd/sbfdy+coN1
         bwmT7ySi2SNsMQfbmLq82gimKPOsk6SILKF+XKDI=
Date:   Sat, 9 Nov 2019 09:36:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     devel@driverdev.osuosl.org, Boqun.Feng@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: add gcc extension __force cast
Message-ID: <20191109083607.GB1289162@kroah.com>
References: <20191108233837.33378-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108233837.33378-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 11:38:37PM +0000, Jules Irenge wrote:
> Add gcc extension __force and __le32 cast to fix warning issued by Sparse tool."warning: cast to restricted __le32"

Can you wrap your lines properly please?

> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/wfx/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
> index 0a9ca109039c..aa7b2dd691b9 100644
> --- a/drivers/staging/wfx/debug.c
> +++ b/drivers/staging/wfx/debug.c
> @@ -72,7 +72,7 @@ static int wfx_counters_show(struct seq_file *seq, void *v)
>  		return -EIO;
>  
>  #define PUT_COUNTER(name) \
> -	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu(counters.count_##name))
> +	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu((__force __le32)(counters.count_##name)))

That's usually a huge hint that something is wrong here.  If the data
type isn't already le32, then why is the data needed to be printed out
that way?  Shouldn't the data type itself be fixed instead?

thanks,

greg k-h
