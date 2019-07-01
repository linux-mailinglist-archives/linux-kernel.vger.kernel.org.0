Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC42144E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfEQHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 03:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbfEQHb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:31:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BD1206A3;
        Fri, 17 May 2019 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558078315;
        bh=W80f0Osmfp2T/2G+HffeiwRgi9eEG28g8hfA/rYHfV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnTZv7Gdtfl8lB37+XTgoUosol4ItZo2FUfZvDbTGqk5YeTBuIkBW8dUAceharY+n
         fqfW/TGAG14Qm9b4DL7/k7AMS4IbfG/Ycqovq0BgJr5RdLr1vNk7P2ckTPLTOgQWXj
         0M0P1EtYNk6hUfSEEAiXPyrusp6rBGFtqBSvRAZk=
Date:   Fri, 17 May 2019 09:31:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>
Subject: Re: [PATCH v2] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Message-ID: <20190517073153.GA4776@kroah.com>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
 <20190516115653.15120-1-quentin.deslandes@itdev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516115653.15120-1-quentin.deslandes@itdev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:57:15AM +0000, Quentin Deslandes wrote:
> Returns error code from 'vnt_int_start_interrupt()' so the device's private
> buffers will be correctly freed and 'struct ieee80211_hw' start function
> will return an error code.
> 
> Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> ---
>  drivers/staging/vt6656/int.c      |  4 +++-
>  drivers/staging/vt6656/int.h      |  2 +-
>  drivers/staging/vt6656/main_usb.c | 12 +++++++++---
>  3 files changed, 13 insertions(+), 5 deletions(-)

What changed from v1?  Always put that below the --- line.

Please fix up and resend a v3.

thanks,

greg k-h
