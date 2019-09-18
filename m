Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC4B6AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbfIRSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 14:39:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54366 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725899AbfIRSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:39:53 -0400
Received: (qmail 7207 invoked by uid 2102); 18 Sep 2019 14:39:52 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2019 14:39:52 -0400
Date:   Wed, 18 Sep 2019 14:39:52 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Matthias Maennich <maennich@google.com>
cc:     linux-kernel@vger.kernel.org, <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH v2] usb-storage: SCSI glue: use pr_fmt and pr_err
In-Reply-To: <20190918175304.219849-1-maennich@google.com>
Message-ID: <Pine.LNX.4.44L0.1909181438440.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Matthias Maennich wrote:

> Follow common practice and retire printk(KERN_ERR ...) in favor of
> pr_fmt and dev_err().
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: usb-storage@lists.one-eyed-alien.net
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  drivers/usb/storage/scsiglue.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index 6737fab94959..afc4e3221369 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -28,6 +28,8 @@
>   * status of a command.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

What's this here for?

Alan Stern

>  #include <linux/blkdev.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
> @@ -379,8 +381,8 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
>  
>  	/* check for state-transition errors */
>  	if (us->srb != NULL) {
> -		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
> -			__func__, us->srb);
> +		dev_err(&us->pusb_intf->dev,
> +			"Error in %s: us->srb = %p\n", __func__, us->srb);
>  		return SCSI_MLQUEUE_HOST_BUSY;
>  	}
>  
> 


