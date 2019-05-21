Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189A725148
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfEUN6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 May 2019 09:58:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34850 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfEUN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:58:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so11111610qkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9O8ckb7uxVFJ//ox9IvAmefEDOvxUsseToexSnoT8pQ=;
        b=ZtKz1hvMluijANHiZWHDaBlTUQEIE79VkBND2bpQ89WXjz5PTGydKzpoU5iz3gZinz
         LDc0F6OewkPQQIb9O0lQiLolJ0cEFH2fxkKE0sswPNTJlg3tZY9PNI5nBYdsPw2pxQhR
         Zz/Yk1ccWQZA/8/dm67sn7iKO8ATus6jSMd7f+6ibUBgXyiTJvOFz9OXsqwR7ZxVo/li
         1Z2IgHfbZKlRk+WAyWCcnzALIeExgIG3cIxo0IrX7/bDhjJghSRh4zM/HNKcDxOjNFGP
         kjoQe0k5+0gsHUMes/QSd6zLbhuM8HfuJn/TBh4nzRRi3BG0qNl+8LsrKnyfhqf+MEPD
         1rDw==
X-Gm-Message-State: APjAAAWLR5qRLOvUDEx5lX6Pqt/266hwbVjiCOoqXkca64LFTsoOO0Im
        Yed7+ExsxqXNysFZQD4b7gRP41WCBzw3UBKoWQPthQ==
X-Google-Smtp-Source: APXvYqzMpLfnT/YGYtVzFI5EWHMlYOqg+qfnY276uGSktPVGL781p5pFOpJHltwv7KWpA0dL+Flhbm35wLZAeu70Blg=
X-Received: by 2002:a37:9085:: with SMTP id s127mr41834500qkd.352.1558447093095;
 Tue, 21 May 2019 06:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
 <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
 <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com> <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 21 May 2019 15:58:01 +0200
Message-ID: <CAO-hwJKctsp9=ZJuJB6YRtA+RHuv1NJ+9cWp9hub8oATh1MXCA@mail.gmail.com>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by hid_field_extract()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 9:30 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 26 Apr 2019, Kai-Heng Feng wrote:
>
> > >Ronald (Cc-ed) raised quite a good point:
> > >what's the benefit of removing the error message if this function (and
> > >__extract) can only report an unsigned 32 bits value?
> >
> > I didn’t spot this, sorry.
> >
> > >
> > >My take is we should revert 94a9992f7dbdfb28976b upstream and think at
> > >a better solution.
> >
> > I think using a new fix to replace it will be a better approach, as it at
> > least partially solves the issue.
>
> Guys, did this fall in between cracks? Is anyone planning to send a fixup?
>

Kai-Heng, have you been able to work on that?

Cheers,
Benjamin
