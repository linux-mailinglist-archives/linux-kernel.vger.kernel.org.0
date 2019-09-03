Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E018A71A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfICR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:27:27 -0400
Received: from mail.alarsen.net ([144.76.18.233]:56120 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbfICR11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:27:27 -0400
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:4c62:a11:a1a:c92c])
        by joe.alarsen.net (Postfix) with ESMTPS id DF8FC2B80D96;
        Tue,  3 Sep 2019 19:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1567531644; bh=NUJqd5fW3jGPSjQIN+tCQrdb0lPcXg5plbk8kV1a8jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9qYdaUr+eCwCArE/7xlDbkAAll2iGrwJfxw9/Sa56FVlWlEHEllCh4HsbJVa8pLk
         d5KMAbgyIgdgjjArQKFBgxqJjikAs2dsCz515boughNo+Boi5mRZr7cmsI2o9FUyXw
         uR06MxZe96kSiJWvXLynrubiU8eu61460MujfJbs=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 3811B27C0D59;
        Tue,  3 Sep 2019 19:27:22 +0200 (CEST)
From:   Anders Larsen <al@alarsen.net>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/qnx: Delete unnecessary checks before brelse()
Date:   Tue, 03 Sep 2019 19:27:22 +0200
Message-ID: <21774224.cEpxz9ejUk@alarsen.net>
In-Reply-To: <056c8b8e-abaa-8856-4953-118d14048ddc@web.de>
References: <056c8b8e-abaa-8856-4953-118d14048ddc@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2019-09-03 19:20 Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 19:15:09 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the tests around the shown calls are not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/qnx4/inode.c | 3 +--
>  fs/qnx6/inode.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index e8da1cde87b9..018a4c657f7c 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -118,8 +118,7 @@ unsigned long qnx4_block_map( struct inode *inode, long iblock )
>  				bh = NULL;
>  			}
>  		}
> -		if ( bh )
> -			brelse( bh );
> +		brelse(bh);
>  	}
> 
>  	QNX4DEBUG((KERN_INFO "qnx4: mapping block %ld of inode %ld = %ld\n",iblock,inode->i_ino,block));
> diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> index 345db56c98fd..083170541add 100644
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c
> @@ -472,10 +472,8 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
>  out1:
>  	iput(sbi->inodes);
>  out:
> -	if (bh1)
> -		brelse(bh1);
> -	if (bh2)
> -		brelse(bh2);
> +	brelse(bh1);
> +	brelse(bh2);
>  outnobh:
>  	kfree(qs);
>  	s->s_fs_info = NULL;

Acked-by: Anders Larsen <al@alarsen.net>




