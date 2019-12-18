Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6C124BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 16:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLRPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 10:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfLRPdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:33:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5AD206CB;
        Wed, 18 Dec 2019 15:33:15 +0000 (UTC)
Date:   Wed, 18 Dec 2019 10:33:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Tom Zanussi' <zanussi@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
Message-ID: <20191218103314.4125cd2a@gandalf.local.home>
In-Reply-To: <b4f7cbd8653e4e8eba5405b533c13469@AcuMS.aculab.com>
References: <20191211123316.GD12147@stackframe.org>
        <20191211103557.7bed6928@gandalf.local.home>
        <20191211110959.2baeb70f@gandalf.local.home>
        <1576178241.3309.2.camel@kernel.org>
        <4805b40c3e1547f8a26eeac6932f6499@AcuMS.aculab.com>
        <20191216110539.2b268d86@gandalf.local.home>
        <548eb8ae4b8742e4bf122af98b208925@AcuMS.aculab.com>
        <20191216132922.1bf6d5cd@gandalf.local.home>
        <b4f7cbd8653e4e8eba5405b533c13469@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 10:05:57 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 16 December 2019 18:29
> > On Mon, 16 Dec 2019 17:06:50 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> >   
> > > > Where original_val_a could be a byte, short, int, long or long long.  
> > >
> > > I'd sort of guessed that, but then the pointer type passed to tracing_map_cmp_##type()
> > > will always be 'u64 *' (since the field the address is taken of must be that type).
> > > Then the (u64 *) casts are no longer needed.
> > >
> > > Possibly you can just pass the u64 values to:
> > > tracing_map_cmp_##type(type a, type b)
> > > {
> > > 	return a > b ? 1 : a < b ? -1 : 0;
> > > }
> > >
> > > The high bit masking and sign extension is then implicit in the call.  
> > 
> > But these are used to pass into a compare function that takes compare
> > functions that are something other than numbers. They can be pointers
> > to strings.  
> 
> In that case I think I'd embed the u64 inside a structure and pass the structure
> address to the compare function.
> 

It's something we can clean up later. As this is going to be marked for
stable, and the code still works, I would like to keep the change as
simple as possible.

Thanks!

-- Steve
