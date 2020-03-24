Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82331906D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 08:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgCXHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 03:52:30 -0400
Received: from verein.lst.de ([213.95.11.211]:34286 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgCXHw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:52:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE3EB68BFE; Tue, 24 Mar 2020 08:52:25 +0100 (CET)
Date:   Tue, 24 Mar 2020 08:52:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200324075225.GI23447@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de> <37ce1b7e-264d-292d-32b1-093b24b3525c@ozlabs.ru> <20200323172014.GA31269@lst.de> <d4bf6058-aa77-d0bc-8196-f4c27fb21b74@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4bf6058-aa77-d0bc-8196-f4c27fb21b74@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:37:59PM +1100, Alexey Kardashevskiy wrote:
> dma_alloc_direct() and dma_map_direct() do the same thing now which is
> good, did I miss anything else?

dma_alloc_direct looks at coherent_dma_mask, dma_map_direct looks
at dma_mask.
