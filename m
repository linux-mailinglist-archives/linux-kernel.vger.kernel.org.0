Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16A901B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfHPMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:36:12 -0400
Received: from verein.lst.de ([213.95.11.211]:55194 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfHPMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:36:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8145268B05; Fri, 16 Aug 2019 14:36:07 +0200 (CEST)
Date:   Fri, 16 Aug 2019 14:36:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: add a not device managed memremap_pages v2
Message-ID: <20190816123607.GA22681@lst.de>
References: <20190816065434.2129-1-hch@lst.de> <20190816123356.GE5412@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816123356.GE5412@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Changes since v1:
> >  - don't overload devm_request_free_mem_region
> >  - export the memremap_pages and munmap_pages as kvmppc can be a module
> 
> What tree do we want this to go through? Dan are you running a pgmap
> tree still? Do we know of any conflicts?

The last changes in this area went through the hmm tree.  There are
now known conflicts, and the kvmppc drivers that needs this already
has a dependency on the hmm tree for the migrate_vma_* changes.
