Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35260174C59
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCAI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 03:59:19 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31997 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCAI7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 03:59:19 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0218x5Td024221;
        Sun, 1 Mar 2020 09:59:05 +0100
Date:   Sun, 1 Mar 2020 09:59:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] floppy: remove dead code for drives scanning on ARM
Message-ID: <20200301085905.GA24218@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200226080732.1913-1-w@1wt.eu>
 <758c8079-50d7-7dc7-ca83-46be038f182b@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758c8079-50d7-7dc7-ca83-46be038f182b@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On Sun, Mar 01, 2020 at 11:21:45AM +0300, Denis Efremov wrote:
> Hi,
> 
> For patches 11-16,
> 
> I've checked the building on x86, arm.
> x86 shows no difference in floppy.o binary.

Thanks for double-checking.

> Compilation on arm tested (make rpc_defconfig).
> 
> I think that macro fd_outb from arm could be turned to
> the static inline function, like on mips or m68k arches. However,
> it's up to you if you want to keep the changes close to the
> original structure.

I wanted to do it as well but wondered if we should focus on limiting
changes or doign an in-depth cleanup. I'll see if I find time for
an extra round of per-arch cleanup, I think it doesn't cost much and
is probably worth being done.

> Please address the warnings and resend the patches:
(...)

Will do in my local patch set and I'll also CC RMK and the few other
persons having touched the ARM part of the driver.

> Everything else looks good to me. Thanks!

Thank you! I've also found an unlocking bug in the driver, when doing
ioctl(FDRESET), if a signal comes, we leave without unlocking. I'll
send a separate patch for this.

Regards,
Willy
