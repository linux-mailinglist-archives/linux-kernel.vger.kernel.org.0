Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794DA100AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKRRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 12:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfKRRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:53:27 -0500
Received: from localhost (unknown [89.205.134.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C725521D7A;
        Mon, 18 Nov 2019 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574099607;
        bh=IcSOwVKmLuKmo7u5Mvb/UEAyIjJhWl+5hSzY+nuG6yA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXYTo37lu/39G6GjfYUjFHCvBhsC4D2NaKVBQK8gCYd+DjLWXLgUKP6FDEY2gOJFK
         HWhPJiO1WGXAaCXI9ObGdshatVlz8iqH6d4WNiPQpv2qsBcSHNc7JNcbY7zHCxtslN
         UUMYTjsXUls172Y4frryqdf8uoUuRAaOe3yCCcXc=
Date:   Mon, 18 Nov 2019 18:53:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org, sir@cmpwn.com,
        ~sircmpwn/public-inbox@lists.sr.ht, rafael@kernel.org
Subject: Re: [PATCH v3] firmware: log name & outcome of loaded firmware
Message-ID: <20191118175312.GA602012@kroah.com>
References: <robbat2-20191113T195158-869302266Z@orbis-terrarum.net>
 <20191117234734.27101-1-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117234734.27101-1-robbat2@gentoo.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 03:47:34PM -0800, Robin H. Johnson wrote:
> It's non-trivial to figure out names of firmware that was actually
> loaded, add a debug statement at the end of _request_firmware that logs
> the name & result of each firmware.
> 
> This is esp. valuable early in boot, before logging of UEVENT is
> available.
> 
> v3:
> - Log at dev_dbg level per maintainer.
> - HOWTO: Enable at boot via kernel boot param
>   dyndbg="func _request_firmware +p"
> - Credit to Drew DeVault for parallel creation and help promoting the
>   idea.

These "v3.." lines need to go below the --- line.

> 
> Alternate-Creation: Drew DeVault <sir@cmpwn.com>

Is that a valid tag?  You can have co-developed-by (or something like
that, read the documentation for the real name), but I have never seen
this one before.

> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> ---
>  drivers/base/firmware_loader/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index bf44c79beae9..84a879608ca4 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -791,6 +791,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  		fw = NULL;
>  	}
>  
> +	/* Provide a consistent way to capture the result of trying to load any
> +	 * firmware. As a potential future improvement, this might include
> +	 * persistent state that firmware is loaded (or failed to load for some
> +	 * reason). See Message-ID: <20191113205010.GY11244@42.do-not-panic.com>

Just provide a lore link with the message id if you really want this.

But really, this type of thing belongs in the changelog text, not in a
comment, right?

> +	 * for background */
> +	dev_dbg(device, "%s %s ret=%d\n", __func__, name, ret);

That does not provide any real information as to what is going on, why
doesn't ftrace suffice for this?

thanks,

greg k-h
