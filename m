Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280EEFADAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 10:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKMJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 04:54:02 -0500
Received: from verein.lst.de ([213.95.11.211]:33248 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfKMJyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:54:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33EB268B05; Wed, 13 Nov 2019 10:53:53 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:53:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
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
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
Message-ID: <20191113095353.GA5937@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com> <20190725031717.32317-3-baolu.lu@linux.intel.com> <20190725054413.GC24527@lst.de> <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com> <20190725114348.GA30957@lst.de> <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com> <20191112071640.GA3343@lst.de> <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com> <20191113070312.GA2735@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113070312.GA2735@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 08:03:12AM +0100, Christoph Hellwig wrote:
> Indeed.  And one idea would be to lift the code in the powerpc
> dma_iommu_ops that check a flag and use the direct ops to the generic
> dma code and a flag in struct device.  We can then switch the intel
> iommu ops (and AMD Gart) over to it.

Let me know what you think of the branch below.  Only compile tested
and booted on qemu with an emulated intel iommu:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass
