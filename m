Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4014D1B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfFTPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:09:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37003 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfFTPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:09:15 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so393677iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewdhs5LHMjOeAYyn48UrmEBDkixoi9wUic5LA0EV24E=;
        b=JdvJwEXrYAnx5AAC+XXXCNKVU113R27SbHcmaFh10XoeJ19jse9UlgQHUgP9Dbs/Ly
         L5gsnLoUu69tMP0wH9tzzv14tw9rZx8tP97CUVrh25VbPy/chgSW/u87CuNuhB99D0ob
         Jzxea/k/UXe+JdQrG5HCVGXJ7MwB+foaI17QqOx5S+HDW8qAMFIwEImkYuYp4+F+/pbb
         ps+qGPCzBctzDiyTzmyWhPDKhpeBzqb9KiXlkgIFz/GzkJZl5P6q2rcOg5mf0hdnnvbK
         xq4nHwF21difWFt9jzn8/KwkphqxT7Rj2JbfX2TwfWZhWPUsPMs6hx/0kOrsaq+6o/GK
         O02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewdhs5LHMjOeAYyn48UrmEBDkixoi9wUic5LA0EV24E=;
        b=R7Rm1GVj12P9rtyuBuEpdH17jsGzSnjLQDIYloUhuPm3SzZbDh6tRDSdtuiCCdWCS8
         YCqo0SI5KEPaEuW9tMoY7DYB3S+4eeTjHzUYtbS/XVIUHuSW37xDN4MSOeas49Ho9eZ9
         Ea4igFUYBB1iZnZlW5lwdFCKqZe/JTtHX7bvtkT+nNtASWLBIz8am3RBwhh7dvazTnBk
         WLjZjPcd8fspP4pmuJvxdklYEGSND5zK0ESAJK65WZx30Kw+DvujYoIKkIP/ojBDTeMN
         CTitogBB+n38e65/6GYWsM7q3FhIekM01WjhTsulvY2XcqT6ybZqSCb5HiNTCpmmBRbA
         wIBw==
X-Gm-Message-State: APjAAAWmvf/wUAbWf95g6g7VHmOBpLgajN5mwnIZouKgPiRlcrmDlx9c
        udq2MjsPccULXfHyT2G2OqlJIw==
X-Google-Smtp-Source: APXvYqx5OhNQGc/cowc4jUU7ZK9aKOWQfczrnZebKrjxu3Ng1Qb+wjCWeQXoL4sJ7gt1IrioslXb3g==
X-Received: by 2002:a6b:3883:: with SMTP id f125mr89642441ioa.109.1561043354165;
        Thu, 20 Jun 2019 08:09:14 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id w23sm52147ioa.51.2019.06.20.08.09.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:09:13 -0700 (PDT)
Date:   Thu, 20 Jun 2019 09:09:11 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: Re: [PATCH 2/3] jbd2: introduce jbd2_inode dirty range scoping
Message-ID: <20190620150911.GA4488@google.com>
References: <20190619172156.105508-1-zwisler@google.com>
 <20190619172156.105508-3-zwisler@google.com>
 <20190620110454.GL13630@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620110454.GL13630@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 01:04:54PM +0200, Jan Kara wrote:
> On Wed 19-06-19 11:21:55, Ross Zwisler wrote:
> > Currently both journal_submit_inode_data_buffers() and
> > journal_finish_inode_data_buffers() operate on the entire address space
> > of each of the inodes associated with a given journal entry.  The
> > consequence of this is that if we have an inode where we are constantly
> > appending dirty pages we can end up waiting for an indefinite amount of
> > time in journal_finish_inode_data_buffers() while we wait for all the
> > pages under writeback to be written out.
> > 
> > The easiest way to cause this type of workload is do just dd from
> > /dev/zero to a file until it fills the entire filesystem.  This can
> > cause journal_finish_inode_data_buffers() to wait for the duration of
> > the entire dd operation.
> > 
> > We can improve this situation by scoping each of the inode dirty ranges
> > associated with a given transaction.  We do this via the jbd2_inode
> > structure so that the scoping is contained within jbd2 and so that it
> > follows the lifetime and locking rules for that structure.
> > 
> > This allows us to limit the writeback & wait in
> > journal_submit_inode_data_buffers() and
> > journal_finish_inode_data_buffers() respectively to the dirty range for
> > a given struct jdb2_inode, keeping us from waiting forever if the inode
> > in question is still being appended to.
> > 
> > Signed-off-by: Ross Zwisler <zwisler@google.com>
> 
> The patch looks good to me. I was thinking whether we should not have
> separate ranges for current and the next transaction but I guess it is not
> worth it at least for now. So just one nit below. With that applied feel free
> to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

We could definitely keep separate dirty ranges for each of the current and
next transaction.  I think the case where you would see a difference would be
if you had multiple transactions in a row which grew the dirty range for a
given jbd2_inode, and then had a random I/O workload which kept dirtying pages
inside that enlarged dirty range.

I'm not sure how often this type of workload would be a problem.  For the
workloads I've been testing which purely append to the inode, having a single
dirty range per jbd2_inode is sufficient.

I guess for now this single range seems simpler, but if later we find that
someone would benefit from separate tracking for each of the current and next
transactions, I'll take a shot at adding it.

Thank you for the review!

> > @@ -257,15 +262,24 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
> >  	/* For locking, see the comment in journal_submit_data_buffers() */
> >  	spin_lock(&journal->j_list_lock);
> >  	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
> > +		loff_t dirty_start = jinode->i_dirty_start;
> > +		loff_t dirty_end = jinode->i_dirty_end;
> > +
> >  		if (!(jinode->i_flags & JI_WAIT_DATA))
> >  			continue;
> >  		jinode->i_flags |= JI_COMMIT_RUNNING;
> >  		spin_unlock(&journal->j_list_lock);
> > -		err = filemap_fdatawait_keep_errors(
> > -				jinode->i_vfs_inode->i_mapping);
> > +		err = filemap_fdatawait_range_keep_errors(
> > +				jinode->i_vfs_inode->i_mapping, dirty_start,
> > +				dirty_end);
> >  		if (!ret)
> >  			ret = err;
> >  		spin_lock(&journal->j_list_lock);
> > +
> > +		if (!jinode->i_next_transaction) {
> > +			jinode->i_dirty_start = 0;
> > +			jinode->i_dirty_end = 0;
> > +		}
> 
> This would be more logical in the next loop that moves jinode into the next
> transaction.

Yep, agreed, this is much better.  Fixed in v2.
