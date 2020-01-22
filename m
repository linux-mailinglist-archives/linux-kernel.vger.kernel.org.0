Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA936144C49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 08:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAVHDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 02:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgAVHDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:03:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5572465B;
        Wed, 22 Jan 2020 07:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579676595;
        bh=WWkS7Yef2C7FR/b3G/YEIfSot0jkLNRI4Jm9VGMxZMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3ymB0g3dMkvQQ7xy1h/OPiBStKsXsJ2OvvlfwzPN52PcY7kpCgYgJ+Nyo9NuQX5x
         zdArrFTaaKQUx+FvFTvPpRNHxJlLNqIHMMBkX2VTimkB/2P5HbVD+SLeP0P9GWOl+4
         mlmRkqRzMRTeSpBFS6E9z2aGkwNG5ww5tQxMqPaQ=
Date:   Wed, 22 Jan 2020 08:03:12 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>
Subject: Re: staging: Add MA USB Host driver
Message-ID: <20200122070312.GB2068857@kroah.com>
References: <VI1PR10MB19659B32E563620B4D63AF1A91320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB1965A077526FE296608D5B1191320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 09:30:43AM +0000, Vladimir Stankovic wrote:
> MA-USB Host driver provides USB connectivity over an available
> network, allowing host device to access remote USB devices attached
> to one or more MA USB devices (accessible via network).
> 
> This driver has been developed to enable the host to communicate
> with DislayLink products supporting MA USB protocol (MA USB device,
> in terms of MA USB Specification).
> 
> MA-USB protocol used by MA-USB Host driver has been implemented in
> accordance with MA USB Specification Release 1.0b.
> 
> This driver depends on the functions provided by DisplayLink's
> user-space driver.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>

Why is this being submitted to staging and not to the "real" part of the
kernel?  You need a TODO file that lists what is left to be done to the
driver to get it merged to the proper place in the kernel tree.  Can you
please resubmit with that file added to the patch?

thanks,

greg k-h
