Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05071413CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 22:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgAQV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 16:59:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33834 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAQV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:59:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id c9so5097965plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=56aH2f2I6unxBhsORyRTc0s6WhmndqDwz/RgmZbYgAA=;
        b=LwYY4I12Sm9BWHk3vv2Z14wWQzIKywGelJkc7iNg/vnd5QatMajbAsw1CQIorcPqYB
         1KFb6ZB/rFQjZ1Cu6YpbrkEWIVIrgZj6BsrhidYpdnc3bIiqCltXR3ydkWaO/jjtDAJ0
         DPFUIk3BKmYDLHOmM3KEZmO4fYPkaJVXP6HTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=56aH2f2I6unxBhsORyRTc0s6WhmndqDwz/RgmZbYgAA=;
        b=PRTGXjef3Fzkpp5sPw1sJbGmNZNStOobKzxAAjEOVTvZK5VCdi0BzohJwvNiA8u8Yq
         QhP1vWzIXzmyXgqUHOeeWcue12PcGYVapIiR6vzAcN/9T+Lnpwoe0IoEQHoBYqLz48BK
         B0PrtHbzSXFw0ejv7HdC/DqyanngjMlDFQpsG2ESzv7h3g1+pOkuxmokdYZ+pjEpC0V7
         j5EMiqgfjcP42aPM16IdmdHRK7JWLK9WfuOt9TVlsj+Cja90DfLfsg4hhWISWla1idfm
         KEFD1fvH7aqqRtHyQNxFimstHLlfrTyvzqWYSpf7P7qzdxV/hjbCd8qoZxL/zJzaMmjK
         X5kw==
X-Gm-Message-State: APjAAAVEvj6Y5382STchU443hNXJIFSUTv46tHB9bonIftn+puHsI2Vw
        /cyee2dycMM0SiLF2J6RZKoDGg==
X-Google-Smtp-Source: APXvYqyhobpoBDY9+cq/GGePm6cjJoaX2BRvuTP4Gds5sQhVwiHPqq9vFFK+QyyReL+nnFMC1xSUKg==
X-Received: by 2002:a17:902:7c88:: with SMTP id y8mr1412589pll.321.1579298351632;
        Fri, 17 Jan 2020 13:59:11 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q22sm31131110pfg.170.2020.01.17.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:59:11 -0800 (PST)
Date:   Fri, 17 Jan 2020 16:59:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200117215910.GC206250@google.com>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200113190315.GA12543@paulmck-ThinkPad-P72>
 <20200114164937.GA50403@google.com>
 <20200115131446.GA18417@pc636>
 <20200115225350.GA246464@google.com>
 <20200117175217.GA23622@pc636>
 <20200117185732.GH246464@google.com>
 <20200117213721.GN2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117213721.GN2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 01:37:21PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 17, 2020 at 01:57:32PM -0500, Joel Fernandes wrote:
> > On Fri, Jan 17, 2020 at 06:52:17PM +0100, Uladzislau Rezki wrote:
> > > > > > > But rcuperf uses a single block size, which turns into kfree_bulk() using
> > > > > > > a single slab, which results in good locality of reference.  So I have to
> > > > > > 
> > > > > > You meant a "single cache" category when you say "single slab"? Just to
> > > > > > mention, the number of slabs (in a single cache) when a large number of
> > > > > > objects are allocated is more than 1 (not single). With current rcuperf, I
> > > > > > see 100s of slabs (each slab being one page) in the kmalloc-32 cache. Each
> > > > > > slab contains around 128 objects of type kfree_rcu (24 byte object aligned to
> > > > > > 32-byte slab object).
> > > > > > 
> > > > > I think that is about using different slab caches to break locality. It
> > > > > makes sense, IMHO, because usually the system make use of different slabs,
> > > > > because of different object sizes. From the other hand i guess there are
> > > > > test cases when only one slab gets used.
> > > > 
> > > > I was wondering about "locality". A cache can be split into many slabs. Only
> > > > the data on a page is local (contiguous). If there are a large number of
> > > > objects, then it goes to a new slab (on the same cache). At least on the
> > > > kmalloc slabs, there is only 1 slab per page. So for example, if on
> > > > kmalloc-32 slab, there are more than 128 objects, then it goes to a different
> > > > slab / page. So how is there still locality?
> > > > 
> > > Hmm.. On a high level:
> > > 
> > > one slab cache manages a specific object size, i.e. the slab memory consists of
> > > contiguous pages(when increased probably not) of memory(4096 bytes or so) divided
> > > into equal object size. For example when kmalloc() gets called, the appropriate
> > > cache size(slab that serves only specific size) is selected and an object assigned
> > > from it is returned.
> > > 
> > > But that is theory and i have not deeply analyzed how the SLAB works internally,
> > > so i can be wrong :)
> > > 
> > > You mentioned 128 objects per one slab in the kmalloc-32 slab-cache. But all of
> > > them follows each other, i mean it is sequential and is like regular array. In
> > 
> > Yes, for these 128 objects it is sequential. But the next 128 could be on
> > some other page is what I was saying  And we are allocating 10s of 1000s of
> > objects in this test.  (I believe pages are sequential only per slab and not
> > for a different slab within same cache).
> > 
> > > that sense freeing can be beneficial because when an access is done to any object
> > > whole CPU cache-line is fetched(if it was not before), usually it is 64K.
> > 
> > You mean size of the whole L1 cache right? cachelines are in the order of bytes.
> > 
> > > That is what i meant "locality". In order to "break it" i meant to allocate from
> > > different slabs to see how kfree_slub() behaves in that sense, what is more real
> > > scenario and workload, i think.
> > 
> > Ok, agreed.
> > (BTW I do agree your patch is beneficial, just wanted to get the slab
> > discussion right).
> 
> Thank you both!
> 
> Then I should be looking for an updated version of the patch with an upgraded
> commit log?  Or is there more investigation/testing/review in process?
> 

From my side the review is complete. I believe he will repost with
debugobjects fix and we should be good.
