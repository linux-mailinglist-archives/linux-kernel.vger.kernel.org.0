Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113F015B69F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 02:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgBMBYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 20:24:33 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35709 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgBMBYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:24:33 -0500
Received: by mail-ot1-f45.google.com with SMTP id r16so4016122otd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PILiMPIWP83o9BEbVPcc2wkT+EgjSJOcxDjVmVXRxQ4=;
        b=VbKK3eHv0jEZv+wG5KpbnI+nM5uIG95ROVb5rMd+HdMnBiiloxF3M2au9YKpNlMvH3
         HX7AJll9ycYr+HTlyWJcvPNGwpm+O+QBAONVVfsQNkontupQ94WNAdKrExlHzC2/Ri+v
         bqhIYD2mo9AbtO1Gi2XcQxcJNXn1iynTWrEa8nJttq3QPbX1JgMynf1VXNPRRc0ZoGrP
         6/H6eqa+ALrZ11hbuNORzH4xwlJxImKe/Pe/K9RI83dJGi9g/rRyaV12RbUdWmn9xO93
         yid562ZhiigWEUUE7BBedZWIJwWrNf+UgeMAsyz5m42OXRW66L4H0b0eVUHfioHsXR04
         B1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PILiMPIWP83o9BEbVPcc2wkT+EgjSJOcxDjVmVXRxQ4=;
        b=KctqkiLFMuv+JQEEMjxp3EQzfaXKVkZWwfvxy2ikpyrqwSceo48nR6dUCigkE8CbTh
         u2Gi/h6FQkp3Nt/HlVzHaC9sEw0Np5oWm4nHHzqg+7rsMN/DqAPCnVEV1SuF4KDAanWC
         nH6VtO7RXCrntPhKWZcXTs/WtpJ/qlksmMINrbg6jXdWDTCduGGXjg8SuoKPKwBzDE2K
         jt4niLBfnC3QLMsTRIf71Qgkfp4q8AphC/z363zcrlCvd2S0AFj6UmB1WDmPuxWd1tTi
         2GV+ahlzZc93ogtS/PgbWVNq23+5f0BQyKB/UvPECZ9ef5AVR2X/pCrNxoDVqCBSETJ+
         4ITA==
X-Gm-Message-State: APjAAAW1uKJw5zhucYZsYhEIP30qpwoRfqww4fqBWoNC4cbMXCZwSdQ/
        cGO6T+BxHRgAB1Ep/LFPW2z474UzknK2qEkOTnVqew==
X-Google-Smtp-Source: APXvYqyxb54hnCS3lFIqw5xbxKQtpV/D8VX7T2q4SiMXZ9DPJBX2YlSEIb4y3hV6TTULD7kKC0IdHQiVeth+Nvi6JpA=
X-Received: by 2002:a9d:7f83:: with SMTP id t3mr7941193otp.63.1581557072210;
 Wed, 12 Feb 2020 17:24:32 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200212230652.GA145444@mit.edu> <CAKUOC8UwjUyX1Ou-Gad29-DsyYHMtmLjwV9_0ghGUx=ys_drbA@mail.gmail.com>
In-Reply-To: <CAKUOC8UwjUyX1Ou-Gad29-DsyYHMtmLjwV9_0ghGUx=ys_drbA@mail.gmail.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Wed, 12 Feb 2020 17:24:19 -0800
Message-ID: <CAJmaN=kYvGWs=e_ee-DgRs2yW1UFgypKGxOTW2u1MSz1zkmHgQ@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Salman Qazi <sqazi@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 5:20 PM Salman Qazi <sqazi@google.com> wrote:
>
> On Wed, Feb 12, 2020 at 3:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > This is a problem we've been strugging with in other contexts.  For
> > example, if you have the hung task timer set to 2 minutes, and the
> > system to panic if the hung task timer exceeds that, and an NFS server
> > which the client is writing to crashes, and it takes longer for the
> > NFS server to come back, that might be a situation where we might want
> > to exempt the hung task warning from panic'ing the system.  On the
> > other hand, if the process is failing to schedule for other reasons,
> > maybe we would still want the hung task timeout to go off.
> >
> > So I've been meditating over whether the right answer is to just
> > globally configure the hung task timer to something like 5 or 10
> > minutes (which would require no kernel changes, yay?), or have some
> > way of telling the hung task timeout logic that it shouldn't apply, or
> > should have a different timeout, when we're waiting for I/O to
> > complete.
>
> The problem that I anticipate in our space is that a generous timeout
> will make impatient people reboot their chromebooks, losing us
> information
> about hangs.  But, this can be worked around by having multiple
> different timeouts.  For instance, a thread that is expecting to do
> something slow, can set a flag
> to indicate that it wishes to be held against the more generous
> criteria.  This is something I am tempted to do on older kernels where
> we might not feel
> comfortable backporting io_uring.

I was going to reply along the same lines when I got distracted by a
mtg.  If anything I'd like to see a LOWER hung task timeout, generally
speaking.  And maybe that means having more operations be asynchronous
like Ted suggests (I'm generally a fan of that anyway).

[snipped good suggestion about async interface]

Jesse
