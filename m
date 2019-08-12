Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88689802
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHLHkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:40:33 -0400
Received: from verein.lst.de ([213.95.11.211]:45800 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfHLHkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:40:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 82E3568BFE; Mon, 12 Aug 2019 09:40:29 +0200 (CEST)
Date:   Mon, 12 Aug 2019 09:40:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 2/5] resource: add a not device managed
 request_free_mem_region variant
Message-ID: <20190812074029.GA4709@lst.de>
References: <20190811081247.22111-1-hch@lst.de> <20190811081247.22111-3-hch@lst.de> <20190811225252.GB15116@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811225252.GB15116@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 10:52:58PM +0000, Jason Gunthorpe wrote:
> It is a bit jarring to have something called devm_* that doesn't
> actually do the devm_ part on some paths.
> 
> Maybe this function should be called __request_free_mem_region() with
> another name wrapper macro?

Seems like a little more churn than required, but I could do it.
