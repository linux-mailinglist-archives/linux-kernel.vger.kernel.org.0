Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1371A8364C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfHFQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:07:14 -0400
Received: from verein.lst.de ([213.95.11.211]:57669 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbfHFQHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:07:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C619227A81; Tue,  6 Aug 2019 18:07:10 +0200 (CEST)
Date:   Tue, 6 Aug 2019 18:07:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806160709.GA25586@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de> <20190806113318.GA20215@lst.de> <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com> <20190806140408.GA22902@lst.de> <1565100418.2323.32.camel@pengutronix.de> <78833204-cd30-1a4b-54e3-1580018c6d57@amd.com> <20190806154602.GB25050@lst.de> <5bd42e33-8077-ea23-a9f3-c575db4edada@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd42e33-8077-ea23-a9f3-c575db4edada@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:59:40PM +0000, Lendacky, Thomas wrote:
> As long as two different cookie types (page pointer for encrypted DMA
> and virtual address returned from page_address() for unencrypted DMA)
> is ok. I'm just not familiar with how the cookie is used in any other
> functions, if at all.

DMA_ATTR_NO_KERNEL_MAPPING is intended for memory never used in the
kernel, either because it is just a buffer for device that are too cheap
to enough dram, or because it is a buffer for userspace to device
communication that the kernel just mediates.
