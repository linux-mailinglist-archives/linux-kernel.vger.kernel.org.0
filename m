Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0761DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfGHLVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 07:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfGHLVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:21:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EF4D20665;
        Mon,  8 Jul 2019 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562584898;
        bh=co9fd811Kr9WQY50coovlLGOUZYjpRPbe6qUNkr1D3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/yCdsZQJPjgWYQXOWR/QKTf3zFKtPKC1zzrduZaTAYyk19FiKOq70ZuXm+hek3/A
         1W1N/OfJqiYmoTy1BH210K+kFnXE/82+dpoi/DGDpRxkJ55GCuEP6lYecviaRFI33v
         Jw5i/UqwYcN7PzmfVjQxDDLmgujMm/kW01aEMKlI=
Date:   Mon, 8 Jul 2019 13:21:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH] habanalabs: use correct variable to show fd open counter
Message-ID: <20190708112136.GA13795@kroah.com>
References: <20190708104355.32569-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708104355.32569-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 01:43:55PM +0300, Oded Gabbay wrote:
> The current code checks if the user context pointer is NULL or not to
> display the number of open file descriptors of a device. However, that
> variable (user_ctx) will eventually go away as the driver will support
> multiple processes. Instead, the driver can use the atomic counter of
> the open file descriptors which the driver already maintains.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
> index 25eb46d29d88..881be19b5fad 100644
> --- a/drivers/misc/habanalabs/sysfs.c
> +++ b/drivers/misc/habanalabs/sysfs.c
> @@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
>  {
>  	struct hl_device *hdev = dev_get_drvdata(dev);
>  
> -	return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
> +	return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
>  }

Odds are, this means nothing, as it doesn't get touched if the file
descriptor is duped or sent to another process.

Why do you care about the number of open files?  Whenever someone tries
to do this type of logic, it is almost always wrong, just let userspace
do what it wants to do, and if wants to open something twice, then it
gets to keep the pieces when things break.

thanks,

greg k-h
