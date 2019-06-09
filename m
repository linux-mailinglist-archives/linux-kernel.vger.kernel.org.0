Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A606B3A4D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfFIKpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 06:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfFIKpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:45:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102AC2070B;
        Sun,  9 Jun 2019 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560077142;
        bh=iyzGTsUWW55gkRVtB+pFp4GxvLgteEbjoCT83KVsi/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdt4DzQYcbJzghLA/iZcCAO45d8Knt7ZjIzD6pvZvttVv4BHjg2REY0K9BG1GGqN5
         GmDbdlaeOKN7BVoYkbNwivgKqva9TnqqsGH4fdlcQBEDU1oBehyo7fdkbqilxkf1Ob
         OegeBjjrhnV9cdTxbd4CEsKxzp641BsZDmAVoR14=
Date:   Sun, 9 Jun 2019 12:45:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: move common code to macro
Message-ID: <20190609104540.GB7328@kroah.com>
References: <20190609103232.GA9769@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609103232.GA9769@hari-Inspiron-1545>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 04:02:32PM +0530, Hariprasad Kelam wrote:
> 
>     As part of halbtc8723b2ant_TdmaDurationAdjust function below
>     piece of code is used many times.
> 
>     halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, val);
>     pCoexDm->psTdmaDuAdjType = val;
> 
>     This patch replaces this common code with MACRO
>     HAL_BTC8723B2ANT_DMA_DURATION_ADJUST

Why is all of this indented?  And line-wrapped at an odd column?  Please
use at lines around 72 characters long.

> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c | 746 ++++++++++--------------
>  1 file changed, 293 insertions(+), 453 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> index cb62fc0..56d842e 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
> @@ -7,6 +7,13 @@
>  
>  #include "Mp_Precomp.h"
>  
> +/* defines */
> +#define HAL_BTC8723B2ANT_DMA_DURATION_ADJUST(val)			      \
> +do {									      \
> +	halbtc8723b2ant_PsTdma(pBtCoexist, NORMAL_EXEC, true, val);           \
> +	pCoexDm->psTdmaDuAdjType = val;                                       \
> +} while (0)

The goal is to move away from crazy macros, not add new ones :)

But this does make the code a lot simpler, so it's ok.  But please fix
up the changelog text and resend.

thanks,

greg k-h
