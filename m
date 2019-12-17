Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE251227F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLQJxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 04:53:44 -0500
Received: from 8bytes.org ([81.169.241.247]:57642 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfLQJxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:53:44 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2AAA1286; Tue, 17 Dec 2019 10:53:43 +0100 (CET)
Date:   Tue, 17 Dec 2019 10:53:41 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        iommu@lists.linux-foundation.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Message-ID: <20191217095341.GG8689@8bytes.org>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
 <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 01:57:41PM +0800, Kai-Heng Feng wrote:
> Hi Joerg,
> 
> > On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
> >> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> >> 
> >> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> >> the same here to avoid screen flickering on 4K monitor.
> > 
> > Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
> > identity map the GPU device?
> 
> Ok, there's set_device_exclusion_range() to exclude the device from IOMMU.
> However I don't know how to generate range_start and range_length, which are read from ACPI.

set_device_exclusion_range() is not the solution here. The best is if
the GPU device is put into a passthrough domain at boot, in which it
will be identity mapped. DMA still goes through the IOMMU in this case,
but it only needs to lookup the device-table, page-table walks will not
be done anymore.

The best way to implement this is to put it into the
amd_iommu_add_device() in drivers/iommu/amd_iommu.c. There is this
check:

        if (dev_data->iommu_v2)
		iommu_request_dm_for_dev(dev);

The iommu_request_dm_for_dev() function causes the device to be identity
mapped. The check can be extended to also check for a device white-list
for devices that need identity mapping.

HTH,

	Joerg

