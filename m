Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E96E53C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 20:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfJYSWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 14:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJYSWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:22:31 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B9D12084C;
        Fri, 25 Oct 2019 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572027750;
        bh=jW3jhqREmHORgTivuUZILx5c8BXB7MCqCsxfyYoTJfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9gRv3PnUM3r7KhTPTtMv8ROhUaBDWEUF7FCnlh+0l4w4+zoMpQ3b6vLpBbO9WHo/
         CXt/pfcTMNW0UR452lG1uxx8a3/KzORuZvF8+PtK6BmIt+wgQGp7SnPQiqefqgmiwy
         afeUzhutXpqXCjIlBQj/AVcdDher7NzO+4kWtkj8=
Date:   Fri, 25 Oct 2019 11:22:29 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Hridya Valsaraju <hridya@google.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
Message-ID: <20191025182229.GB24183@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191023214821.107615-1-hridya@google.com>
 <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
 <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
 <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Chao Yu wrote:
> On 2019/10/25 11:51, Hridya Valsaraju wrote:
> > On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
> >>
> >> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> >>> Currently f2fs stats are only available from /d/f2fs/status. This patch
> >>> adds some of the f2fs stats to sysfs so that they are accessible even
> >>> when debugfs is not mounted.
> >>
> >> Why don't we mount debugfs first?
> > 
> > Thank you for taking a look at the patch Chao. We will not be mounting
> > debugfs for security reasons.
> 
> Hi, Hridya,
> 
> May I ask is there any use case for those new entries?
> 
> So many sysfs entries exist, if there is real use case, how about backuping
> entire /d/f2fs/status entry into /proc/fs/f2fs/<dev>/ directory rather than
> adding some of stats as a single entry in sysfs directory?

These will be useful to keep a track on f2fs health status by one value
per entry, which doesn't require user-land parsing stuff. Of course, Android
can exploit them by IdleMaint, rollback feature, and so on.

> 
> Thanks,
> 
> > 
> > Regards,
> > Hridya
> > 
> >>
> >> Thanks,
> > .
> > 
