Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504E5E82BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 08:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfJ2Htm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 03:49:42 -0400
Received: from verein.lst.de ([213.95.11.211]:38599 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2Htm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:49:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67C9D68AFE; Tue, 29 Oct 2019 08:49:39 +0100 (CET)
Date:   Tue, 29 Oct 2019 08:49:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, hch@lst.de, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191029074939.GA18999@lst.de>
References: <20191018010846.186484-1-pliard@google.com> <20191029041013.175636-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029041013.175636-1-pliard@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, the mail you quoted never made it to me..

On Tue, Oct 29, 2019 at 01:10:13PM +0900, Philippe Liard wrote:
> > My admittedly limited understanding is that using BIO indirectly
> > requires buffer_head or an alternative including some
> > synchronization mechanism at least.

What access do you need to synchronize?  If you read data into the
page cache the page lock provides all synchronization needed.  If
you just read into decrompression buffers there probably is no need
for synchronization at all as each buffer is only accessed by one
thread at a time.

> > It's true that the bio_{alloc,add_page,submit}() functions don't
> > require passing a buffer_head. However because bio_submit() is
> > asynchronous AFAICT the client needs to use a synchronization
> > mechanism to wait for and notify the completion of the request which
> > buffer heads provide. This is achieved respectively by
> > wait_on_buffer() and {set,clear}_buffer_uptodate().

submit_bio_wait() is synchronous and takes care of that for you.

> > Another dependency on buffer heads is the fact that
> > squashfs_read_data() calls into other squashfs functions operating
> > on buffer heads outside this file. For example squashfs_decompress()
> > operates on a buffer_head array.

All the decompressors do is accessing the, and then eventually doing
a bh_put.  So as a prep patch you can just pass them bio_vecs and
keep all the buffer head handling in data.c.  Initially that will be
a little less efficient as it requires two allocations, but as soon
as you kill off the buffer heads it actually becomes much better.

> > Given that bio_submit() is asynchronous I'm also not seeing how the
> > squashfs_bio_request allocation can be removed? There can be
> > multiple BIO requests in flight each needing to carry some context
> > used on completion of the request.
> 
> Christoph, do you still think this could be simplified as you
> suggested?

Yes.
