Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAC7A930
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfG3NJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 09:09:49 -0400
Received: from verein.lst.de ([213.95.11.211]:51165 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfG3NJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:09:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B0B98227A8A; Tue, 30 Jul 2019 15:09:44 +0200 (CEST)
Date:   Tue, 30 Jul 2019 15:09:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: turn the hmm migrate_vma upside down
Message-ID: <20190730130944.GA4566@lst.de>
References: <20190729142843.22320-1-hch@lst.de> <20190730123218.GA24038@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730123218.GA24038@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:32:24PM +0000, Jason Gunthorpe wrote:
> Does this only impact hmm users, or does migrate.c have a broader
> usage?

migrate.c really contains two things:  the traditional page migration
code implementing aops ->migrate semantics, and migrate_vma and its
callbacks.  The first part is broader, the second part is hmm specific
(and should probably have been in a file of its own, given that it is
guarded off CONFIG_MIGRATE_VMA_HELPER).  This series only touched the
latter part.
