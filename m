Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0251383FC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 00:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgAKXWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 18:22:35 -0500
Received: from mx.sdf.org ([205.166.94.20]:49296 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbgAKXWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 18:22:35 -0500
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 00BNMN9l022260
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 11 Jan 2020 23:22:24 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 00BNMp7Q002616;
        Sat, 11 Jan 2020 23:22:51 GMT
Date:   Sat, 11 Jan 2020 23:22:51 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <202001112322.00BNMp7Q002616@sdf.org>
To:     andy.shevchenko@gmail.com, kbusch@kernel.org, lkml@sdf.org
Subject: Re: [PATCH] lib/list_sort: fix function type mismatches
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, mchehab+samsung@kernel.org,
        samitolvanen@google.com, st5pub@yandex.ru
In-Reply-To: <202001111144.00BBiXEq002960@sdf.org>
References: <20200110225602.91663-1-samitolvanen@google.com>,
    <202001110830.00B8USV0024843@sdf.org>,
    <CAHp75VcWryeiN_bwJjFk=RO1k+H5q7h6_3oGArf1XzF-6dNxKg@mail.gmail.com>,
    <202001111144.00BBiXEq002960@sdf.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend with corrected e-mail address and more thoughts.)

On Sat, 11 Jan 2020 at 12:35, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> Hint: When you post Message-Id you may prefix them with
> https://lore.kernel.org/r/ which makes search a bit more convenient
> and faster.

I just learned that https://marc.info/?i= also works, so
https://lore.kernel.org/r/20191007135656.37734-1-andriy.shevchenko@linux.intel.com
https://marc.info/?i=20191007135656.37734-1-andriy.shevchenko@linux.intel.com

https://lore.kernel.org/r/20190416154522.65aaa348161fc581181b56d9@linux-foundation.org
https://marc.info/?i=20190416154522.65aaa348161fc581181b56d9@linux-foundation.org

> For the record, I have just checked users of list_sort() in regard to
> constify of priv parameter and only ACPI HMAT is using it as not
> const. UBIFS and XFS do not change the data (if I didn't miss
> anything).

Yes, that initiator_cmp() at drivers/acpi/hmat/hmat.c:526 is... interesting.

Basically, it wants to fill in a bitmap of all of the processor_pxm
identifiers, so it avoids having a separate list traversal by
setting bits in the compare function (which is guaranteed to visit
each list element at least once).

It ends up setting each bit 2*log2(n) times (since there are an
average of log2(n) compares per element and each compare sets two
bits), but it makes the code smaller.  And although it make the
aggressive performance optimizer in me cringe, I have to agree this
is not performance-critical code and so it's a reasonable thing to do.

I do note, however, that the list_sort is almost immediately followed
by a list_for_each_entry() loop and maybe the bitmap computation
could be folded in there.  Basically start the loop with:

	unsigned int pxm = -1u;	/* Invalid sentinel value */
	list_for_each_entry(initiator, &initiators, node) {
		u32 value;

		if (initiator->processor_pxm != pxm) {
			pxm = initiator->processor_pxm;
			set_bit(pxm, p_nodes);
		} else if (!test_bit(pxm, p_nodes)) {
			continue;
		}

... but oh, whoops, that won't work.  The "almost immediately"
glosses over a second loop, so there are multiple passes over the
initiators list, while we want the bitmap set up only once.

What we should probably do is just cast away the const in the cmp
function.  That's a strange thing to do, which is appropriate because
the code is doing something strange.

It might be too subtle, but given the semantics guaranteed by list_sort,
it would suffice to set only the bit corresponding to the *second*
argument to cmp(), plus the bit corresponding to the first element
of the input (not yet sorted) list.

Cc: to Keith Busch <kbusch@kernel.org>, who wrote that code.
Keith, is there a better way we could avoid the non-const priv
parameter, just for the sake of code cleanliness in <list_sort.h>?
