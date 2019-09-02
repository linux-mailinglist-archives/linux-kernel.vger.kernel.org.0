Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F958A507A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfIBH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 03:59:04 -0400
Received: from verein.lst.de ([213.95.11.211]:47904 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbfIBH7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:59:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 48EE8227A8A; Mon,  2 Sep 2019 09:59:00 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:58:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 2/3] pagewalk: separate function pointers from iterator
 data
Message-ID: <20190902075859.GA29137@lst.de>
References: <20190828141955.22210-1-hch@lst.de> <20190828141955.22210-3-hch@lst.de> <20190901184530.GA18656@roeck-us.net> <20190901193601.GB5208@mellanox.com> <b26ac5ae-a90c-7db5-a26c-3ace2f1530c7@roeck-us.net> <20190902055156.GA24116@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902055156.GA24116@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 05:51:58AM +0000, Jason Gunthorpe wrote:
> On Sun, Sep 01, 2019 at 01:35:16PM -0700, Guenter Roeck wrote:
> > > I belive the macros above are missing brackets.. Can you confirm the
> > > below takes care of things? I'll add a patch if so
> > > 
> > 
> > Good catch. Yes, that fixes the build problem.
> 
> I added this to the hmm tree to fix it:

This looks good.  Although I still haven't figure out how this is
related to the pagewalk changes to start with..
