Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B211C8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 10:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfLLJJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 04:09:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:47892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfLLJJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:09:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9B62AE74;
        Thu, 12 Dec 2019 09:09:49 +0000 (UTC)
Date:   Thu, 12 Dec 2019 10:09:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191212090948.pcskgf6tc6iitkkk@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
 <b359a4a84d3dad08dc45899dc9b56e7323ffb734.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b359a4a84d3dad08dc45899dc9b56e7323ffb734.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-12-12 11:35:23, Benjamin Herrenschmidt wrote:
> On Tue, 2019-12-10 at 10:15 +0100, Petr Mladek wrote:
> > 
> > Anyway, here is the patch that we use. Could you please check if it
> > works for you as well? Does it make sense, please?
> 
> It doesn't fix my problem. tty0 remains the default console instead
> of ttyS0 with your patch applied.

Sigh, I see.

> I suspect for the same reason, we match uart0 which isn't preferred,
> so we enable that but don't put it "first" in the list, and since
> we break out of the loop we never match ttyS0.

Yeah.

> I see 3 simple ways out of this that don't involve breaking up match()
> 
>  - Bite the bullet and use my patch assuming that calling setup()
> multiple times is safe. I had a look at the two you had concerns
> with, the zilog ones seems safe. pl1011 will leak a clk_prepare
> reference but I think that's a non-issue for a kernel console
> (I may be wrong)

This does not sound much convincing to me. Leaking reference
is an issue, definitely.


>  - Rework the loop to try matching against the array entry pointed
> by preferred_console first.

IMHO, in principle, we are trying to solve the same problem as
the commit cf39bf58afdaabc0b86f141 ("printk: fix double
printing with earlycon").

And it was reverted because it broke some setups, see
the commit dac8bbbae1d0ccba96402d25d ("Revert "printk: fix double
printing with earlycon").

Trying only the preferred console first is less invasive but
it might cause exactly the same regression.


>  - Rework the loop to try matching the entries from the command line
> before trying to match the entries added by the platform/arch.
> (Easily done by flagging them in the array, I can cook a patch).

This makes some sense. It would allow user to override the fallback
defined by platform/arch.

IMHO, it would solve all the problems that motivated people working
on this. And it should not cause regression that forced us to
revert the backward search.

There is still some risk of regressions. But I would give it a try.

Best Regards,
Petr
