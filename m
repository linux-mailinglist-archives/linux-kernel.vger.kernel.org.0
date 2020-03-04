Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3A1793D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgCDPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:44:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C5D2166E;
        Wed,  4 Mar 2020 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583336655;
        bh=z1VXR49TU2jEisQHdemESEry9T1v6Xn80PnEDn16EB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPbKJ1BeOt1vDP21LVx3cpaqIiQ5ufldGudnjxJ9cRaoRe/9YBXARjwUJR/Brdcnk
         /rRwqvmOZ1VPO9wHc8y4Yl2aKKt2WupbgVlZMSqmmVJdPwsH8/CDAwINWcFR4yJB3R
         0MbeqdrE4mBN8i9/58bxjeS0vuSuBkdwJGFKBdao=
Date:   Wed, 4 Mar 2020 16:44:12 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
Cc:     "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "hjk@linutronix.de" <hjk@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH 2/2] uio: Prefer MSI(X) interrupts in PCI drivers
Message-ID: <20200304154412.GA1761004@kroah.com>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
 <1507296804.2915.16.camel@iis-extern.fraunhofer.de>
 <20171006134550.GA1626@kroah.com>
 <1507297826.2915.18.camel@iis-extern.fraunhofer.de>
 <20171006075700.587a5e22@xeon-e3>
 <20171020125044.GA8634@kroah.com>
 <1508504312.3128.23.camel@iis-extern.fraunhofer.de>
 <9ba3cdd6d330486a91cb5c376f012b5b963c4eae.camel@iis-extern.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba3cdd6d330486a91cb5c376f012b5b963c4eae.camel@iis-extern.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:19:55PM +0000, Stahl, Manuel wrote:
> Hi Greg,
> 
> so somehow this discussion stopped without any instructions how to proceed.

What is "this discussion"?

> I think this kind of driver helps every FPGA developer to interface
> his design via PCIe to a Linux PC.
> So if there is any chance to get this code merged, I'm glad to rebase
> this onto the latest kernel release.

Please rebase and resubmit, it's a patch from 2 1/2 years ago, not much
I can even remember about patch sets sent last week...

thanks,

greg k-h
