Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43FA3A08E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfFHPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 11:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfFHPyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 11:54:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E41206BB;
        Sat,  8 Jun 2019 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560009265;
        bh=ElnzDAEFn4MUM1anVmb+KmIFjKIN8D1mTWC/VbPHVFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/n4xxM3Rp3gegB8+XRT6415lAH/dbd0qIuvF0xWtOHUF0VDPnRNFWiXa8CvjDD+w
         U/dqwFhotQa1I5kp9UQQAjnJKRxpixstjfClZqSdKbgyJHJtzbCtxAMmeJI2cGuA49
         BDzVuTEMxN1PmdXcV8jNybt33nF9dQPS1DtCy6CU=
Date:   Sat, 8 Jun 2019 17:54:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xabi1500@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rts5208: fixed brace coding style issue
Message-ID: <20190608155422.GB7974@kroah.com>
References: <20190608135335.6383-1-xabi1500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608135335.6383-1-xabi1500@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 03:53:35PM +0200, xabi1500@gmail.com wrote:
> From: Xabier Etxezarreta <xabi1500@gmail.com>
> 
> Fixed a coding style issue checked with checkpatch.pl
> 
> Signed-off-by: Xabier Etxezarreta <xabi1500@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index fa597953e9a0..d16e92b09a1f 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -419,10 +419,7 @@ static int rtsx_control_thread(void *__dev)
>  				chip->srb->device->id,
>  				(u8)chip->srb->device->lun);
>  			chip->srb->result = DID_BAD_TARGET << 16;
> -		}
> -
> -		/* we've got a command, let's do it! */
> -		else {
> +		} else { /* we've got a command, let's do it! */
>  			scsi_show_command(chip);

Comment should go on a new line.

thanks,

greg k-h
