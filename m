Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE0A68FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 14:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfICMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 08:52:14 -0400
Received: from 8bytes.org ([81.169.241.247]:52958 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfICMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:52:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A4DE0284; Tue,  3 Sep 2019 14:52:11 +0200 (CEST)
Date:   Tue, 3 Sep 2019 14:52:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v1 1/2] iommu: pass cell_count = -1 to
 of_for_each_phandle with cells_name
Message-ID: <20190903125210.GB11530@8bytes.org>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 03:28:45PM +0200, Uwe Kleine-K�nig wrote:
> Currently of_for_each_phandle ignores the cell_count parameter when a
> cells_name is given. I intend to change that and let the iterator fall
> back to a non-negative cell_count if the cells_name property is missing
> in the referenced node.
> 
> To not change how existing of_for_each_phandle's users iterate, fix them
> to pass cell_count = -1 when also cells_name is given which yields the
> expected behaviour with and without my change.
> 
> Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/iommu/arm-smmu.c     | 2 +-
>  drivers/iommu/mtk_iommu_v1.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>

