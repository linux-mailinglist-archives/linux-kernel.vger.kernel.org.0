Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570B532F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfFCMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 08:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfFCMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0205F25F14;
        Mon,  3 Jun 2019 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564427;
        bh=y1TILt/ffTUz1M9+mg0l1iL1FFJ1tJ7setoQfWG0gvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WynB5YHHwyNsvoYa11HNktiCpQXWJdscE3gqCnOHo81W7TiPNIo7ok5i1D1AhQxSR
         YNlnvPzsk+9VJTNDepe7PYDt4frz6rEEDpf1JjSdzUwahehbw3MPDX7VPXL7v5mPKW
         ZL6ts49z76fWUSCexyzdcEtpfFH96GdR4vnqAsdA=
Date:   Mon, 3 Jun 2019 14:20:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, colin.king@canonical.com,
        straube.linux@gmail.com, yangx92@hotmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Remove function alloc_network
Message-ID: <20190603122025.GA23379@kroah.com>
References: <20190530210141.30221-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530210141.30221-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:31:41AM +0530, Nishka Dasgupta wrote:
> Remove function alloc_network as it does nothing except call
> _r8712_alloc_network. Further, to maintain consistency with
> the names of other functions, rename _r8712_alloc_network as
> r8712_alloc_network.
> Also change the corresponding calls to either function
> accordingly.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_cmd.c  | 2 +-
>  drivers/staging/rtl8712/rtl871x_mlme.c | 9 ++-------
>  drivers/staging/rtl8712/rtl871x_mlme.h | 2 +-
>  3 files changed, 4 insertions(+), 9 deletions(-)

Does not apply to my tree :(

When sending multiple patches for the same driver/file, always make a
patch series so I know what order to apply them in.  Otherwise I guess
and usually guess wrong, like I did here...

Please fix up and resend.

thanks,

greg k-h
