Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF7A1F14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfH2P12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 11:27:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2P12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:27:28 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i3MKZ-00031b-0r; Thu, 29 Aug 2019 15:27:23 +0000
Date:   Thu, 29 Aug 2019 17:27:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Peikan Tsai <peikantsai@gmail.com>, arve@android.com,
        tkjos@android.com, maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190829152721.ttsyfwaeygmwmcu7@wittgenstein>
References: <20190829054953.GA18328@mark-All-Series>
 <20190829064229.GA30423@kroah.com>
 <20190829135359.GB63638@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190829135359.GB63638@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:53:59AM -0400, Joel Fernandes wrote:
> On Thu, Aug 29, 2019 at 08:42:29AM +0200, Greg KH wrote:
> > On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
> [snip] 
> > > The allocated size for each binder_thread is 512 bytes by kzalloc.
> > > Because the size of binder_thread is fixed and it's only 304 bytes.
> > > It will save 208 bytes per binder_thread when use create a kmem_cache
> > > for the binder_thread.
> > 
> > Are you _sure_ it really will save that much memory?  You want to do
> > allocations based on a nice alignment for lots of good reasons,
> > especially for something that needs quick accesses.
> 
> Alignment can be done for slab allocations, kmem_cache_create() takes an
> align argument. I am not sure what the default alignment of objects is
> though (probably no default alignment). What is an optimal alignment in your
> view?

Probably SLAB_HWCACHE_ALIGN would make most sense.

> 
> > Did you test your change on a system that relies on binder and find any
> > speed improvement or decrease, and any actual memory savings?
> > 
> > If so, can you post your results?
> 
> That's certainly worth it and I thought of asking for the same, but spoke too
> soon!

Yeah, it'd be interesting to see what difference this actually makes. 

Christian
