Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061A4129BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 00:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLWXEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 18:04:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41828 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLWXEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:04:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so19183995ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqcM5KAJpHOe8eLSgLngBPY9ypcT9P0u+Smp9zSx9A8=;
        b=0xXZYnb8QnwbXAHlOLPUGD1wCQM6TKxYnus3UgKSK3BlL96TRO5VwxXPG00q9BF1ED
         4eHaXQTCjWF7EEilm1T01Kxn/euMgK3DQd6PxYEArE3e2Eo2fjlqvCve5N86/SsxfinU
         ETq4Qn7d4cyRSX1IPYngwXTtp1FhJrKbGKCE4lvpqC/nqyEc+1BgufHmVy1Pstp72Sg4
         x6BKPedT0yPjHdkD60JvO5Hm6DJpt1Mi1cX+4YdcZ7SSgCaLhys68c6Dg+8aeODVkhej
         HJY8YM31466Wt0HQFF9RBi02MR1UBHIsKDicnLGbrhOHzxYoAcqdwL1qT+r4d+ya57Jj
         O4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqcM5KAJpHOe8eLSgLngBPY9ypcT9P0u+Smp9zSx9A8=;
        b=Fq3SFCqYvT8kyOmVvO6luawOYx0zThf+ajXjfBEaY0eNSKsRA7ZRxAsEvYZlHIddTI
         jlWW4IZpKdzQi662N1ZSL8VqiJDqV3jVVxD0Q6QhZlwMXhFpl4P4asv2aFNdJRju1tjj
         oDreqT6t5plDUAjpEVzkXVUGjfLXEA/7GJcOrml//GwPir0fgoE9xirZmPCAAOMYUjOH
         6EmI5aAzz/yfoy830t32ZVyaciQ8WGdABvSPhEdmnvvJ5jply4TBNjbWoNDbsfq1BIIp
         CInWYg/uUwang5tObmhztbaF1PKTeIE+5/QK8gkOFw8mjRUQ+P43MGYfqzI09YZS/lc+
         qpJg==
X-Gm-Message-State: APjAAAWmor2cMBkAdyJjGP6/sZoi8m26ubEqR3H12I61U6LV1LRqUkJT
        RYT5d6Dwa8KfDxT7L5DOgdkiJe63XlihwoENc5/vvXHivg==
X-Google-Smtp-Source: APXvYqwda+FhAcECcjhJDxyGrrZLaWhGpF6NXxaEM1hxiD4YQtrzA+OPxse+ZO6ck/mpXGfD95Ihjtj3nkRVb9AA1vE=
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr18948349ljj.243.1577142259137;
 Mon, 23 Dec 2019 15:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20191223091512.GL2760@shao2-debian> <CAHC9VhQfCmWbd7Yt0Jcz-QpSqXidri5PNgb_514+sfah5w3K6g@mail.gmail.com>
 <CAHC9VhQTphqNxZ7ndNRCy-iff3ugFjLan+CoWT8v6joF_smNzg@mail.gmail.com>
In-Reply-To: <CAHC9VhQTphqNxZ7ndNRCy-iff3ugFjLan+CoWT8v6joF_smNzg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Dec 2019 18:04:08 -0500
Message-ID: <CAHC9VhTK2oi6OcEUPZPRhvKA1RG2+-iyZFfMuKYDZ_cAo9063g@mail.gmail.com>
Subject: Re: [selinux] 66f8e2f03c: RIP:sidtab_hash_stats
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 4:37 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Dec 23, 2019 at 9:37 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Dec 23, 2019 at 4:15 AM kernel test robot <lkp@intel.com> wrote:
> > > FYI, we noticed the following commit (built with gcc-7):
> > >
> > > commit: 66f8e2f03c02e812002f8e9e465681cc62edda5b ("selinux: sidtab reverse lookup hash table")
> > > https://git.kernel.org/cgit/linux/kernel/git/pcmoore/selinux.git next
> > >
> > > ...
> >
> > Jeff, please look into this.  I suspect we may need to check
> > state->initialized in security_sidtab_hash_stats(...) (or similar).
>
> I realized that Jeff may very well be on a holiday so I took a closer
> look and this does appear to be the/a problem.  If you try to "cat
> /sys/fs/selinux/ss/sidtab_hash_stats" on a system where the policy
> hasn't been loaded it blows up in a bad way.  I'll write up a fix
> right now and post it as soon as I've verified it fixes the problem.

Fix posted (see archive link below) and merged into selinux/next.
Thanks for the problem report test robot!

https://lore.kernel.org/selinux/157714208320.505827.13006028554511851520.stgit@chester

-- 
paul moore
www.paul-moore.com
