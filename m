Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0914311FAAC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 20:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfLOTIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 14:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfLOTIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:08:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE77624679;
        Sun, 15 Dec 2019 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576436931;
        bh=7X8VWHMFWfCEhaneD3PL+S0Sqx3q7ECu5a1X/J5YMdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNYMJvZ8v7gouX/+KRkXUj78be86pjgXjnCcHTPzOKIT9VeVDPUtPqBayPd1vQaiB
         o6eFbHaY7vxHaKXfoaQ/1uLSsMmsSccfwArJxlXeppcydmrF0pB8rIzRB2gckGduwt
         cLa8T/tKmMyFbojb5yT/VhTtKF1WtLlbtsiKLHp8=
Date:   Sun, 15 Dec 2019 20:08:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: replace multiple BUG_ON assertions with error
 return code
Message-ID: <20191215190849.GA914378@kroah.com>
References: <20191215183952.689-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215183952.689-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 12:39:52PM -0600, Aditya Pakki wrote:
> Various register operations check for the validity of cache_ops
> struct and crash in case of failure. However, by returning the error
> to the callers, instead of assert, these functions can avoid the crash.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/base/regmap/regcache.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> index a93cafd7be4f..855fa25ae595 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -238,7 +238,8 @@ int regcache_read(struct regmap *map,
>  	if (map->cache_type == REGCACHE_NONE)
>  		return -ENOSYS;
>  
> -	BUG_ON(!map->cache_ops);
> +	if (!map->cache_ops)
> +		return -EINVAL;

While it is fun to make patches like this, again, if you can prove that
this can never happen, just remove the check please.

And if it can happen, why is -EINVAL the correct error code here?

thanks,

greg k-h
