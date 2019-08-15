Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15D58ECD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfHON2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:28:49 -0400
Received: from verein.lst.de ([213.95.11.211]:46712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfHON2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:28:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D963768B05; Thu, 15 Aug 2019 15:28:45 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:28:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: turn hmm migrate_vma upside down v3
Message-ID: <20190815132845.GC12036@lst.de>
References: <20190814075928.23766-1-hch@lst.de> <8e3b17ef-0b9e-6866-128f-403c8ba3a322@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3b17ef-0b9e-6866-128f-403c8ba3a322@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:09:54PM -0700, Ralph Campbell wrote:
> Some of the patches seem to have been mangled in the mail.

Weird, I never had such a an issue with git-send-email.

But to be covered for such weird cases I also posted a git url
for exactly the tree I've been working on.

> I was able to edit them and apply to Jason's tree
> https://github.com/jgunthorpe/linux.git mmu_notifier branch.
> So for the series you can add:
>
> Tested-by: Ralph Campbell <rcampbell@nvidia.com>

Thanks!
