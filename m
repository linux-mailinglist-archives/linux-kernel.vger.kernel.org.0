Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04278EAB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfHOLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 07:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOLu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:50:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0272083B;
        Thu, 15 Aug 2019 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565869827;
        bh=TC8cY+S7B4xDtuHb0wdrt0hD72TEFu+adQ6QPjwQriI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxTNNeMZhFUE3yz6cnQKk8dGWv5LUlPSti8xdK1Sd6Lc2qYLMaQAd/Cn6QDyRmF3k
         UrTwwrIKwOy1e98zdArLykywxWOxXhCWz1MHnGQi5cpGbnEgmHMTayRCV3sO7VI3sU
         +DAzIQYC0UHICwUCkO3dTz6Zq7U0KkuLBj9TQPQw=
Date:   Thu, 15 Aug 2019 12:50:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
Message-ID: <20190815115021.7pbv5s2qbgsuitvh@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
 <1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
 <20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
 <1565858869.12818.51.camel@mhfsdcap03>
 <20190815095123.rzgtpklvhtjlqir4@willie-the-truck>
 <1565864318.14278.4.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565864318.14278.4.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I think speaking to Robin helped me a bit with this...

On Thu, Aug 15, 2019 at 06:18:38PM +0800, Yong Wu wrote:
> On Thu, 2019-08-15 at 10:51 +0100, Will Deacon wrote:
> > On Thu, Aug 15, 2019 at 04:47:49PM +0800, Yong Wu wrote:
> > > On Wed, 2019-08-14 at 15:41 +0100, Will Deacon wrote:
> > > > On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> > > > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > > > 
> > > > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > > > for all PTEs which means to enable bit32 of physical address. Here is
> > > > > the detailed remap relationship in the "4GB mode":
> > > > > CPU PA         ->    HW PA
> > > > > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > > > > 0x8000_0000          0x1_8000_0000 ...
> > > > > 0xc000_0000          0x1_c000_0000 ...
> > > > > 0x1_0000_0000        0x1_0000_0000 (No change)

[...]

> > > > The way I would like this quirk to work is that the io-pgtable code
> > > > basically sets bit 9 in the pte when bit 32 is set in the physical address,
> > > > and sets bit 4 in the pte when bit 33 is set in the physical address. It
> > > > would then do the opposite when converting a pte to a physical address.
> > > > 
> > > > That way, your driver can call the page table code directly with the high
> > > > addresses and we don't have to do any manual offsetting or range checking
> > > > in the page table code.
> > > 
> > > In this case, the mt8183 can work successfully while the "4gb
> > > mode"(mt8173/mt2712) can not.
> > > 
> > > In the "4gb mode", As the remap relationship above, we should always add
> > > bit32 in pte as we did in [2]. and need add bit32 in the
> > > "iova_to_phys"(Not always add.). That means the "4gb mode" has a special
> > > flow:
> > > a. Always add bit32 in paddr_to_iopte.
> > > b. Add bit32 only when PA < 0x40000000 in iopte_to_paddr.
> > 
> > I think this is probably at the heart of my misunderstanding. What is so
> > special about PAs (is this HW PA or CPU PA?) below 0x40000000? Is this RAM
> > or something else?
> 
> SRAM and HW register that IOMMU can not access.

Ok, so redrawing your table from above, I think we can say something like:


CPU Physical address
====================

0G	1G	2G	3G	4G	5G
|---A---|---B---|---C---|---D---|---E---|
+--I/O--+------------Memory-------------+


IOMMU output physical address
=============================

				4G	5G	6G	7G	8G
				|---E---|---B---|---C---|---D---|
				+------------Memory-------------+


Do you agree? If so, what happens to region 'A' (the I/O region) in the
IOMMU output physical address space. Is it accessible?

Anyway, I think it's the job of the driver to convert between the two
address spaces, so that:

  - On ->map(), bit 32 of the CPU physical address is set before calling
    into the iopgtable code

  - The result from ->iova_to_phys() should be the result from the
    iopgtable code, but with the top bit cleared for addresses over
    5G.

This assumes that:

  1. We're ok setting bit 9 in the ptes mapping region 'E'.
  2. The IOMMU page-table walker uses CPU physical addresses

Are those true?

Thanks,

Will
