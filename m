Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C6A4FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfIBH06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 03:26:58 -0400
Received: from verein.lst.de ([213.95.11.211]:47663 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbfIBH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:26:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1340B227A8A; Mon,  2 Sep 2019 09:26:52 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:26:51 +0200
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/7] swiotlb: Zero out bounce buffer for untrusted
 device
Message-ID: <20190902072651.GA28587@lst.de>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com> <20190830071718.16613-4-baolu.lu@linux.intel.com> <20190830073130.GA10471@lst.de> <a5edd268-5ba7-a8b6-d883-f4761e52fdff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5edd268-5ba7-a8b6-d883-f4761e52fdff@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 09:58:27AM +0800, Lu Baolu wrote:
> The untrusted flag is introduced in another series. I agree that we
> could consider to move it to struct device, but I think making it
> in a separated patch looks better.

A separate patch is of course a good idea.  But it needs to happen
before we can use the flag in the swiotlb code.

