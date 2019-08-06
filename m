Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504AA8358D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfHFPqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 11:46:06 -0400
Received: from verein.lst.de ([213.95.11.211]:57452 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:46:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96D88227A81; Tue,  6 Aug 2019 17:46:02 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:46:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806154602.GB25050@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de> <20190806113318.GA20215@lst.de> <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com> <20190806140408.GA22902@lst.de> <1565100418.2323.32.camel@pengutronix.de> <78833204-cd30-1a4b-54e3-1580018c6d57@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78833204-cd30-1a4b-54e3-1580018c6d57@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:18:49PM +0000, Lendacky, Thomas wrote:
> I think you need to keep everything inside the original if statement since
> the caller is expecting a page pointer to be returned in this case and not
> the page_address() which is returned when the DMA_ATTR_NO_KERNEL_MAPPING
> is not present.

DMA_ATTR_NO_KERNEL_MAPPING is defined to return an opaque cookie,
which just happens to be a page pointer.  So if we fix up the free side
as pointed out by Lucas we should be fine.
