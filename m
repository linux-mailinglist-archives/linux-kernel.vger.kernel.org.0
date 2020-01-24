Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D3148876
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391304AbgAXO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:29:19 -0500
Received: from 8bytes.org ([81.169.241.247]:60796 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391259AbgAXO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:29:12 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 44E89AA1; Fri, 24 Jan 2020 15:29:10 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:29:07 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     suravee.suthikulpanit@amd.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during
 init
Message-ID: <20200124142907.GA27081@8bytes.org>
References: <20200123223214.2566-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123223214.2566-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:32:14PM -0700, Shuah Khan wrote:
> init_iommu_perf_ctr() clobbers the register when it checks write access
> to IOMMU perf counters and fails to restore when they are writable.
> 
> Add save and restore to fix it.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> -- Fix bug in sucessful return path. Add a return instead of
>    fall through to pc_false error case
> 
>  drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied for v5.5, thanks.
