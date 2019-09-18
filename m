Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA3B593D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfIRBXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 21:23:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51854 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRBXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:23:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAOgO-00039C-Vh; Wed, 18 Sep 2019 01:23:01 +0000
Date:   Wed, 18 Sep 2019 02:23:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: c25aa432ff:  aim9.dir_rtns_1.ops_per_sec -24.5% regression
Message-ID: <20190918012300.GI1131@ZenIV.linux.org.uk>
References: <20190918001736.GK15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918001736.GK15734@shao2-debian>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 08:17:36AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -24.5% regression of aim9.dir_rtns_1.ops_per_sec due to commit:
> 
> 
> commit: c25aa432ff56e179bf5414edff3aa430d2b260c0 ("Fix the locking in dcache_readdir() and friends")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master

... and that, folks, is ->d_lock on the parent.  I.e. the original reason for
trying to do the damn thing lockless.

I'd really like to do a lockless variant, properly.  First we'd need to sort
the misuses of d_subdirs/d_child, though - there are several outright bugs
in the mainline.  And right now it looks like it wants to grow a series of
cleanups in autofs.  Oh, well...
