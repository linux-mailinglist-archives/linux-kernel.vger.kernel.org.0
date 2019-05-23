Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9248828C45
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfEWVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 17:19:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33593 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbfEWVTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:19:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id x132so5478194lfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDS3Ns71UvqAxo/Ziy/UlngEZ1rvpeIhNyX6PGvAAp8=;
        b=H4gjzqmptwunXRqYKn250eOT7ZJCydxukVmu4abj4LD8/gbMEVOPhuM7deCH1oNhln
         IhAnoulFRb3ISTB2HVOGL4lwyjS9ysrUvrNhplgIj/dCVrMGGG7bNKPjDw5bsLNtt6oh
         ZXbn+4T7bsuWw2xhN1jJiH7ToSUE6NWp3vTNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDS3Ns71UvqAxo/Ziy/UlngEZ1rvpeIhNyX6PGvAAp8=;
        b=TtW1SiXWjNTVHC7CTWQfWPJHgErgaAqUeC5mAocHqYDW1TKtlEFTCFIoXoBAziBIe/
         HLas8Lus/pVLlX4dkNttCVAQHe652uARobo1E6YgcjcG5SRSsXxDscZqd3RQpLftGc9K
         7kD8tHdJtF9Q7Afev+kHvOlwGy8pq6i+rGe5SO0N+0oIKxatVCE+I5GAyu808GkU5OTW
         lvVGmP8q7di245M6qxjzvBc/PqdkQ/vJBQi9Kh9roabTCToKJt7VhPhz/DLYyyLHHyvk
         X2ojS9xaVeZGiv1PTP9ZzKPqhD/HHvH7EVtWKmz5kUVDDpEcZcH/w+FKmwztA6i9sIaq
         7RGQ==
X-Gm-Message-State: APjAAAWP7EdJIe+eMSRa+P9ldPvZu7yoTtqEv0SG3wZgOkcIpDConhJQ
        BO15n9gNZb2jBxqFJwe6Cg4JSwgQt30=
X-Google-Smtp-Source: APXvYqzoG/cE5bveDa5YVZJ4sD/+t6g/CAfEcoiewPap/VlXPAifEdHSTLaa3NPiDzmRWh32mg/OCw==
X-Received: by 2002:a19:740e:: with SMTP id v14mr42946009lfe.144.1558646382999;
        Thu, 23 May 2019 14:19:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k16sm135116lje.30.2019.05.23.14.19.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:19:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h11so6839792ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:19:41 -0700 (PDT)
X-Received: by 2002:a2e:9f41:: with SMTP id v1mr12462152ljk.66.1558646380884;
 Thu, 23 May 2019 14:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190523100013.52a8d2a6@gandalf.local.home> <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
 <20190523112740.7167aba4@gandalf.local.home> <CAHk-=whFJqTOk0mSxJGeh38ZxDksgRaMrNV8hqTngiuokyJzew@mail.gmail.com>
 <20190523133648.591f9e78@gandalf.local.home>
In-Reply-To: <20190523133648.591f9e78@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 14:19:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whATjcpjVmTtM-MJw=XWY9kxq2xc67wA4_UkmVgF1mf2Q@mail.gmail.com>
Message-ID: <CAHk-=whATjcpjVmTtM-MJw=XWY9kxq2xc67wA4_UkmVgF1mf2Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> >
> > Of course, you probably want the usual "at least use 'int'" semantics,
> > in which case the "type" should be "(x)+0":
> >
> >      #define round_up(x, y) size_fn((x)+0, round_up_size, x, y)
> >
> >  and the 8-bit and 16-bit cases will never be used.
>
> I'm curious to what the advantage of that is?

Let's say that you have a structure with a 'unsigned char' member,
because the value range is 0-255.

What happens if you do

   x = round_up(p->member, 4);

and the value is 255?

Now, if you stay in 'unsigned char' the end result is 0. If you follow
the usual C integer promotion rules ("all arithmetic promotes to at
least 'int'"), you get 256.

Most people probably expect 256, and that implies that even if you
pass an 'unsigned char' to an arithmetic function like this, you
expect any math to be done in 'int'. Doing the "(x)+0" forces that,
because the "+0" changes the type of the expression from "unsigned
char" to "int" due to C integer promotion.

Yes. The C integer type rules are subtle and sometimes surprising. One
of the things I've wanted is to have some way to limit silent
promotion (and silent truncation!), and cause warnings. 'sparse' does
some of that with some special-case types (ie __bitwise), but it's
pretty limited.

              Linus
