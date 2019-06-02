Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8E32467
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFBRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 13:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfFBRMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:12:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA7527987;
        Sun,  2 Jun 2019 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559495559;
        bh=WTPRxtlnZL+Iczql6bjVJ2f4c1q4PvnKOxck9m+1wJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOo69b8zCSHtMRoIs/YEwnSU+uN2eg6dHwziQxhkl/UacLw6zvnkxoVbDUEHVoFtf
         87wl6XohkNTypy3gi8jDy1LaDf8WUMmk7GQpqy/0RcKJBu9A6jfA7cl5E56mbjXkZB
         w1oxHE87tSQCxIHVIXEYunkngYqNR5CPVA56FtZQ=
Date:   Sun, 2 Jun 2019 19:12:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: Re: [PATCH v2 4/9] staging: rtl8712: Fixed CamelCase renames
 evtThread to evt_thread
Message-ID: <20190602171236.GB19671@kroah.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
 <7f7b0e38b7f10f187ac4ad6eff8e0c1b47698258.1559470738.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7b0e38b7f10f187ac4ad6eff8e0c1b47698258.1559470738.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 03:55:33PM +0530, Deepak Mishra wrote:
> This patch fixes CamelCase renames evtThread to evt_thread in struct _adapter as reported by
> checkpatch.pl
> CHECK: Avoid CamelCase: <evtThread>
> 
> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index c6faafb13bdf..5360f049088a 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -153,7 +153,7 @@ struct _adapter {
>  	u8	eeprom_address_size;
>  	u8	hw_init_completed;
>  	struct task_struct *cmd_thread;
> -	pid_t evtThread;
> +	pid_t evt_thread;

If this is never used, please delete it.

thanks,

greg k-h
