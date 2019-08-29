Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8117EA1318
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfH2H6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 03:58:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:60991 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfH2H6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:58:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 00:58:14 -0700
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="171821817"
Received: from jkrzyszt-desk.igk.intel.com (HELO jkrzyszt-desk.ger.corp.intel.com) ([172.22.244.17])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 00:58:12 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device hot re-plug
Date:   Thu, 29 Aug 2019 09:58:05 +0200
Message-ID: <3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <0cf4e930-1132-1e7f-815b-57a08a1fe5de@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com> <3275480.HMaYE7B3nd@jkrzyszt-desk.ger.corp.intel.com> <0cf4e930-1132-1e7f-815b-57a08a1fe5de@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thursday, August 29, 2019 3:43:31 AM CEST Lu Baolu wrote:
> Hi Janusz,
> 
> On 8/28/19 10:17 PM, Janusz Krzysztofik wrote:
> >> We should avoid kernel panic when a intel_unmap() is called against
> >> a non-existent domain.
> > Does that mean you suggest to replace
> > 	BUG_ON(!domain);
> > with something like
> > 	if (WARN_ON(!domain))
> > 		return;
> > and to not care of orphaned mappings left allocated?  Is there a way to 
inform
> > users that their active DMA mappings are no longer valid and they 
shouldn't
> > call dma_unmap_*()?
> > 
> >> But we shouldn't expect the IOMMU driver not
> >> cleaning up the domain info when a device remove notification comes and
> >> wait until all file descriptors being closed, right?
> > Shouldn't then the IOMMU driver take care of cleaning up resources still
> > allocated on device remove before it invalidates and forgets their 
pointers?
> > 
> 
> You are right. We need to wait until all allocated resources (iova and
> mappings) to be released.
> 
> How about registering a callback for BUS_NOTIFY_UNBOUND_DRIVER, and
> removing the domain info when the driver detachment completes?

Device core calls BUS_NOTIFY_UNBOUND_DRIVER on each driver unbind, regardless 
of a device being removed or not.  As long as the device is not unplugged and 
the BUS_NOTIFY_REMOVED_DEVICE notification not generated, an unbound driver is 
not a problem here.
Morever, BUS_NOTIFY_UNBOUND_DRIVER  is called even before 
BUS_NOTIFY_REMOVED_DEVICE so that wouldn't help anyway.
Last but not least, bus events are independent of the IOMMU driver use via 
DMA-API it exposes.

If keeping data for unplugged devices and reusing it on device re-plug is not 
acceptable then maybe the IOMMU driver should perform reference counting of 
its internal resources occupied by DMA-API users and perform cleanups on last 
release?

Thanks,
Janusz


> > Thanks,
> > Janusz
> 
> Best regards,
> Baolu
> 




