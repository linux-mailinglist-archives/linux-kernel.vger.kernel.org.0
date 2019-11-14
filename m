Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177F2FD176
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 00:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKNXTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 18:19:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33824 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKNXTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:19:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id 139so8585922ljf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICrO0QRstvenGdVeXDhZbaKDYu3NwTrJocm24+ZpLeM=;
        b=ev1bBGx7lLlrnl26b7rac/GdwfVDNkM6VDvIUf7VBtsxoiUazG/I7hXMGRVkH4s9Zr
         5n1Q/xO5/Ub03hzKELw/qorFGTCAcInMY/IBmyOxe45PHOoaJixrg1e5WMT5xWskDhnR
         F0c0xW4ygk84ZQZhlsONe5gHFlDxIFEJ6FKYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICrO0QRstvenGdVeXDhZbaKDYu3NwTrJocm24+ZpLeM=;
        b=ulA3IJ2erZytJZHWkpygoESw325M5VTbpg9LSPr25qL8zhmkllW7eiQRltUXZMObaI
         Ba+5L+4sGj5fNoaYDVecgLFZ6FGIdhed0Sea8kslJg6NbxjWzp0+W9iEV6YewrsFtEbk
         H+efNXxyB96ZcaU4+yllN6hhNDBI5i7xdCK90uHOg2wRyDjeeUO1sspRDJJNavUsnjz/
         R6fDr3pql08L8CINml1OgXYcdwxhSTFwfsvb0/l5/HkKMV0YhfwoQxt5HFBHm4gxfYdk
         wXEKclRV1Tv4D7JT80pRExZo1JbosQEI6OkLKySj419HLTkbJD/UnkSKs2TA6CNzQEgE
         fVlA==
X-Gm-Message-State: APjAAAWs2AICoIeYLRGNOFnKc0TsWcVeDdrOfPDNqTwkXX1TEdQiI1tK
        VuFJn5HewhxeiOH2nRQ/3ew5dMUrQKE=
X-Google-Smtp-Source: APXvYqyK0qj5HLMKMLXmQOb7okkdQlEbwc/D6lcD5ezdS+XP94bqT7UHgHi/TkC2NF6RM2g7NsaSig==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr8727150ljj.93.1573773581802;
        Thu, 14 Nov 2019 15:19:41 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 186sm3671976lfb.28.2019.11.14.15.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 15:19:40 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id z188so6433366lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 15:19:40 -0800 (PST)
X-Received: by 2002:a05:6512:21c:: with SMTP id a28mr8857425lfo.79.1573773578349;
 Thu, 14 Nov 2019 15:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-2-evgreen@chromium.org>
 <20191112083208.GA1848@infradead.org> <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
In-Reply-To: <CAE=gft4=3ysHxWBVjfOsGVRHcORP3XcbSxd3hQ+YtJhMTPNgKg@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 14 Nov 2019 15:19:02 -0800
X-Gmail-Original-Message-ID: <CAE=gft6-dOUztUDHQUKDbw=ghdyXfbVD49nax5PiGJmWpAKhVg@mail.gmail.com>
Message-ID: <CAE=gft6-dOUztUDHQUKDbw=ghdyXfbVD49nax5PiGJmWpAKhVg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] loop: Report EOPNOTSUPP properly
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:09 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Nov 12, 2019 at 12:32 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Nov 11, 2019 at 10:50:29AM -0800, Evan Green wrote:
> > > -             if (cmd->ret < 0)
> > > +             if (cmd->ret == -EOPNOTSUPP)
> > > +                     ret = BLK_STS_NOTSUPP;
> > > +             else if (cmd->ret < 0)
> > >                       ret = BLK_STS_IOERR;
> >
> > This really should use errno_to_blk_status.  Same for the other hunk.
>
> Seems reasonable, I can switch to that.

Oh wait, the other hunk doesn't deal with blk_status_t at all. Before,
it just translated any errno into -EIO. Now, it translates almost any
errno to -EIO (the almost being EOPNOTSUPP).

So I'll change just the first hunk you pointed out.
-Evan
