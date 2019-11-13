Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE6FBB17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKMVuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:50:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMVuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:50:35 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1DA206EE;
        Wed, 13 Nov 2019 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573681834;
        bh=St/LYf+YIXh1Fk/nd47j4Mae7jBSVq3RCDMRZWLojnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=II49rerY+4P2wsShUA9ZFFfVwfYio2I7BA3U1lTRANzohtZLruT3+Xm4x2Oq8oaIc
         qkFnN24iNYObvPWbkO7XCwHoLuSvWAL5wK3ELqVFH39G1Fiw0GR2D404R7fWz/L10r
         zTGDr/fvM6+9PN2Q6tpRozb5SSrqkQxyYfY0T3Hk=
Date:   Thu, 14 Nov 2019 05:50:31 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] firmware_class: make firmware caching configurable
Message-ID: <20191113215031.GA3944533@kroah.com>
References: <20191113210124.59909-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113210124.59909-1-salyzyn@android.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 01:01:13PM -0800, Mark Salyzyn wrote:
> Because firmware caching generates uevent messages that are sent over
> a netlink socket, it can prevent suspend on many platforms.  It's
> also not always useful, so make it a configurable option.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/Kconfig                | 13 +++++++++++++
>  drivers/base/firmware_loader/main.c |  6 +++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 28b92e3cc570..36351c3a62b0 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -89,6 +89,19 @@ config PREVENT_FIRMWARE_BUILD
>  
>  source "drivers/base/firmware_loader/Kconfig"
>  
> +config FW_CACHE
> +	bool "Enable firmware caching during suspend"
> +	depends on PM_SLEEP
> +	default y
> +	help
> +	  Because firmware caching generates uevent messages that are sent
> +	  over a netlink socket, it can prevent suspend on many platforms.
> +	  It is also not always useful, so on such platforms we have the
> +	  option.
> +
> +	  If unsure, say Y.
> +
> +

Shouldn't this entry go into drivers/base/firmware_loader/Kconfig
instead and depend on FW_LOADER by putting it in the correct location in
that file?

Also, no need for two blank lines.

And finally, 'default y' is only a good idea if your machine can not
boot without the option.  I don't think that's the case here, correct?

thanks,

greg k-h
