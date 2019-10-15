Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B851D7635
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfJOMO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 08:14:29 -0400
Received: from 8bytes.org ([81.169.241.247]:47516 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfJOMO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:14:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 445092D9; Tue, 15 Oct 2019 14:14:26 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:14:24 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        "Hook, Gary" <Gary.Hook@amd.com>
Subject: Re: iommu: amd: Fix incorrect PASID decoding from event log
Message-ID: <20191015121424.GM14518@8bytes.org>
References: <1571083556-105953-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571083556-105953-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:06:05PM +0000, Suthikulpanit, Suravee wrote:
> IOMMU Event Log encodes 20-bit PASID for events:
>     ILLEGAL_DEV_TABLE_ENTRY
>     IO_PAGE_FAULT
>     PAGE_TAB_HARDWARE_ERROR
>     INVALID_DEVICE_REQUEST
> as:
>     PASID[15:0]  = bit 47:32
>     PASID[19:16] = bit 19:16
> 
> Note that INVALID_PPR_REQUEST event has different encoding
> from the rest of the events as the following:
>     PASID[15:0]  = bit 31:16
>     PASID[19:16] = bit 45:42
> 
> So, fixes the decoding logic.
> 
> Fixes: d64c0486ed50 ("iommu/amd: Update the PASID information printed to the system log")
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Gary R Hook <gary.hook@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu.c       | 5 +++--
>  drivers/iommu/amd_iommu_types.h | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

Applied for v5.4, thanks Suravee.

