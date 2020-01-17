Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AF2140C55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:21:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQOVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:21:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B556F2072B;
        Fri, 17 Jan 2020 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579270897;
        bh=4on+F+4Fhjf/p/7y7ME9mgfzHOEfkvu+t5ETPOT9sRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ILH4lnrV4NV/+WsLU6xnYfNIvkQ665YOYiKkYT1V3BaXlOZuBKU3vEm3Fi3x9u6j
         LuU0Zhbdu56XaJFHtxnyKO+4WiK44eEvf6DWkAkEo35vTVJhXQdVMuQ+ickFcYIYdH
         0+f+u1iO3q64mCRkRhutO3qIa0UI0ytQDKQm5Te0=
Date:   Fri, 17 Jan 2020 15:21:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Zeng Tao <prime.zeng@hisilicon.com>, linuxarm@huawei.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] cpu-topology: Don't error on more than CONFIG_NR_CPUS
 CPUs in device tree
Message-ID: <20200117142134.GA1858257@kroah.com>
References: <1579225973-32423-1-git-send-email-prime.zeng@hisilicon.com>
 <20200117101957.GA4099@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117101957.GA4099@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:19:57AM +0000, Sudeep Holla wrote:
> On Fri, Jan 17, 2020 at 09:52:52AM +0800, Zeng Tao wrote:
> > When the kernel is configured with CONFIG_NR_CPUS smaller than the
> > number of CPU nodes in the device tree(DT), all the CPU nodes parsing
> > done to fetch topology information will fail. This is not reasonable
> > as it is legal to have all the physical CPUs in the system in the DT.
> >
> > Let us just skip such CPU DT nodes that are not used in the kernel
> > rather than returning an error.
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> 
> Hi Greg,
> 
> Can you pick this patch for v5.6 ?

oops, didn't realize this was for me, sorry, will go do so now.

greg k-h
