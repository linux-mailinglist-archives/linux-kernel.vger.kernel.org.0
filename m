Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3623C57F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404544AbfFKH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 03:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbfFKH7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:59:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66792208E3;
        Tue, 11 Jun 2019 07:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560239975;
        bh=gEmflHAXoERrFUUWDexuM33jdVCK7mALVzCF+SUK09Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjDH/xpt5bSYKiQeOSD/MC/vx/r8NMPMKv6TWaK1UtN65ADQF7JeuEbM0Xn4rGp20
         dpnZnCOJGyBuqBjtA9+GsKucpKuWX2Ea7Vvt3CK5hHCvYqy00j+TVLel0v/rAecG17
         M1wIbzCsV//hZrtOo7QcwnIdSNYRu1Sbp/T2qJRk=
Date:   Tue, 11 Jun 2019 09:59:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190611075933.GB13408@kroah.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
 <20190611055045.15945-9-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611055045.15945-9-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:50:45AM +0300, Oded Gabbay wrote:
> --- a/drivers/misc/habanalabs/habanalabs_drv.c
> +++ b/drivers/misc/habanalabs/habanalabs_drv.c
> @@ -28,6 +28,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
>  
>  static int timeout_locked = 5;
>  static int reset_on_lockup = 1;
> +static int power9_64bit_dma_enable;
>  
>  module_param(timeout_locked, int, 0444);
>  MODULE_PARM_DESC(timeout_locked,
> @@ -37,6 +38,10 @@ module_param(reset_on_lockup, int, 0444);
>  MODULE_PARM_DESC(reset_on_lockup,
>  	"Do device reset on lockup (0 = no, 1 = yes, default yes)");
>  
> +module_param(power9_64bit_dma_enable, int, 0444);
> +MODULE_PARM_DESC(power9_64bit_dma_enable,
> +	"Enable 64-bit DMA mask. Should be set only in POWER9 machine (0 = no, 1 = yes, default no)");
> +
>  #define PCI_VENDOR_ID_HABANALABS	0x1da3
>  
>  #define PCI_IDS_GOYA			0x0001


This is not the 1990's, please do not use module parameters.  Yeah, you
have a bunch of them already, but do not add additional ones that can be
easily determined at runtime, like this one.

thanks,

greg k-h
