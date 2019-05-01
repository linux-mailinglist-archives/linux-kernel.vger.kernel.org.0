Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF99410A90
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEAQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEAQFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:05:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9DD20644;
        Wed,  1 May 2019 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726705;
        bh=E8F/3pKddi/VN9Od3ETGWYRD3ebxn03vf7dBr53qS4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0/eU5QSfIyvSF6qY8MTgbPncQaNyEZNbt2FqPgGJoHj6SoRxdIwDUKZJe7/KEPPBL
         LY2qgf1rYgLo44rQdrC2nTFAHQKpvF9yNIb5cGGhPZCiZ2CkMgcDcLGh1oCTZdkfgi
         g1KUkxgFGvyo4nEYXAhKQOEU3Qouf77KGZONrXaQ=
Date:   Wed, 1 May 2019 18:05:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Message-ID: <20190501160503.GB19281@kroah.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:57:25AM -0500, Pierre-Louis Bossart wrote:
> No C++ comments in .h files

That's not really the issue here.

> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h            | 4 ++--
>  drivers/soundwire/cadence_master.h | 4 ++--
>  drivers/soundwire/intel.h          | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index c77de05b8100..2f8436584e7f 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */

The first line is fine to change, as that was the requirement (although
I think it has now been fixed), the second line is just taste, whatever
you want, it's not a requirement.

But I really don't care, it's not my code :)

thanks,

greg k-h
