Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98775A34F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfH3Kbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 06:31:53 -0400
Received: from 8bytes.org ([81.169.241.247]:52432 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfH3Kbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:31:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 21EFB1D5; Fri, 30 Aug 2019 12:31:51 +0200 (CEST)
Date:   Fri, 30 Aug 2019 12:31:51 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v7 1/7] iommu/vt-d: Don't switch off swiotlb if use
 direct dma
Message-ID: <20190830103150.GB29382@8bytes.org>
References: <20190823071735.30264-1-baolu.lu@linux.intel.com>
 <20190823071735.30264-2-baolu.lu@linux.intel.com>
 <20190823083956.GB24194@8bytes.org>
 <8fb96c3b-c535-6d90-e1e1-c635aec6f178@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb96c3b-c535-6d90-e1e1-c635aec6f178@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 10:17:30AM +0800, Lu Baolu wrote:
> If a system has any external port, through which an untrusted device
> might be connected, the external port itself should be marked as an
> untrusted device, and all devices beneath it just inherit this
> attribution.

Okay, makes sense.

> So during iommu driver initialization, we can easily know whether the
> system has (or potentially has) untrusted devices by iterating the
> device tree. I will add such check in the next version if no objections.

Sounds good, thanks Baolu.


	Joerg
