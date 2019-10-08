Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50CECFA5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfJHMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:50:14 -0400
Received: from verein.lst.de ([213.95.11.211]:46671 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfJHMuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:50:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D55AD68B05; Tue,  8 Oct 2019 14:50:08 +0200 (CEST)
Date:   Tue, 8 Oct 2019 14:50:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191008125008.GA4829@lst.de>
References: <20191007175430.GA32537@rani.riverdale.lan> <20191007175528.GA21857@lst.de> <20191007175630.GA28861@infradead.org> <20191007175856.GA42018@rani.riverdale.lan> <20191007183206.GA13589@rani.riverdale.lan> <20191007184754.GB31345@lst.de> <20191007221054.GA409402@rani.riverdale.lan> <20191007235401.GA608824@rani.riverdale.lan> <20191008073210.GB9452@lst.de> <20191008115103.GA463127@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008115103.GA463127@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:51:03AM -0400, Arvind Sankar wrote:
> What I mean is, do there exist devices (which would necessarily support
> 64-bit DMA) that want to DMA using bigger than 4Gb buffers. Eg a GPU
> accelerator card with 16Gb of RAM on-board that wants to map 6Gb for DMA
> in one go, or 5 accelerator cards that are in one IOMMU domain and want
> to simultaneously map 1Gb each.

If you allocate more than 32-bits worth of address space the IOMMU
address space allocator will dip into 64-bit values if the device
dma mask supports that.
