Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A766FD5EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 07:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKOGQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 01:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfKOGQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:16:14 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F1D2072B;
        Fri, 15 Nov 2019 06:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798572;
        bh=G+0cdXXTrcTHP5HHhkPRNjMmImcxewGysVtA+48G1lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuuMgLeFQzo5L2g7WgAd8skDAoeSdstO8NckalfM7LIkAEM/9Hkm9v9OWS7aNDVMH
         OtEDWlLHRzX8nf8i/P3Qoya1aZItzH8IAlhpCw8c3oHc9SfuSpwkKgldI0DneCpe/+
         97vWjyIfKOaEQpXgp5O1rBzfyL9oRxDYryelAJeY=
Date:   Fri, 15 Nov 2019 14:16:10 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH] staging: rtl*: Remove tasklet callback casts
Message-ID: <20191115061610.GA1034830@kroah.com>
References: <201911142135.5656E23@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911142135.5656E23@keescook>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 09:39:00PM -0800, Kees Cook wrote:
> In order to make the entire kernel usable under Clang's Control Flow
> Integrity protections, function prototype casts need to be avoided
> because this will trip CFI checks at runtime (i.e. a mismatch between
> the caller's expected function prototype and the destination function's
> prototype). Many of these cases can be found with -Wcast-function-type,
> which found that the rtl wifi drivers had a bunch of needless function
> casts. Remove function casts for tasklet callbacks in the various drivers.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c        |  3 +--
>  drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c        |  3 +--
>  drivers/staging/rtl8188eu/include/rtl8188e_recv.h     |  2 +-
>  drivers/staging/rtl8188eu/include/rtl8188e_xmit.h     |  2 +-
>  drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c      |  4 ++--
>  drivers/staging/rtl8192e/rtllib_softmac.c             |  7 +++----
>  .../staging/rtl8192u/ieee80211/ieee80211_softmac.c    |  7 +++----
>  drivers/staging/rtl8192u/r8192U_core.c                |  8 ++++----
>  drivers/staging/rtl8712/rtl8712_recv.c                | 11 +++++------
>  drivers/staging/rtl8712/rtl871x_xmit.c                |  5 ++---
>  drivers/staging/rtl8712/rtl871x_xmit.h                |  2 +-
>  drivers/staging/rtl8712/usb_ops_linux.c               |  4 ++--
>  drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c        | 11 ++++-------
>  13 files changed, 30 insertions(+), 39 deletions(-)

This fails to apply to my staging-next branch of staging.git.  Can you
rebase and resend?

thanks,

greg k-h
