Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0DEFD01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 13:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfKEMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 07:15:17 -0500
Received: from 8bytes.org ([81.169.241.247]:50602 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfKEMPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:15:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1DCFD450; Tue,  5 Nov 2019 13:15:15 +0100 (CET)
Date:   Tue, 5 Nov 2019 13:15:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191105121508.GA3479@8bytes.org>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-6-will@kernel.org>
 <20191030193148.GA8432@8bytes.org>
 <20191031154247.GB28061@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031154247.GB28061@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Thu, Oct 31, 2019 at 03:42:47PM +0000, Will Deacon wrote:
> Generally, I think unloading the IOMMU driver module while there are
> active users is a pretty bad idea, much like unbinding the driver via
> /sys in the same situation would also be fairly daft. However, I *think*
> the code in __device_release_driver() tries to deal with this by
> iterating over the active consumers and ->remove()ing them first.
> 
> I'm without hardware access at the moment, so I haven't been able to
> test this myself. We could nobble the module_exit() hook, but there's
> still the "force unload" option depending on the .config.

Okay, but besides the force-unload case, can we prevent accidential
unloading by taking a reference to the module in add_device() and release
it in remove_device()?

Regards,

	Joerg
