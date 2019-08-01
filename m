Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF59D7D696
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfHAHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:46:21 -0400
Received: from verein.lst.de ([213.95.11.211]:41145 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbfHAHqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:46:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2CC4D227A81; Thu,  1 Aug 2019 09:46:15 +0200 (CEST)
Date:   Thu, 1 Aug 2019 09:46:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] nouveau: simplify nouveau_dmem_migrate_to_ram
Message-ID: <20190801074614.GC16178@lst.de>
References: <20190729142843.22320-1-hch@lst.de> <20190729142843.22320-6-hch@lst.de> <20190731095735.GB18807@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731095735.GB18807@in.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:27:35PM +0530, Bharata B Rao wrote:
> > -	kfree(fault->dma);
> > +	return VM_FAULT_SIGBUS;

> Looks like nouveau_dmem_fault_copy_one() is now returning VM_FAULT_SIGBUS
> for success case. Is this expected?

No, fixed.
