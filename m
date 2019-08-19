Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC491D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 08:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfHSGaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 02:30:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44879 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfHSGaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:30:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0548B68B20; Mon, 19 Aug 2019 08:30:16 +0200 (CEST)
Date:   Mon, 19 Aug 2019 08:30:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: add a not device managed memremap_pages v3
Message-ID: <20190819063015.GA20248@lst.de>
References: <20190818090557.17853-1-hch@lst.de> <20190819052752.GD8784@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819052752.GD8784@in.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:57:52AM +0530, Bharata B Rao wrote:
> On Sun, Aug 18, 2019 at 11:05:53AM +0200, Christoph Hellwig wrote:
> > Hi Dan and Jason,
> > 
> > Bharata has been working on secure page management for kvmppc guests,
> > and one I thing I noticed is that he had to fake up a struct device
> > just so that it could be passed to the devm_memremap_pages
> > instrastructure for device private memory.
> > 
> > This series adds non-device managed versions of the
> > devm_request_free_mem_region and devm_memremap_pages functions for
> > his use case.
> 
> Tested kvmppc ultravisor patchset with migrate_vma changes and this
> patchset. (Had to manually patch mm/memremap.c instead of kernel/memremap.c
> though)

Oh.  I rebased to the hmm tree, and that didn't have the rename yet.
And I didn't even notice that as git handled it transparently.
