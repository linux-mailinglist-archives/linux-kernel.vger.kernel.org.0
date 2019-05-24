Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E267A2915E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfEXG4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbfEXG4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:56:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F942175B;
        Fri, 24 May 2019 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558681002;
        bh=FA4M8vJJFV2aQxmdFWUvZdPWcG4pmFsPpZkZ3k4P+c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdAY8qSUf9wR5mTiV6JI7bDoMIXPV/2VLlmW7AvuaBsR6OmgbLBROXyhhIJKEw/wh
         B7fOp8gZmigTXnq8l0bOgtBnameH2PU+4FhXjm5kPB4ixqh1xya7Nrelq6rxa8z94Y
         o3mb7Fhuwic1o3BEYkj2cmf2HrD+u8hekXT5y8Co=
Date:   Fri, 24 May 2019 08:56:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     thesven73@gmail.com, hofrat@osadl.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove variables
Message-ID: <20190524065640.GD3600@kroah.com>
References: <20190524060328.3827-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524060328.3827-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:33:28AM +0530, Nishka Dasgupta wrote:
> The local variable cd, used in multiple functions, is immediately passed
> to another function call, whose result is returned. As that is the only
> use of cd, it can be replaced with its variable.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/fieldbus/anybuss/host.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Your subject line might say:
	"remove unneeded temporary variables"
or something like that?

> 
> diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
> index f69dc4930457..9679cd0b737b 100644
> --- a/drivers/staging/fieldbus/anybuss/host.c
> +++ b/drivers/staging/fieldbus/anybuss/host.c
> @@ -1046,10 +1046,8 @@ EXPORT_SYMBOL_GPL(anybuss_start_init);
>  
>  int anybuss_finish_init(struct anybuss_client *client)
>  {
> -	struct anybuss_host *cd = client->host;
> -
> -	return _anybus_mbox_cmd(cd, CMD_END_INIT, false, NULL, 0,
> -					NULL, 0, NULL, 0);
> +	return _anybus_mbox_cmd(client->host, CMD_END_INIT, false, NULL, 0,
> +				NULL, 0, NULL, 0);
>  }

While a potential change, this really doesn't help anything be it object
code size, or make anything easier to understand.

Again, don't change things just because a tool said it could be changed,
think about what you are doing and why it would, or would not, be
something that is worth doing.

thanks,

greg k-h
