Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD6F2954
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 09:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfKGIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 03:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733257AbfKGIkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:40:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E0C21D79;
        Thu,  7 Nov 2019 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573116010;
        bh=UXQJazaBfJV0zIWW7UEoQWPynSR/yhlKvrGLJ29hpro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omokBRfofB53Ei3yMrIzwz9Z22Rrk3t3SpYs1IPksEG+BpBfYj+fTGT/pWzSe0Ks3
         8X1yjKW9hshlFJG0yVB3Zc98K0aegYpbp+yWGQ2hAjswx6P1cLApcvNc4jaVcFeV2w
         UydpvdtPxRASerQVo0BvKeoXCBM8TaJsia3ZLpzM=
Date:   Thu, 7 Nov 2019 09:40:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gerg@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        neil@brown.name, blogic@openwrt.org
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash
 controller
Message-ID: <20191107084007.GA1203521@kroah.com>
References: <20191107073521.11413-1-gerg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107073521.11413-1-gerg@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 05:35:21PM +1000, gerg@kernel.org wrote:
> From: Greg Ungerer <gerg@kernel.org>
> 
> Add a driver to support the NAND flash controller of the MediaTek MT7621
> System-on-Chip device. (This one is the MIPS based parts from Mediatek).
> 
> This code is a re-working of the earlier patches for this hardware that
> have been floating around the internet for years:
> 
> https://github.com/ReclaimYourPrivacy/cloak/blob/master/target/linux/ramips/patches-3.18/0045-mtd-add-mt7621-nand-support.patch
> 
> This is a much cleaned up version, put in staging to start with.
> It does still have some problems, mainly that it still uses a lot of the
> mtd raw nand legacy support.

Is that an issue?  Why not just put it in the "real" part of the kernel
then, if those apis are still in use?

> The driver not only compiles, but it works well on the small range of
> hardware platforms that it has been used on so far. I have been using
> for quite a while now, cleaning up as I get time.
> 
> So... I am looking for comments on the best approach forward with this.
> At least in staging it can get some more eyeballs going over it.

staging will just nit-pick it to death for coding style issues, it's not
going to be get any major api changes/cleanups there usually.  I'd
recommend just merging this to the "real" part of the kernel now if it's
working for you.

thanks,

greg k-h
