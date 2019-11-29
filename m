Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFB10DB73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfK2WXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 17:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfK2WXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 17:23:13 -0500
Received: from localhost (unknown [46.255.181.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59839215A5;
        Fri, 29 Nov 2019 22:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575066192;
        bh=7mbRYQsJeMjFDQbCIaAbsq5emHazxX9lByjjgJS7tYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NNhEl6Fk43eIvrBKcaQXpxvPFklaE1voy/KqfcCIQc5i7zzU7hCTWH9Mz5CzbcWT
         SWI9itUSQp3OA3Lmsf18ftcJKUNfNWNFdOSkNTcuCAwWGZwEzxTZv0iultD5XnIIyh
         1pvCkfy6+Y5jT71sUrS3PyT5xBRdc8OF6T2zjBmI=
Date:   Fri, 29 Nov 2019 23:23:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 0/3] debugfs: introduce
 debugfs_create_single/seq[,_data]
Message-ID: <20191129222310.GA3712618@kroah.com>
References: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
 <20191129142110.GA3708031@kroah.com>
 <cc0e5624-273f-a990-87ee-4a9c3d8db4da@huawei.com>
 <20191129221938.GB3710566@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129221938.GB3710566@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 11:19:38PM +0100, Greg KH wrote:
> On Fri, Nov 29, 2019 at 11:16:38PM +0800, Kefeng Wang wrote:
> > 
> > 
> > On 2019/11/29 22:21, Greg KH wrote:
> > > On Fri, Nov 29, 2019 at 05:27:49PM +0800, Kefeng Wang wrote:
> > >> Like proc_create_single/seq[,_data] in procfs, we could provide similar debugfs
> > >> helper to reduce losts of boilerplate code.
> > >>
> > >> debugfs_create_single[,_data]
> > >>   creates a file in debugfs with the extra data and a seq_file show callback.
> > >> debugfs_create_seq[,_data]
> > >>   creates a file in debugfs with the extra data and a seq_operations.
> > >>
> > >> There is a object dynamically allocated in the helper, which is used to store
> > >> extra data, we need free it when remove the debugfs file.
> > >>
> > >> If the change is acceptable, we could change the caller one by one.
> > > 
> > > I would like to see a user of this and how you would convert it, in
> > > order to see if this is worth it or not.
> > 
> > I have some diff patches, the conversion is in progress. current statistics
> > are as follows,
> > 
> > 1) debugfs: switch to debugfs_create_seq[,_data]
> > 19 files changed, 85 insertions(+), 620 deletions(-)
> > 2) debugfs: switch to debugfs_create_single[,_data]
> > 70 files changed, 249 insertions(+), 1482 deletions(-)
> > 
> > Here are some examples,
> > 1) debugfs_create_seq
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 78d53378db99..62c26772f24c 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -2057,18 +2057,6 @@ static const struct seq_operations unusable_op = {
> >  	.show	= unusable_show,
> >  };
> > 
> > -static int unusable_open(struct inode *inode, struct file *file)
> > -{
> > -	return seq_open(file, &unusable_op);
> > -}
> > -
> > -static const struct file_operations unusable_file_ops = {
> > -	.open		= unusable_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= seq_release,
> > -};
> > -
> 
> Can't this file just use the normal file macro/interface for debugfs
> files instead?  Hm, maybe not, it seems the celf code wants to do much
> the same as above, but is seq_read() really needed for these?

I refer to DEFINE_SIMPLE_ATTRIBUTE(), sorry for not saying that here.

And if they do not work, how about creating:
	DEFINE_SEQ_ATTRIBUTE()
in much the same way for the whole kernel to use.

thanks,

greg k-h
