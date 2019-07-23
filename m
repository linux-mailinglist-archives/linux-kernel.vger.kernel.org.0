Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88B71B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfGWPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:21:46 -0400
Received: from 8bytes.org ([81.169.241.247]:45014 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfGWPVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:21:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5993E5D2; Tue, 23 Jul 2019 17:21:44 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:21:44 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Message-ID: <20190723152144.GC1524@8bytes.org>
References: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Tue, Jul 16, 2019 at 04:29:16AM +0000, Suthikulpanit, Suravee wrote:
> AMD IOMMU requires IntCapXT registers to be setup in order to generate
> its own interrupts (for Event Log, PPR Log, and GA Log) with 32-bit
> APIC destination ID. Without this support, AMD IOMMU MSI interrupts
> will not be routed correctly when booting the system in X2APIC mode.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Patch looks good to me, just a Fixes tag is missing. Can you send me
one? I will queue the patch up for v5.3 then.


Regards,

	Joerg
