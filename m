Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A57A7ACC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfG3PvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3PvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:51:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458572089E;
        Tue, 30 Jul 2019 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501874;
        bh=+zIKgxWzgm9vej6ra4Vrdj4C+Vws8RdPp548Vt9jqJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRp7dl4N9C23i9nkZO/6b5gQnMGXnLsDBSGNsIuy6d/60n2Rmrj7tnHJ6aEtEG/bj
         HGJyiYRxytRdR7Y6nGrKEemnenN36Byyx4ohGe2l3fFqmaIYjBG1S8L//Kt7/ynOUV
         QUl+nXffUP+Nhlcu53dCEiyTxbcKSy6MDjYeDjeQ=
Date:   Tue, 30 Jul 2019 17:51:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/24] tty: serial: fsl_lpuart: Drop unnecessary
 sg_set_buf() call
Message-ID: <20190730155112.GA11837@kroah.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-7-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729195226.8862-7-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:52:08PM -0700, Andrey Smirnov wrote:
> Sg_init_one() will already call sg_set_buf(), so another explicit call
> right after it is unnecessary. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-imx@nxp.com
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/tty/serial/fsl_lpuart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 1b3f2a87e558..b600f591c8c2 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1144,7 +1144,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  		return -ENOMEM;
>  
>  	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
> -	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
>  	nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>  
>  	if (!nent) {

This patch doesn't apply, is it already in the tree from someone else?

thanks,

greg k-h
