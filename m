Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831E751E30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 00:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFXWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 18:25:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:30736 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfFXWZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:25:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 15:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="359696051"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2019 15:25:15 -0700
Date:   Mon, 24 Jun 2019 15:28:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 10/22] iommu: Fix compile error without IOMMU_API
Message-ID: <20190624152830.20bace1d@jacob-builder>
In-Reply-To: <20190618151031.00004bbd@huawei.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190618151031.00004bbd@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:10:31 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Sun, 9 Jun 2019 06:44:10 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > struct page_response_msg needs to be defined outside
> > CONFIG_IOMMU_API.  
> 
> What was the error? 
> 
struct page_response_msg can be undefined if under CONFIG_IOMMU_API.
This was resolved after Jean move it to uapi. Sorry, I could have made
it more clear, not a fix for mainline kernel bug just a patch for
previous patch in Jean's API tree.
> If this is a fix for an earlier patch in this series role it in there
> (or put it before it). If more general we should add a fixes tag.
> 
> Jonathan
>  [...]  
> 
> 

[Jacob Pan]
