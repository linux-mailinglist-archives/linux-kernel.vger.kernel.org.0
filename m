Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC4B5334
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfIQQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 12:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbfIQQjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:39:12 -0400
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFFC3206C2;
        Tue, 17 Sep 2019 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568738351;
        bh=CJxuDIir/Q8qXCQsVobRaYKJz6i9TOdPwNr3MjspfMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQUKQKjV9hD3GAAYiBCBQC5OaXd06dpPbVwPiNd179rfVNFSA/T+nndAMhG+CmRYz
         PtPN80U8+yBQeRv1/AXBF18O2gbnYnQRNW00W/IwftXCYLr4XfGS3h6NtvJMC1HYNe
         OOGO6MqOIQ0T0OF033dOsYWy0Qk/kZBnLliND/0Y=
Date:   Tue, 17 Sep 2019 10:39:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Baldyga, Robert" <robert.baldyga@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rakowski, Michal" <michal.rakowski@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:13:24PM +0000, Baldyga, Robert wrote:
> Ok, fair enough. We want to keep things hidden behind certain layers,
> and that's definitely a good thing. But there is a problem with these
> layers - they do not expose all the features. For example AFAIK there
> is no clear way to use 512+8 format via block layer (nor even a way 
> to get know that bdev is formatted to particular lbaf). It's impossible
> to use it without layering violations, which nobody sees as a perfect
> solution, but it is the only one that works.

I think your quickest path to supporting such a format is to consider
each part separately, then bounce and interleave/unmix the data +
metadata at another layer that understands how the data needs to be laid
out in host memory. Something like this RFC here:

  http://lists.infradead.org/pipermail/linux-nvme/2018-February/015844.html

It appears connecting to infradead lists is a bit flaky at the moment,
so not sure if you'll be able to read the above link right now.

Anyway, the RFC would have needed a bit of work to be considered, like
using a mempool for the purpose, but it does generically make such
formats usable through the block stack so maybe try flushing out that
idea.
