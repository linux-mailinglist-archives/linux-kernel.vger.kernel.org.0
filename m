Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499555A981
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 09:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF2HxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 03:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfF2HxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:53:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06BE02083B;
        Sat, 29 Jun 2019 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561794796;
        bh=eXUSg5gAEOz4gIaibl+P2xmyG9y3MtvzIka3bgkCHPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODorpqjjRnnfWVgc4AoMyhb95CgAYXOg95HTZNCI2fdm9S5IZJzrwvPKO+bvpfZoB
         l8I7tpjsrJxntfggfnIGQR395WNwx/gxF1kdqB11ihc+NsRu8mKMAnoBtICevomkBL
         MweFIxCIiw01QKFBB0/3L9XQFo0lCVYl1sWcnc2A=
Date:   Sat, 29 Jun 2019 09:53:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        David Miller <davem@davemloft.net>, brian.brooks@linaro.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        nadavh@marvell.com, stefanc@marvell.com,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] driver core: platform: Allow using a dedicated dma_mask
 for platform_device
Message-ID: <20190629075312.GB28708@kroah.com>
References: <20190628141550.22938-1-maxime.chevallier@bootlin.com>
 <20190628155946.GA16956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628155946.GA16956@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 08:59:46AM -0700, Christoph Hellwig wrote:
> I'd much rather bite the bullet and make dev->dma_mask a scalar
> instead of a pointer.  The pointer causes way to much boiler plate code,
> and the semantics are way to subtile.  Below is a POV patch that
> compiles and boots with my usual x86 test config, and at least compiles
> with the arm and pmac32 defconfigs.  It probably breaks just about
> everything else, but should give us an idea what is involve in the
> switch:
> 
> ---
> >From ea73ba2d29f56ff6413066b10f018a671f2b26ac Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 28 Jun 2019 16:24:01 +0200
> Subject: device.h: make dma_mask a scalar instead of a pointer
> 
> Kill the dma_mask indirection to clean up the mess we acquired around
> it.

I have no objection to this at all.  I would love to see the indirection
go away.

thanks,

greg k-h
