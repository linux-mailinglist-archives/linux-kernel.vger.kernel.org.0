Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8FCEB2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfJGRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 13:55:32 -0400
Received: from verein.lst.de ([213.95.11.211]:39764 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGRzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:55:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D13CA68B20; Mon,  7 Oct 2019 19:55:28 +0200 (CEST)
Date:   Mon, 7 Oct 2019 19:55:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007175528.GA21857@lst.de>
References: <20191007022454.GA5270@rani.riverdale.lan> <20191007073448.GA882@lst.de> <20191007175430.GA32537@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175430.GA32537@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> It doesn't boot with the patch. Won't it go
> 	dma_get_required_mask
> 	-> intel_get_required_mask
> 	-> iommu_need_mapping
> 	-> dma_get_required_mask
> ?
> 
> Should the call to dma_get_required_mask in iommu_need_mapping be
> replaced with dma_direct_get_required_mask on top of your patch?

Yes, sorry.
