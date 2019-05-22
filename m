Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE6263E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 14:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfEVMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 08:33:07 -0400
Received: from verein.lst.de ([213.95.11.211]:39305 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfEVMdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:33:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 25DE967358; Wed, 22 May 2019 14:32:44 +0200 (CEST)
Date:   Wed, 22 May 2019 14:32:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Message-ID: <20190522123243.GA26390@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522072018.10660-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a little worried about this.  While it looks functionally correct
we have surived without it, and doing another copy for every swiotlb
dma mapping from the device looks extremely painful for the typical use
cases where we expect the device to transfer the whole mapping.

I'd be tempted to instead properl document the current behavior and
introduce a new DMA_ATTR_PARTIAL flag to allow for partial mappings.
