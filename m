Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCAC0B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfI0Sbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfI0Sbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:31:51 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E055C21655;
        Fri, 27 Sep 2019 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609111;
        bh=UNYxnX4ntOFxEKSdlmc5QQCfq4+Ba7pJxunUt3oMuws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZVr6zCc/phZF094x9qSudrSwmAlQIGe7hgbRWWLe8ydALl1rW/o5ooTk5kAgqY4y
         IL8fqL9nBl9bA7u5n3G5MBTgiSQMYybOB9HVHGnRTHE98uhZ3NLdVyA3c5J7tleQls
         fNGHpQEJBaCAUPR+GzyOlQltbGZ8S9p3jhnAM+n0=
Date:   Fri, 27 Sep 2019 11:31:50 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix comment of f2fs_evict_inode
Message-ID: <20190927183150.GA54001@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190925093050.118921-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925093050.118921-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 09/25, Chao Yu wrote:
> evict() should be called once i_count is zero, rather than i_nlinke
> is zero.
> 
> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index db4fec30c30d..8262f4a483d3 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  }
>  
>  /*
> - * Called at the last iput() if i_nlink is zero

I don't think this comment is wrong. You may be able to add on top of this.

> + * Called at the last iput() if i_count is zero
>   */
>  void f2fs_evict_inode(struct inode *inode)
>  {
> -- 
> 2.18.0.rc1
