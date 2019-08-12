Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6A8A4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 19:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfHLR4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 13:56:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33334 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:56:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so11317459qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YeHGfRcz7/xDdQu045YPZqSeRdWuIL5U3pex4BeV6Co=;
        b=aT1+Cp+KGWQyozFDowVXklkNZVi/kM9KamsNgl23DUo+IJyNPad8EzXuoAG7s3f5bf
         bOSW7DhNODTjMskeg1DRPDb4g7NB2wX2AWkHQuyR0cct0HrdnZzak9aU8g7CHTL0qHoO
         IKZcX3vXDSq/u24mEPYpzVVHpbOB2TSRpMchVGlB+vxEwN6TXEtwOQ8uYyw5P8+cz9Hd
         j1BzALymBU6a7rw2q7wWcxOSnVbjWppZ0IMW4+9rMtyvhB+q0F08Mu3PWUPEGDQxvNfD
         RqDlAaDfsxyO370w/XugHLZnyfoDs8iN8igYYDuAHaeRZtKy3Zg+yOMKiyalzWN131uL
         Eqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YeHGfRcz7/xDdQu045YPZqSeRdWuIL5U3pex4BeV6Co=;
        b=Cf3gLK7y1JG0Kxt3HKy/O67rXdKbQR3l3rQOe7ROCoYJHDVGC5S+vIVyKRX8TaNaVL
         OU6iNB+WlQh/luGokEUqJFxZATyPNes49ALHEtdqlDmrXVNEoZnHMsOKS0M7T1LF280/
         kqbF5ZJxIBNf0WLc+QXAZzyZUZrlaL597sAx7S3RIwDuhwScQ3y9wafnMo+yLZh/9HnP
         WmbJ1C0544zcRjgy7Qmi7iGJJf/k8RnzTFtzonthmz9TaJ3Fk3WCxybxrzNvUWYH57O1
         Xgt7dHUoQRzaT4SLBv3DDyYG4cQao+zmF4BuuiuUZCJsTTryTZX1QnvHg4UR20eg6LfA
         X8AQ==
X-Gm-Message-State: APjAAAUkAL0URj/tghSXLRw/QrzlzRr6A98+t3kIJQVeNazwLg5q/zJL
        fch80LVwsMEFWxKUVtJVj/e1/w==
X-Google-Smtp-Source: APXvYqx5MBD9MG64lV9iZUYWN/EeNo5U4lzvE+q4eQc5jVQAxZ4QmzhDKvfOk+m1tNY0/uiYKcLUcw==
X-Received: by 2002:ac8:43c4:: with SMTP id w4mr15414493qtn.238.1565632576300;
        Mon, 12 Aug 2019 10:56:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r15sm5883158qtp.94.2019.08.12.10.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 10:56:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxEYJ-0004LN-Ev; Mon, 12 Aug 2019 14:56:15 -0300
Date:   Mon, 12 Aug 2019 14:56:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 16/19] RDMA/uverbs: Add back pointer to system
 file object
Message-ID: <20190812175615.GI24457@ziepe.ca>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-17-ira.weiny@intel.com>
 <20190812130039.GD24457@ziepe.ca>
 <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:28:27AM -0700, Ira Weiny wrote:
> On Mon, Aug 12, 2019 at 10:00:40AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 09, 2019 at 03:58:30PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > In order for MRs to be tracked against the open verbs context the ufile
> > > needs to have a pointer to hand to the GUP code.
> > > 
> > > No references need to be taken as this should be valid for the lifetime
> > > of the context.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >  drivers/infiniband/core/uverbs.h      | 1 +
> > >  drivers/infiniband/core/uverbs_main.c | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> > > index 1e5aeb39f774..e802ba8c67d6 100644
> > > +++ b/drivers/infiniband/core/uverbs.h
> > > @@ -163,6 +163,7 @@ struct ib_uverbs_file {
> > >  	struct page *disassociate_page;
> > >  
> > >  	struct xarray		idr;
> > > +	struct file             *sys_file; /* backpointer to system file object */
> > >  };
> > 
> > The 'struct file' has a lifetime strictly shorter than the
> > ib_uverbs_file, which is kref'd on its own lifetime. Having a back
> > pointer like this is confouding as it will be invalid for some of the
> > lifetime of the struct.
> 
> Ah...  ok.  I really thought it was the other way around.
> 
> __fput() should not call ib_uverbs_close() until the last reference on struct
> file is released...  What holds references to struct ib_uverbs_file past that?

Child fds hold onto the internal ib_uverbs_file until they are closed

> Perhaps I need to add this (untested)?
> 
> diff --git a/drivers/infiniband/core/uverbs_main.c
> b/drivers/infiniband/core/uverbs_main.c
> index f628f9e4c09f..654e774d9cf2 100644
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -1125,6 +1125,8 @@ static int ib_uverbs_close(struct inode *inode, struct file *filp)
>         list_del_init(&file->list);
>         mutex_unlock(&file->device->lists_mutex);
>  
> +       file->sys_file = NULL;

Now this has unlocked updates to that data.. you'd need some lock and
get not zero pattern

Jason
