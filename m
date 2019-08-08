Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DEA860C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfHHLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 07:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHLYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:24:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4030217F4;
        Thu,  8 Aug 2019 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565263441;
        bh=kGWv3F0MZ6VV9IXcBhJcDU1X/GIu/fiFKm60hLg1jl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPUlJbYE0CKDv6O2+2uWzaA2ka2pJoRB582LbPnviWR6DSUk79P/amJggh47IWOeY
         W42uHkBJJTBD/oJM+7mAzVP6LDvdTNj48qKD/8gcFvIpHMNqeP98cF5ONlZPz9SN3R
         g0i0T0FITrd17Ki8qLG3tW7+m9kDDvYsyOkk/y1A=
Date:   Thu, 8 Aug 2019 13:23:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] MAINTAINERS: mark wusbcore and UWB as obsolete
Message-ID: <20190808112358.GA25286@kroah.com>
References: <20190806101509.GA11280@kroah.com>
 <b73f09c944625a40b2589e9bac7f8bd22a711ed3.camel@perches.com>
 <20190806113501.GA18443@kroah.com>
 <20190808092509.GA20173@kroah.com>
 <20190808094158.GA22635@kroah.com>
 <92ed89b0346a54fb06d3e08585a8d0b4175842f0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ed89b0346a54fb06d3e08585a8d0b4175842f0.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:15:44AM -0700, Joe Perches wrote:
> On Thu, 2019-08-08 at 11:41 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 08, 2019 at 11:25:09AM +0200, Greg Kroah-Hartman wrote:
> > > Joe rightly points out that we should be using the "Obsolete" status for
> > > these two subsystems.
> > 
> > Even with that change, I don't see get_maintainers.pl tell me I
> > shouldn't be sending a patch in for this area:
> 
> Nor should you.  It's checkpatch that should warn.

Ah, wrong tool.  Yes, it does, let's see if anyone actually notices that
when sending checkpatch changes for these files in the future :)

thanks,

greg k-h
