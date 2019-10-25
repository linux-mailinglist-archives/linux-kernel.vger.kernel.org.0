Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E375E4089
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 02:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfJYAUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 20:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJYAUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:20:54 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3030D21929;
        Fri, 25 Oct 2019 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571962854;
        bh=bC985rj/uGr5kpM3lV8+Lzv14SErAUJ30tXkNbNlDNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR+2whxhjFQ/HKwosMbLS1XgQA4+o7WRtuXfJ0BJvvnTDWvKzt0nhxZQiC8dw7pau
         glmXpqG25L32OylS3HzItJywufNSTaMwJee2IrXk10hx11/LO28Z7NZwBvXcz27Obs
         dHBNDDXi7+ICUbJE0HefWpLvzKHrBcQpQCHfvIl0=
Date:   Fri, 25 Oct 2019 09:20:50 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 0/7] Remove data_len field from the nvmet_req struct
Message-ID: <20191025002050.GC28602@redsun51.ssa.fujisawa.hgst.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:35:38AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset is a cleanup in preparation for the passthru patchset.
> The aim is to remove the data_len field in the nvmet_req struct and
> instead just check the length is appropriate inside the execute
> handlers. This is more appropriate for passthru which may have
> commands with unknown lengths (like Vendor Specific Commands).
> It's also in improvement seeing it can often be confusing when
> it's best to use the data_len field over the transfer_len field.
> The first two patches in this series remove some questionable uses
> of the data_len field in nvmt-tcp
> 
> Most of this patchset was extracted from a draft patch from
> Christoph[1].
> 
> The series is based on v5.4-rc4 and a git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem/branches nvmet_data_len
> 
> Logan

Thanks, applied to nvme-5.5 with the requested author attribution.
