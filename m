Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB75F87E05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436569AbfHIPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:31:04 -0400
Received: from 8bytes.org ([81.169.241.247]:48554 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:31:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E28C43D0; Fri,  9 Aug 2019 17:31:01 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:31:00 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/amd: Re-factor guest virtual APIC (de-)activation
 code
Message-ID: <20190809153100.GB12930@8bytes.org>
References: <1563908430-81636-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563908430-81636-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:00:37PM +0000, Suthikulpanit, Suravee wrote:
> Re-factore the logic for activate/deactivate guest virtual APIC mode (GAM)
> into helper functions, and export them for other drivers (e.g. SVM).
> to support run-time activate/deactivate of SVM AVIC.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu.c       | 85 +++++++++++++++++++++++++++++------------
>  drivers/iommu/amd_iommu_types.h |  9 +++++
>  include/linux/amd-iommu.h       | 12 ++++++
>  3 files changed, 82 insertions(+), 24 deletions(-)

Applied, thanks Suravee.
