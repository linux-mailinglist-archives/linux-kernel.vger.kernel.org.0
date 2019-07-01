Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7BE4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfD2Oaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:30:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:51344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728240AbfD2Oap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:30:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3579EAF1F;
        Mon, 29 Apr 2019 14:30:44 +0000 (UTC)
Date:   Mon, 29 Apr 2019 16:30:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
Message-ID: <20190429143037.3qu5fzdo6g26rsmf@pathway.suse.cz>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
 <20190426130204.23a5a05c@gandalf.local.home>
 <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
 <20190429091320.019e726b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429091320.019e726b@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-04-29 09:13:20, Steven Rostedt wrote:
> On Mon, 29 Apr 2019 13:08:01 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > > Looks like commit "vsprintf: Do not check address of well-known
> > > strings" removed the: "static noinline_for_stack"
> > > 
> > > Does pointer_string() need that still?  
> > 
> > Heh, it was removed by mistake and well hidden in the diff.
> > 
> > I have pushed Yue's fix into printk.git, branch
> > for-5.2-vsprintf-hardening
> > 
> > Thanks for the patch.
> 
> But doesn't it still need the "noinline_for_stack", that doesn't look
> like it changed.

Good question. I have just double checked it. And pointer_string() with
"noinline_for_stack" does not make any difference in the stack
usage here.


I actually played with this before:

"noinline_for_stack" is a black magic added by
the commit cf3b429b03e827c7180 ("vsprintf.c: use noinline_for_stack").

It is evidently useful in some cases. But I somehow doubt
that it really makes things better when used everywhere.
Therefore I have got a bit relaxed and omitted it in most
newly added functions that did not affect the results.

They are the same before and after the patchset:

pmladek@pathway:/prace/kernel/linux-printk> objdump -d lib/vsprintf.o | perl scripts/checkstack.pl
0x00000e12 symbol_string [vsprintf.o]:                  248
0x00000e6d symbol_string [vsprintf.o]:                  248
0x000012fb ip6_addr_string_sa [vsprintf.o]:             112
0x00001415 ip6_addr_string_sa [vsprintf.o]:             112
0x000028c6 resource_string.isra.9 [vsprintf.o]:         104
0x00002964 resource_string.isra.9 [vsprintf.o]:         104


Would you like to fix this clearly, for example, rebase and
put both "static noinline_for_stack" back or add yet
another commit or?

IMHO, it is not too important. Anyway, I am open for any
advice. I do not want to create more mess.

Best Regards,
Petr
