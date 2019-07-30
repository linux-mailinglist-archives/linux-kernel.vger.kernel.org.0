Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23B87A086
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 07:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfG3Fqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 01:46:38 -0400
Received: from verein.lst.de ([213.95.11.211]:47639 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG3Fqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:46:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABD1D68AEF; Tue, 30 Jul 2019 07:46:33 +0200 (CEST)
Date:   Tue, 30 Jul 2019 07:46:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] mm: remove the MIGRATE_PFN_WRITE flag
Message-ID: <20190730054633.GA28515@lst.de>
References: <20190729142843.22320-1-hch@lst.de> <20190729142843.22320-10-hch@lst.de> <20190729233044.GA7171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729233044.GA7171@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 07:30:44PM -0400, Jerome Glisse wrote:
> On Mon, Jul 29, 2019 at 05:28:43PM +0300, Christoph Hellwig wrote:
> > The MIGRATE_PFN_WRITE is only used locally in migrate_vma_collect_pmd,
> > where it can be replaced with a simple boolean local variable.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> NAK that flag is useful, for instance a anonymous vma might have
> some of its page read only even if the vma has write permission.
> 
> It seems that the code in nouveau is wrong (probably lost that
> in various rebase/rework) as this flag should be use to decide
> wether to map the device memory with write permission or not.
> 
> I am traveling right now, i will investigate what happened to
> nouveau code.

We can add it back when needed pretty easily.  Much of this has bitrotted
way to fast, and the pending ppc kvmhmm code doesn't need it either.
