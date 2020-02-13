Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4715B8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 05:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgBMEn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 23:43:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34099 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgBMEn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:43:59 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so5016893iof.1;
        Wed, 12 Feb 2020 20:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOAxUlvkjyfqAIYXx6Do+GysHulIA2MesVPAjyjkQ/4=;
        b=IoBs8ClWZoxelFOr5RjrmOzWgMO6Jsoa+vglq9Y0y2slrgxOtoS3wWbeJVLlBAA+qp
         ViqgL0KLwJx/jjZyAAge0OvD5MLthdHi0zXe7y9XGjEW2DhLBHFbdK/GHLSlrexw2pDP
         Pt4bH5aTz+TshZs61RRQed6A4BW2iXawmQvRmdd/wYPsz5RNmXn73dEYYRsDbLlbOOTU
         nJopUHIDpPK7digT8x+4fupy16SG+ePgew/PRo+RCAWGSLJI+upyTC7K+6hZbJbiYQRW
         x6NxsNUX4eAUJME6Kywg4kCtumZjLtq+e7/wWGprcTNAUQMYB/+UQ8tAHU7OS7CxxFLi
         wfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOAxUlvkjyfqAIYXx6Do+GysHulIA2MesVPAjyjkQ/4=;
        b=Xnn39XUIHD20X/XrSg7alI+5ISWvRiWrVhBFccMfPx/iIRR0kasMgWOCMrySZLuU/F
         hkEaqUuSe/rnRWEC5HWT8g1qns6iHY6Y9f6VSbPmYzBGtchrCdddKtBIKAArVB7D7vd4
         msMa3I1M64wlPDnNgpEZGcsfoEXwHr15GjbguRp6VsDX5I80beN3CvDMtzWqH/arfH0H
         vOgs3Gr7XhAnv2Fm+v1QRN5RfbC5VjQlWTGlW9gma9nwm/W5yMkH8ZmI4lClF7ZeQPWV
         asItM7CVVkV8c7Gs8u85bDng1trcIR7zcNZFyQ/yWtNfOebDLSsljAFGe5mw/9dpBk+P
         SUjw==
X-Gm-Message-State: APjAAAXAipQ7NgMW4LUMYACu6uBeRYPQX71g8Tp9/rf0mSzSaPrFk2bO
        KQ31CqTJDzUw5JQHEwSN81eISFakW6r+kKW4GUDoHfYl
X-Google-Smtp-Source: APXvYqw4dGcf9paBeQzTtJqx0PllL6PR8sdLaZvHxYC4ixt6jYY8t4a1FBLccG4S6YbkUH3K9FU1Dc00i9FDDwLx7ZM=
X-Received: by 2002:a02:2a06:: with SMTP id w6mr22275426jaw.63.1581569038191;
 Wed, 12 Feb 2020 20:43:58 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mtQRVX3_-_sVjvigRSv2LpSoUBQo7YeY5v0nXm7BGaDig@mail.gmail.com>
 <5E413F22.3070101@tlinx.org> <CAH2r5mst9FjdPrBQdjt1HGkf73VoNzDUxPSEQNZwyi=9W9XGhA@mail.gmail.com>
 <5E448B29.1080705@tlinx.org>
In-Reply-To: <5E448B29.1080705@tlinx.org>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 12 Feb 2020 22:43:47 -0600
Message-ID: <CAH2r5mvH38WjkwJzb9Vv=0gAB1FY_4kjrRS4OrnBO+jeLi6kHg@mail.gmail.com>
Subject: Re: [CIFS][PATCH] Add SMB3/Win10-only Change Notify
To:     L Walsh <cifs@tlinx.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b640bd059e6dbc05"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b640bd059e6dbc05
Content-Type: text/plain; charset="UTF-8"

I don't object to adding the feature to 2.1, and if you have SMB2.1
devices to try even better (I can add your tested-by ...) but 99% of
my testing these days is with SMB3 or later target servers (Samba,
Azure, Windows 10, Windows 2016 or later, the cifsd kernel server
etc.).  We do some testing with the buildbot with SMB2.1 dialect but
it is a little different forcing the dialect to 2.1 on the mount (to a
server which would otherwise support later dialects) vs. actually
running to an older device (Samba server e.g. has supported SMB3 for a
very, very long time - at least seven years so we have to go back
pretty far).

If you have the ability to try the attached patch which enables it for
SMB 2.1 dialect let me know.  (I have also pushed it to cifs-2.6.git
for-next to allow it to be tested)


On Wed, Feb 12, 2020 at 5:33 PM L Walsh <cifs@tlinx.org> wrote:
>
> On 2020/02/10 06:30, Steve French wrote:
> >
> >>     By calling it a SMB3 feature, does that mean you are removing
> >> it from SMB2?
> >>
> >
> > That is a good question.  I should have made more clear that although
> > many servers support Change Notify prior to SMB3 dialect, we chose
> > to implement it in SMB3 (late 2012 and later dialect) to minimize testing
> > risks and since we want to encourage users to use SMB3 or later (or
> > at least SMB2.1 or later since security is significantly better for later
> > dialects than for SMB1 and even SMB2)
> >
> ----
>     SMB2.1 would be fine for my purposes, I find it a bit odd though that
> my linux server running these changes won't be as capable of detecting
> directory changes as an outdated Win7 machine.
>
>     There are many below-SMB3 speaking devices out in the world right now.
> Probably many below 2.1.
>
>     You say you want to "encourage users to use SMB3 or later (or at least
> SMB2.1)", how does adding SMB3-only support allow users to use SMB2.1?
> Say your encouragement of users is taken to heart, and they want to use
> SMB3.
> How would those users upgrade the dialect of SMB used in their
> machine or device?  I don't know of any easy way to upgrade existing
> devices -
> even existing OS's, if a user ran Win7, how would they upgrade the CIFS
> drivers to 3.0?
>
>     If it is not possible to upgrade existing devices, then wouldn't that
> encouragement boil down to junking the device and buying a new one?
> > Change Notify is available in all dialects (SMB2, SMB2.1, SMB3, SMB3.1.1)
> > for many servers but for the client we just implemented it for SMB3 and later.
> >
>     Doesn't that mean that the linux client won't be able to access
> existing
> NAS servers or Win-Client machine running anything other than Win10?  Does
> the current version of samba provide full SMB3 support?  If not, doesn't
> that
> imply that the client for CIFS won't be able to access or use these features
> from another linux server?
> > If you have a server that you want to support that requires
> > SMB2 or SMB2.1 mounts, I wouldn't mind a patch to add notify support
> > for those older dialects but I would like to encourage use of SMB3 or later (or
> > at least SMB2.1 or later) where possible.
> >
>     Again, how does implementing SMB3-only, only support SMB2.1 or later?
>
>     If you feel it would be trivial to add such a patch, wouldn't you be in
> the position of, probably, having the most knowledge about the subject
> and be
> likely to do the best job without breaking anything else?  Certainly doesn't
> mean someone else couldn't but seems riskier than offering a Linux
> client that
> would be able to access the widest range of existing devices and
> computers from
> the start.
>
> Thanks!
> Linda
>
>
>
>
>
>
>


--
Thanks,

Steve

--000000000000b640bd059e6dbc05
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-enable-change-notification-for-SMB2.1-dialect.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-enable-change-notification-for-SMB2.1-dialect.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k6k98uhe0>
X-Attachment-Id: f_k6k98uhe0

RnJvbSA5NTYyZjE3MGJmNzA4NTQwN2JlYzIyYzIwZWUyYTEzMzM0ZDIwYTU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFdlZCwgMTIgRmViIDIwMjAgMjI6Mzc6MDggLTA2MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBlbmFibGUgY2hhbmdlIG5vdGlmaWNhdGlvbiBmb3IgU01CMi4xIGRpYWxlY3QKCkl0IHdh
cyBvcmlnaW5hbGx5IGVuYWJsZWQgb25seSBmb3IgU01CMyBvciBsYXRlciBkaWFsZWN0cywgYnV0
CmhhZCByZXF1ZXN0cyB0byBhZGQgaXQgdG8gU01CMi4xIG1vdW50cyBhcyB3ZWxsIGdpdmVuIHRo
ZQpsYXJnZSBudW1iZXIgb2Ygc3lzdGVtcyBhdCB0aGF0IGRpYWxlY3QgbGV2ZWwuCgpTaWduZWQt
b2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+ClJlcG9ydGVkLWJ5
OiBMIFdhbHNoIDxjaWZzQHRsaW54Lm9yZz4KLS0tCiBmcy9jaWZzL3NtYjJvcHMuYyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWIy
b3BzLmMgYi9mcy9jaWZzL3NtYjJvcHMuYwppbmRleCBiYWE4MjVmNGNlYzAuLmFlZjMzNjMwZTMx
NSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIyb3BzLmMKKysrIGIvZnMvY2lmcy9zbWIyb3BzLmMK
QEAgLTQ3OTUsNiArNDc5NSw3IEBAIHN0cnVjdCBzbWJfdmVyc2lvbl9vcGVyYXRpb25zIHNtYjIx
X29wZXJhdGlvbnMgPSB7CiAJLndwX3JldHJ5X3NpemUgPSBzbWIyX3dwX3JldHJ5X3NpemUsCiAJ
LmRpcl9uZWVkc19jbG9zZSA9IHNtYjJfZGlyX25lZWRzX2Nsb3NlLAogCS5lbnVtX3NuYXBzaG90
cyA9IHNtYjNfZW51bV9zbmFwc2hvdHMsCisJLm5vdGlmeSA9IHNtYjNfbm90aWZ5LAogCS5nZXRf
ZGZzX3JlZmVyID0gc21iMl9nZXRfZGZzX3JlZmVyLAogCS5zZWxlY3Rfc2VjdHlwZSA9IHNtYjJf
c2VsZWN0X3NlY3R5cGUsCiAjaWZkZWYgQ09ORklHX0NJRlNfWEFUVFIKLS0gCjIuMjAuMQoK
--000000000000b640bd059e6dbc05--
