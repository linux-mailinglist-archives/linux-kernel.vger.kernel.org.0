Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6465FF75DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfKKOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 09:02:55 -0500
Received: from 8bytes.org ([81.169.241.247]:51270 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfKKOCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:02:55 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 77629120; Mon, 11 Nov 2019 15:02:53 +0100 (CET)
Date:   Mon, 11 Nov 2019 15:02:52 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        edison.hsieh@mediatek.com
Subject: Re: [PATCH v5 0/7] Improve tlb range flush
Message-ID: <20191111140251.GA18333@8bytes.org>
References: <1572850868-22315-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572850868-22315-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:01:01PM +0800, Yong Wu wrote:
> Yong Wu (7):
>   iommu/mediatek: Correct the flush_iotlb_all callback
>   iommu/mediatek: Add a new tlb_lock for tlb_flush
>   iommu/mediatek: Use gather to achieve the tlb range flush
>   iommu/mediatek: Delete the leaf in the tlb_flush
>   iommu/mediatek: Move the tlb_sync into tlb_flush
>   iommu/mediatek: Get rid of the pgtlock
>   iommu/mediatek: Reduce the tlb flush timeout value

Applied, thanks.
