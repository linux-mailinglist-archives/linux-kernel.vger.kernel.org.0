Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0A45CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfFNMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 08:31:32 -0400
Received: from verein.lst.de ([213.95.11.211]:46599 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfFNMbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:31:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1C78C68AFE; Fri, 14 Jun 2019 14:31:04 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:31:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Apply dma_{alloc,free}_contiguous functions
Message-ID: <20190614123103.GC31052@lst.de>
References: <20190603225259.21994-1-nicoleotsuka@gmail.com> <20190606062840.GD26745@lst.de> <67324adb-d9bc-03f6-6ec7-1463a2f35474@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67324adb-d9bc-03f6-6ec7-1463a2f35474@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:42:54AM +0100, Robin Murphy wrote:
> On 06/06/2019 07:28, Christoph Hellwig wrote:
>> Looks fine to me.  Robin, any comments?
>
> AFAICS this looks like the obvious conversion, so... no? :)

Yep.  Just want to make sure I don't apply dma-iommu patches without
your review.
