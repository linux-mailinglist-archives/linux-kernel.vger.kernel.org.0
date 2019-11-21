Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE01049A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 05:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKUEbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 23:31:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45636 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUEbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 23:31:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXe7r-00086k-TL; Thu, 21 Nov 2019 04:31:28 +0000
Date:   Thu, 21 Nov 2019 04:31:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     zhengbin <zhengbin13@huawei.com>, hughd@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] tmpfs: use ida to get inode number
Message-ID: <20191121043127.GA26530@ZenIV.linux.org.uk>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120154552.GS20752@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 07:45:52AM -0800, Matthew Wilcox wrote:
> On Wed, Nov 20, 2019 at 10:23:18PM +0800, zhengbin wrote:
> > I have tried to change last_ino type to unsigned long, while this was
> > rejected, see details on https://patchwork.kernel.org/patch/11023915.
> 
> Did you end up trying sbitmap?
> 
> What I think is fundamentally wrong with this patch is that you've found a
> problem in get_next_ino() and decided to use a different scheme for this
> one filesystem, leaving every other filesystem which uses get_next_ino()
> facing the same problem.
> 
> That could be acceptable if you explained why tmpfs is fundamentally
> different from all the other filesystems that use get_next_ino(), but
> you haven't (and I don't think there is such a difference.  eg pipes,
> autofs and ipc mqueue could all have the same problem.

If you think that anyone is willing to pay one hell of a price on each
pipe(2)...  Note that get_next_ino() is pretty careful about staying
within per-cpu stuff most of the time; it hits any cross-CPU traffic
only in 1/1024th of calls.  This, AFAICS, dirties shared cachelines
on each call.  And there's a plenty of pipe-heavy workloads, for obvious
reasons.
