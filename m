Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC63B893
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391327AbfFJPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 11:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390550AbfFJPw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:52:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070FC20645;
        Mon, 10 Jun 2019 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560181947;
        bh=S3Obzl9/JbERIVLJS+8FiZLzxXxktH57EXPHyk4KrWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tn8ocLbtJ1owt61rmDtkXtCsozbgkupVgQ6ub8pBef5Q8gjH9+KqOm95BozK5NuuR
         UdBYr5jYXTP2B9WsplBeCCUnNHFwlyiNF74AHRdPVu+rkcdzHFTxTrZf1oGENnwJT8
         WuLuwi3mE6XbGdx/ejXGqPDTsLidfekmxXnMeOt4=
Date:   Mon, 10 Jun 2019 17:52:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Xu <haoxu.linuxkernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: kpc2000: kpc_i2c: remove the macros inb_p
 and outb_p
Message-ID: <20190610155225.GB29035@kroah.com>
References: <1560152904-31894-1-git-send-email-haoxu.linuxkernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560152904-31894-1-git-send-email-haoxu.linuxkernel@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:48:24PM +0800, Hao Xu wrote:
> remove inb_p and outb_p to call readq/writeq directly.
> 
> Signed-off-by: Hao Xu <haoxu.linuxkernel@gmail.com>
> ---
> Changes in v2:
> - remove the macros inb_p/outb_p and use readq/writeq directly, per https://lkml.kernel.org/lkml/20190608134505.GA963@arch-01.home/
> ---
>  drivers/staging/kpc2000/kpc2000_i2c.c | 112 ++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
> index 69e8773..246d5b3 100644
> --- a/drivers/staging/kpc2000/kpc2000_i2c.c
> +++ b/drivers/staging/kpc2000/kpc2000_i2c.c
> @@ -122,12 +122,6 @@ struct i2c_device {
>  /* Not really a feature, but it's convenient to handle it as such */
>  #define FEATURE_IDF             BIT(15)
>  
> -// FIXME!
> -#undef inb_p
> -#define inb_p(a) readq((void *)a)
> -#undef outb_p
> -#define outb_p(d, a) writeq(d, (void *)a)
> -
>  /* Make sure the SMBus host is ready to start transmitting.
>   * Return 0 if it is, -EBUSY if it is not.
>   */
> @@ -135,7 +129,7 @@ static int i801_check_pre(struct i2c_device *priv)
>  {
>  	int status;
>  
> -	status = inb_p(SMBHSTSTS(priv));
> +	status = readq((void *)SMBHSTSTS(priv));

Ugh, all of the void * casting, is is really needed everywhere?  That
just makes everything a mess...

thanks,

greg k-h
