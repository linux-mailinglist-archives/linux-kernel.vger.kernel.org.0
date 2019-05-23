Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691F2276B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfEWHIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEWHIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:08:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911E021019;
        Thu, 23 May 2019 07:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558595279;
        bh=T0gjpPWXfkyv+gbWFTr6yRPQFkhsU2y0t1/Ii1Cw/f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLQiyBogm1alOOQ2zDMy/tvmOT3eBPKq7dDMSc6yAw7aPG06ySNszIwdJIo2z602u
         SwRl/RBspWjSSEihFzInU7T1oUq62MytCAT4VLnyneznUmwR7b3l2045p4SAOoWK/Y
         BaAO+p3xvK64bLt4t1kaHIrI1I/H65yCzgwHr27I=
Date:   Thu, 23 May 2019 09:07:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     laurentiu.tudor@nxp.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v6 0/5] prerequisites for device reserved local mem rework
Message-ID: <20190523070755.GA23832@kroah.com>
References: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
 <20190523065602.GA11928@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523065602.GA11928@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:56:02AM +0200, Christoph Hellwig wrote:
> As we seem to be getting ready to merge this series:  can the usb
> maintainers please commit it to an immutable branch that I can pull
> into the dma-mapping tree?  These changes are a preparation for
> reworking the per-device DMA coherent allocator, and I'd prefer not
> to wait for the next merge window with the next steps.

I have no objection for you just taking this whole series as-is, no need
to worry about merge conflicts with the USB tree, I doubt anything will
be touching this area of code anytime soon.

So if you want to take it now, feel free to add:

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

to all of these.

Or, if you really like/want a branch to pull from, I can do that as
well, which ever is easiest for you to work with as you all are doing
the hard work here, not me :)

thanks,

greg k-h
