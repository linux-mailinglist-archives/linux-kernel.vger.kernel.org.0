Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F89A3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394343AbfHVXXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391061AbfHVXXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:23:03 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629EA205ED;
        Thu, 22 Aug 2019 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566516182;
        bh=SSwCNTMur/081Fa89ShN1PC9iyHoJEAT2lJPl/mFI/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fN7pTYAWAY6uFIgSUWEb45q3M+mQkLeoWqX/mCfeuskBzOAv6Ybrj4x02GR2iv10W
         AA0Nzh7hRjMILRQgp1wsk8ONqdtZwWgZdUj9ToNXXYVBKbAuaT2nfAAth7w0gFdDpF
         dsORVNJq0PzaEJ5nODlx0Va6QvwJJY8lWPfYhB5c=
Date:   Thu, 22 Aug 2019 16:23:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Henry Burns <henryburns@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        HenryBurns <henrywolfeburns@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] mm/zsmalloc.c: Fix race condition in
 zs_destroy_pool
Message-Id: <20190822162302.6fdda379ada876e46a14a51e@linux-foundation.org>
In-Reply-To: <20190820025939.GD500@jagdpanzerIV>
References: <20190809181751.219326-1-henryburns@google.com>
        <20190809181751.219326-2-henryburns@google.com>
        <20190820025939.GD500@jagdpanzerIV>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 11:59:39 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (08/09/19 11:17), Henry Burns wrote:
> > In zs_destroy_pool() we call flush_work(&pool->free_work). However, we
> > have no guarantee that migration isn't happening in the background
> > at that time.
> > 
> > Since migration can't directly free pages, it relies on free_work
> > being scheduled to free the pages.  But there's nothing preventing an
> > in-progress migrate from queuing the work *after*
> > zs_unregister_migration() has called flush_work().  Which would mean
> > pages still pointing at the inode when we free it.
> > 
> > Since we know at destroy time all objects should be free, no new
> > migrations can come in (since zs_page_isolate() fails for fully-free
> > zspages).  This means it is sufficient to track a "# isolated zspages"
> > count by class, and have the destroy logic ensure all such pages have
> > drained before proceeding.  Keeping that state under the class
> > spinlock keeps the logic straightforward.
> > 
> > Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> > Signed-off-by: Henry Burns <henryburns@google.com>
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 

Thanks.  So we have a couple of races which result in memory leaks?  Do
we feel this is serious enough to justify a -stable backport of the
fixes?

