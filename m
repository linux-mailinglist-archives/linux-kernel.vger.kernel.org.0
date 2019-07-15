Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD296685EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 11:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfGOJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 05:03:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:44347 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbfGOJDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:03:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6F93WuZ025986;
        Mon, 15 Jul 2019 04:03:33 -0500
Message-ID: <25c3813ab1c2943658d7e79756803801b14a34db.camel@kernel.crashing.org>
Subject: Re: [PATCH] nvme: Add support for Apple 2018+ models
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Paul Pawlowski <paul@mrarm.io>
Date:   Mon, 15 Jul 2019 19:03:31 +1000
In-Reply-To: <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
References: <71b009057582cd9c82cff2b45bc1af846408bcf7.camel@kernel.crashing.org>
         <20190715081041.GB31791@lst.de>
         <c088cb27f99adbcc1f8faf8e86167903f11593b8.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 18:43 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2019-07-15 at 10:10 +0200, Christoph Hellwig wrote:
> > > +	/*
> > > +	 * Apple 2018 and latter variant has a few issues
> > > +	 */
> > > +	NVME_QUIRK_APPLE_2018			= (1 << 10),
> > 
> > We try to have quirks for the actual issue, so this should be one quirk
> > for the irq vectors issues, and another for the sq entry size.  Note that
> > NVMe actually has the concept of an I/O queue entry size (IOSQES in the
> > Cc register based on values reported in the SQES field in Identify
> > Controller.  Do these controllers report anything interesting there?
> 
> Ah good to know, I'll dig.

Interesting... so SQES is 0x76, indicating that it supports the larger
entry size but not that it mandates it.

However, we configure CC:IOSQES with 6 and the HW fails unless we have
the 128 bytes entry size.

So the HW is bogus, but we can probably sort that by doing a better job
at fixing up SQES in the identify on the Apple HW, and then actually
using it for the SQ.

I checked and CC is 0x00460001 so it takes our write of "6" fine. I
think they just ignore the value.

How do you want to proceed here ? Should I go all the way at attempting
to honor sqes "mandatory" size field (and quirk *that*) or just I go
the simpler way and stick to shift 6 unless Apple ?

If I go the complicated path, should I do the same with cq size
(knowing that no known HW has a non-4 mandatory size there and we don't
know of a HW bug... yet).

Cheers,
Ben.


