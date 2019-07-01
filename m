Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CF2B78E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE0Oba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:31:30 -0400
Received: from 8bytes.org ([81.169.241.247]:40332 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfE0Oba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:31:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6B0022AF; Mon, 27 May 2019 16:31:29 +0200 (CEST)
Date:   Mon, 27 May 2019 16:31:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Use right function to get group for device
Message-ID: <20190527143123.GA12745@8bytes.org>
References: <20190521072735.27401-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521072735.27401-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:27:35PM +0800, Lu Baolu wrote:
> The iommu_group_get_for_dev() will allocate a group for a
> device if it isn't in any group. This isn't the use case
> in iommu_request_dm_for_dev(). Let's use iommu_group_get()
> instead.
> 
> Fixes: d290f1e70d85a ("iommu: Introduce iommu_request_dm_for_dev()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
