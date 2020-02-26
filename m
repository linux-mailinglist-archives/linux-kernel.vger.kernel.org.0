Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D76170301
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBZPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:46:48 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31596 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgBZPqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:46:48 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01QFkesY002182;
        Wed, 26 Feb 2020 16:46:40 +0100
Date:   Wed, 26 Feb 2020 16:46:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] floppy: separate the FDC's base address from its
 registers
Message-ID: <20200226154640.GB2054@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200226080732.1913-1-w@1wt.eu>
 <20200226080732.1913-5-w@1wt.eu>
 <ab69fbdc-7ccb-05ef-6c25-7fb6ed6fce59@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab69fbdc-7ccb-05ef-6c25-7fb6ed6fce59@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 06:36:52PM +0300, Denis Efremov wrote:
> > One place in the ARM code used to check if the port was equal to FD_DOR,
> > this was changed to testing the register by applying a mask to the port,
> > as was already done in the sparc code.
> > 
> > The sparc, m68k and parisc code could now be slightly cleaned up to
> > benefit from the macro definitions above instead of the equivalent
> > hard-coded values.
> 
> Just to note for future ref: the mask (7) can be introduced as define
> during future clean up of these magic constants.

I'd rather not add it because if we finish to clean up the internal API,
then we can have fd_outb(value, base, reg) and fd_inb(base, reg) where
reg is one of FD_* and base the base address. In this context we don't
need the mask anymore since the register is placed there verbatim.

I do have another earlier patch which did just that, its just that I
attacked the problem from the wrong side, resulting in too many changes
at once for my taste. But I definitely see how we can finish that job
and make everything almost elegant.

Willy
