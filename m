Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B5338DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfFCTFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 15:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfFCTFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:05:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B567326DF6;
        Mon,  3 Jun 2019 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559588700;
        bh=R8oH6TrNzNnKnXl40BLjxloa+JfMj2hBIL8vLlewyX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jb25hMVLOuG+2146l3orHarP96UdmDO8nJiRUIL1Xy/WxTEr+hGXUaPPxVc90bmZx
         FfpEV8iLbt5sl36CBC6DIqyvl6+3p+Mz0Y/yjTPxX16QUlpEzrxTFODwIwbgCdyX/D
         TQNK3ROcfly0jIxHhUD3sWDnZAimv1IM5/5xquWU=
Date:   Mon, 3 Jun 2019 21:04:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: emxx_udc: fix warning "sum of probable
 bitmasks, consider |"
Message-ID: <20190603190457.GA6487@kroah.com>
References: <20190603185412.GA11183@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603185412.GA11183@hari-Inspiron-1545>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:24:12AM +0530, Hariprasad Kelam wrote:
> Knowing the fact that operator '|' is faster than '+'.
> Its better we replace + with | in this case.
> 
> Issue reported by coccicheck
> drivers/staging/emxx_udc/emxx_udc.h:94:34-35: WARNING: sum of probable
> bitmasks, consider |
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
> index b8c3dee..88d6bda 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.h
> +++ b/drivers/staging/emxx_udc/emxx_udc.h
> @@ -91,7 +91,7 @@ int vbus_irq;
>  #define BIT30		0x40000000
>  #define BIT31		0x80000000

All of those BITXX defines should be removed and the "real" BIT(X) macro
used instead.

> -#define TEST_FORCE_ENABLE		(BIT18 + BIT16)
> +#define TEST_FORCE_ENABLE		(BIT18 | BIT16)

It really doesn't matter, a good compiler will have already turned this
into a constant value so you really do not know if this is less/faster
code or not, right?

Did you look at the output to verify this actually changed anything?

thanks,

greg k-h
