Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D43915AE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHRJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:03:40 -0400
Received: from verein.lst.de ([213.95.11.211]:39051 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRJDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:03:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 175DB227A81; Sun, 18 Aug 2019 11:03:35 +0200 (CEST)
Date:   Sun, 18 Aug 2019 11:03:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
Message-ID: <20190818090334.GA20462@lst.de>
References: <20190816065434.2129-1-hch@lst.de> <20190816065434.2129-2-hch@lst.de> <20190816140134.1f3225bed9bf2734c03341b1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816140134.1f3225bed9bf2734c03341b1@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 02:01:34PM -0700, Andrew Morton wrote:
> On Fri, 16 Aug 2019 08:54:31 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > Just add a simple macro that passes a NULL dev argument to
> > dev_request_free_mem_region, and call request_mem_region in the
> > function for that particular case.
> 
> Nit:
> 
> > +struct resource *request_free_mem_region(struct resource *base,
> > +		unsigned long size, const char *name);
> 
> This isn't a macro ;)

Oops, the changelog needs updating vs the first version of course.
