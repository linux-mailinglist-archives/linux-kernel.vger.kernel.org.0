Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF1A392A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 16:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfH3OXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 10:23:53 -0400
Received: from 8bytes.org ([81.169.241.247]:52526 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfH3OXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:23:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7DC43246; Fri, 30 Aug 2019 16:23:52 +0200 (CEST)
Date:   Fri, 30 Aug 2019 16:23:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: fix for dereferencing before null checking
Message-ID: <20190830142350.GC11578@8bytes.org>
References: <1566611232-165399-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566611232-165399-1-git-send-email-linyunsheng@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 09:47:12AM +0800, Yunsheng Lin wrote:
>  drivers/iommu/dma-iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.
