Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D212C3A4F6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfFILCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 07:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfFILCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 07:02:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5134F2083D;
        Sun,  9 Jun 2019 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560078128;
        bh=Fl13B7AdxLKVh/jbYNRAUmggrojZf3/Gq+JViMfyvs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfGvUDo0m8USk6NvX4WDbIG/zePnZQvHIUxCBOUJy458mkD14q3vhfQipQeErhKYZ
         7KNqMdHWdEwUFAKqAgUIgTkt/y0pMCwhn6T9Mul1Pa+vuEfd96sUuuUJSyw9cqv4nJ
         SKUXGNUkJxs4fZPSXli/UoNAdluU+2NbioUMArSI=
Date:   Sun, 9 Jun 2019 13:02:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com, benniciemanuel78@gmail.com,
        hardiksingh.k@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove unused
 variables
Message-ID: <20190609110206.GD30671@kroah.com>
References: <20190607071123.28193-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607071123.28193-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 12:41:23PM +0530, Nishka Dasgupta wrote:
> Remove variables that are declared and assigned values but not otherwise
> used.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ---------
>  1 file changed, 9 deletions(-)

You sent me 8 patches for this driver, yet only 2 were ordered in a
series.  I have no idea what order to apply these in :(

Please resend them _all_ in a numbered patch series so I have a chance
to get this correct.

thanks,

greg k-h
