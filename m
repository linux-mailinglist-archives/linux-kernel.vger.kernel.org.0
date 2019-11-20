Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845081037D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 11:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfKTKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 05:44:42 -0500
Received: from verein.lst.de ([213.95.11.211]:39432 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbfKTKol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:44:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10C3B68AFE; Wed, 20 Nov 2019 11:44:38 +0100 (CET)
Date:   Wed, 20 Nov 2019 11:44:37 +0100
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
Message-ID: <20191120104437.GB3800@lst.de>
References: <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com> <20190725114348.GA30957@lst.de> <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com> <20191112071640.GA3343@lst.de> <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com> <20191113070312.GA2735@lst.de> <20191113095353.GA5937@lst.de> <0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com> <20191114081423.GA27407@lst.de> <6069128f-354c-e708-fa1d-d866dc186d57@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6069128f-354c-e708-fa1d-d866dc186d57@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:57:32AM +0800, Lu Baolu wrote:
> Hi,
>
> On 11/14/19 4:14 PM, Christoph Hellwig wrote:
>> On Thu, Nov 14, 2019 at 01:14:11PM +0800, Lu Baolu wrote:
>>> Could you please educate me what dma_supported() is exactly for? Will
>>> it always get called during boot? When will it be called?
>>
>> ->dma_supported is set when setting either the dma_mask or
>> dma_coherent_mask. These days it serves too primary purposes: reject
>> too small masks that can't be addressed, and provide any hooks needed
>> in the driver based on the mask.
>
> Thanks! So ->dma_supported might not be called before driver maps buffer
> and start DMA. Right?

It is supposed to, yes.
