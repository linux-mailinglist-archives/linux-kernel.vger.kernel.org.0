Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153A8637EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGIOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:30:41 -0400
Received: from verein.lst.de ([213.95.11.211]:43360 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:30:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C51FA68B02; Tue,  9 Jul 2019 16:30:38 +0200 (CEST)
Date:   Tue, 9 Jul 2019 16:30:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: hmm_range_fault related fixes and legacy API removal v2
Message-ID: <20190709143038.GA3092@lst.de>
References: <20190703220214.28319-1-hch@lst.de> <20190705123336.GA31543@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705123336.GA31543@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:33:36AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 03, 2019 at 03:02:08PM -0700, Christoph Hellwig wrote:
> > Hi Jérôme, Ben and Jason,
> > 
> > below is a series against the hmm tree which fixes up the mmap_sem
> > locking in nouveau and while at it also removes leftover legacy HMM APIs
> > only used by nouveau.
> 
> As much as I like this series, it won't make it to this merge window,
> sorry.

Note that patch 4 fixes a pretty severe locking bug, and 1-3 is just
preparation for that.  
