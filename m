Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2433116504E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 21:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBSUyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 15:54:08 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42222 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:54:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id r5so1271844qtt.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLaIAW0Lkknrx7pEhMD4u2gukgtf4c3eSrw1zC53+uM=;
        b=dl7RHlWFHf6J5KKRNoP969BUk8w4nDMrtJ+aGdOUjYW3QHprh5gsqZq7QncqrqqZr4
         m6xHh6c564ahAVkep43+wkQ3fgYwkM9YhVtI8bKgRnMO1oY2+WxxHXD35c5yDG6luu2v
         3Zi+nX/FchZBVp9K50ol1q6HNC4IfwkJpH65jzk0BpYn1MsHmi6BdJgi/uy2mAIzULY6
         OUGff6e7hKDgBwdhTQ7bXcqMRGD1OQMXD/Q8q+Vkh7enZFpvJDKOqY1s83i19hYagwG0
         e8KK/pGgsBEvYSI2qH5gPpfdZtwlxuj7vERqBmO1RIadQsgaTdReUsE/4pUFSJY99yuM
         XAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLaIAW0Lkknrx7pEhMD4u2gukgtf4c3eSrw1zC53+uM=;
        b=U1OPMSt/oo4zE/5ZRfRy9oxkjWw1PNr15/fkA0O3JnyWpeMuZ/0Y87rNotEBiyCIko
         T8iBZGlYMjODt0dHqEvmxGFm59V9ssOtEIo5e7sADYxEhqewVRD5PUjDM/yWMNENYQJn
         gTdJz4Qxp9AJ9YaIpXV5p1ZBqU1PVqj6Nk/6UXyUtNN5IZr7S3rYQaY3WiDcDkMN04oj
         ocz2EbwXVY/ujBaleX4jMFxvnr3GaLqbtxSewaP7FHImb4Bi6YvDBJ5zgd3lbGCezOmL
         xSQrPSsGFiy5vSKe/rIHmAq6FEEI+/iYRQwF73qTUhrvNNyQt00x56YCl7lLJO55FqPq
         UDAQ==
X-Gm-Message-State: APjAAAXuClHpnXo9zhwi98DZfBfOVJ1fBD6plhUItLD9syMqtv2o8x7r
        3o+4aaxyuyr0jVEj5+gW1ZKKiQ==
X-Google-Smtp-Source: APXvYqyvdHHF5nHRsZfIaz28uyycqjYc6epPoIy4SsohMfvnnCgJwRmR5vxio4lrHBjarf5BLVSe3A==
X-Received: by 2002:ac8:5513:: with SMTP id j19mr23959953qtq.143.1582145646469;
        Wed, 19 Feb 2020 12:54:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 123sm458739qkj.113.2020.02.19.12.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:54:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WM9-0003ir-JE; Wed, 19 Feb 2020 16:54:05 -0400
Date:   Wed, 19 Feb 2020 16:54:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/core: Fix use of logical OR in get_new_pps
Message-ID: <20200219205405.GX31668@ziepe.ca>
References: <20200217204318.13609-1-natechancellor@gmail.com>
 <20200219204625.GA12915@ziepe.ca>
 <20200219205010.GA44941@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219205010.GA44941@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:50:10PM -0700, Nathan Chancellor wrote:
> On Wed, Feb 19, 2020 at 04:46:25PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 17, 2020 at 01:43:18PM -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > > 
> > > ../drivers/infiniband/core/security.c:351:41: warning: converting the
> > > enum constant to a boolean [-Wint-in-bool-context]
> > >         if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
> > >                                                ^
> > > 1 warning generated.
> > > 
> > > A bitwise OR should have been used instead.
> > > 
> > > Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/889
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/security.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Applied to for-next, thanks
> > 
> > Jason
> 
> Shouldn't this go into for-rc since the commit that introduced this was
> merged in 5.6-rc2? I guess I should have added that after the PATCH in
> the subject line, I always forget.

Oops, that was a typo, it did go to -rc

[each artisanal 'applied' message is uniquely hand crafted]

Jason
