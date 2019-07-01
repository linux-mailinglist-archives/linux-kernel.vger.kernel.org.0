Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F624921
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfEUHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 03:38:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36522 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfEUHi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:38:57 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1hSzMM-0004o6-4h
        for linux-kernel@vger.kernel.org; Tue, 21 May 2019 07:38:54 +0000
Received: by mail-wm1-f70.google.com with SMTP id y139so704526wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PD3gnvomtD5VhdkV7Q4c3V/xyYHglmxFg3mfhMbpkIs=;
        b=eVv4cbLtONMsZsDgEzmWYHOVt2BJvnef6ISD7Sj6REhkwwnBEOP7ilEkCGNTsaVAO1
         Yilhg9K11piDWuhpvmc9nmvQXBv8iA1SJ4MmohNWNNz7otjV30d80rJNJW5ZCPJVUinZ
         YqVc+ET6neDHSyO/PVL2RjKt7TVIhrSw1WJR3fKrbBsvEtsf0en/a3Ea6ur3u/UcfPbC
         EZHkMqSi+q9J+Js0KylavuLVtTO8BW0YVfycP4ZVZIME56q0cHDG28eghxYU8oIKwCYz
         JwFKYgGYQu1YWaI8gVesgYUUG9G0kOMGjVCRQK1yDElsXvnaGYA6SJfN1zbu3iPbrloz
         tsmg==
X-Gm-Message-State: APjAAAUqxrEei0vaMJOjF6AR9qk7F/38O5FFVb3B1bQtoPmoDomiouHe
        6NhZpUP+S/9xqJz+aN90X0L7U86hJMIwp7aHXs6bR6SzansCImBZ5k8CcCvozbzSCT/gBlORh1N
        i78Aa9E0Pw3u6QqcG4AsQCLKZg9qJ789Pk7rYRBSAZQ==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr2189825wmj.139.1558424333858;
        Tue, 21 May 2019 00:38:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmsb8RKYyDOM0lxwOMDTTxlykFnx0YegvtoEzcpA1XoYR24SX3p81b1TVlQrtMAdKIJPWHpA==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr2189806wmj.139.1558424333602;
        Tue, 21 May 2019 00:38:53 -0700 (PDT)
Received: from localhost (host157-126-dynamic.32-79-r.retail.telecomitalia.it. [79.32.126.157])
        by smtp.gmail.com with ESMTPSA id 34sm35567853wre.32.2019.05.21.00.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 00:38:52 -0700 (PDT)
Date:   Tue, 21 May 2019 09:38:51 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, amakhalov@vmware.com, anishs@vmware.com,
        srivatsab@vmware.com, Josef Bacik <josef@toxicpanda.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190521073851.GA15262@xps-13>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <20190518192847.GB14277@mit.edu>
 <98612748-8454-43E8-9915-BAEBA19A6FD7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98612748-8454-43E8-9915-BAEBA19A6FD7@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 12:38:32PM +0200, Paolo Valente wrote:
...
> > I was considering adding support so that if userspace calls fsync(2)
> > or fdatasync(2), to attach the process's CSS to the transaction, and
> > then charge all of the journal metadata writes the process's CSS.  If
> > there are multiple fsync's batched into the transaction, the first
> > process which forced the early transaction commit would get charged
> > the entire journal write.  OTOH, journal writes are sequential I/O, so
> > the amount of disk time for writing the journal is going to be
> > relatively small, and especially, the fact that work from other
> > cgroups is going to be minimal, especially if hadn't issued an
> > fsync().
> > 
> 
> Yeah, that's a longstanding and difficult instance of the general
> too-short-blanket problem.  Jan has already highlighted one of the
> main issues in his reply.  I'll add a design issue (from my point of
> view): I'd find a little odd that explicit sync transactions have an
> owner to charge, while generic buffered writes have not.
> 
> I think Andrea Righi addressed related issues in his recent patch
> proposal [1], so I've CCed him too.
> 
> [1] https://lkml.org/lkml/2019/3/9/220

If journal metadata writes are submitted using a process's CSS, the
commit may be throttled and that can also throttle indirectly other
"high-priority" blkio cgroups, so I think that logic alone isn't enough.

We have discussed this priorty-inversion problem with Josef and Tejun
(adding both of them in cc), the idea that seemed most reasonable was to
temporarily boost the priority of blkio cgroups when there are multiple
sync(2) waiters in the system.

More exactly, when I/O is going to be throttled for a specific blkio
cgroup, if there's any other blkio cgroup waiting for writeback I/O,
no throttling is applied (this logic can be refined by saving a list of
blkio sync(2) waiters and taking the highest I/O rate among them).

In addition to that Tejun mentioned that he would like to see a better
sync(2) isolation done at the fs namespace level. This last part still
needs to be defined and addressed.

However, even the simple logic above "no throttling if there's any other
sync(2) waiter" can already prevent big system lockups (see for example
the simple test case that I suggested here https://lkml.org/lkml/2019/),
so I think having this change alone would be a nice improvement already:

 https://lkml.org/lkml/2019/3/9/220

Thanks,
-Andrea

> 
> > In the case where you have three cgroups all issuing fsync(2) and they
> > all landed in the same jbd2 transaction thanks to commit batching, in
> > the ideal world we would split up the disk time usage equally across
> > those three cgroups.  But it's probably not worth doing that...
> > 
> > That being said, we probably do need some BFQ support, since in the
> > case where we have multiple processes doing buffered writes w/o fsync,
> > we do charnge the data=ordered writeback to each block cgroup.  Worse,
> > the commit can't complete until the all of the data integrity
> > writebacks have completed.  And if there are N cgroups with dirty
> > inodes, and slice_idle set to 8ms, there is going to be 8*N ms worth
> > of idle time tacked onto the commit time.
> > 
> 
> Jan already wrote part of what I wanted to reply here, so I'll
> continue from his reply.
> 
> Thanks,
> Paolo
> 
> > If we charge the journal I/O to the cgroup, and there's only one
> > process doing the
> > 
> >   dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflags=dsync
> > 
> > then we don't need to worry about this failure mode, since both the
> > journal I/O and the data writeback will be hitting the same cgroup.
> > But that's arguably an artificial use case, and much more commonly
> > there will be multiple cgroups all trying to at least some file system
> > I/O.
> > 
> > 						- Ted
> 


