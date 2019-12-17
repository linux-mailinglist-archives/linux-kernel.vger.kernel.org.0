Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9312286F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfLQKOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 05:14:00 -0500
Received: from 8bytes.org ([81.169.241.247]:57680 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfLQKOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:14:00 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 14A50286; Tue, 17 Dec 2019 11:13:59 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:13:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Xiaotao Yin <xiaotao.yin@windriver.com>
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Kexin.Hao@windriver.com
Subject: Re: [PATCH V3] iommu/iova: Init the struct iova to fix the possible
 memleak
Message-ID: <20191217101357.GK8689@8bytes.org>
References: <20191210042704.14693-1-xiaotao.yin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210042704.14693-1-xiaotao.yin@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:27:04PM +0800, Xiaotao Yin wrote:
> Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
> Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Okay, missed that. Replaced the previous patch by this one. Thanks.

