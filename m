Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E493914D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 07:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRFDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 01:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfHRFDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 01:03:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C0F520B7C;
        Sun, 18 Aug 2019 05:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566104600;
        bh=ql9ej5FJ98q5w8xOOl3dVUrbb6fRmslfoh3dW60tJvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srxiX8TznxuoQK3RJBoVJvWWBfd5RaVgQCRAr1T/IbxkBOK/MlieyaurNgXK7Kl+x
         tGLuh7QLkppVTNFqNxvNzjA3Y12IBnmDRLMPzRGV8tDQoob4eL2EBcgn7xleIQVhwn
         FvknPx9MZ5yyiHzK1Q5mhEyZFwt8VgH5xROre4pc=
Date:   Sun, 18 Aug 2019 07:03:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Donald Yandt <donald.yandt@gmail.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com, christian@brauner.io
Subject: Re: [PATCH] staging: android: Remove ion device tree bindings from
 the TODO
Message-ID: <20190818050317.GA8147@kroah.com>
References: <20190817213758.5868-1-donald.yandt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817213758.5868-1-donald.yandt@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 05:37:58PM -0400, Donald Yandt wrote:
> This patch removes the todo for the ion chunk and
> carveout device tree bindings.
> 
> Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> ---
>  drivers/staging/android/TODO | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/android/TODO b/drivers/staging/android/TODO
> index fbf015cc6..767dd98fd 100644
> --- a/drivers/staging/android/TODO
> +++ b/drivers/staging/android/TODO
> @@ -6,8 +6,6 @@ TODO:
>  
>  
>  ion/
> - - Add dt-bindings for remaining heaps (chunk and carveout heaps). This would
> -   involve putting appropriate bindings in a memory node for Ion to find.
>   - Split /dev/ion up into multiple nodes (e.g. /dev/ion/heap0)
>   - Better test framework (integration with VGEM was suggested)
>  

This is already done?  Do you have a pointer to the git commit id(s)
that did it?

thanks,

greg k-h
