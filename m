Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29991679C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 10:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgBUJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 04:49:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41396 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgBUJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:49:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so1457269otc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjU3wpqCAQUp1JJhVa/3iKyUwSIH2w6WIpuUa9MXo7A=;
        b=Y4v+gTQ0PrEwUHtM8C+xTUe3XAknh3mb35LEvuit63Pp7tC39/HbTuSnFYdEEkbkho
         1TC6ePnd98uNgZtB8imGWhOeUygUGLzA9IfSDrYc7FQ3mzEqMK1Ut2pwHECDzufp7wci
         KzPVIFYpB/tBw2dCm3Xh9eQFTYI3Xq94osvDJRZ5YP3MGOc9qyg6UR0/GSnPnuoeWcfr
         UAQp/CvB2VKBmakSWvdl5z9eyBBK6rk2PN8vtvyT0v5ZJrUg/2cp00qXWLWBr2qmaZJQ
         N2DLRre2ikylSJqbEkRUzYzPn2otLxupFcW611E4FovmbuLG3XtUAZfqSUnkE6WolMVY
         //JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjU3wpqCAQUp1JJhVa/3iKyUwSIH2w6WIpuUa9MXo7A=;
        b=Y+/Vp0WySAc5AdC0PbmjQuMQV6XhnFPXJMQY+3Wl3q96JABrAyv5N8oDNiN4F2eGf0
         ZIP6ONg5iNrwc7+WE3h0DFhzyGYYetk335VNcJm0GCYM9cjPkBaClp4occnNu8fB9Jqq
         Rwv7QzSXIj/prS+8ShUKPUXHGQMpJc7ZVNSKfA5jmg9rbNposSO5Cm61jCOeVdJkUsrE
         RXjPkqEo2ZCmIKGk/r3js9Sc8TPZv77//ezUG0rI9GuAlHC4vbpwjbYFdMknLYyA+Wnm
         /BbzED+bjSnvzXkpR4oFpoYAdH+hp9JPdUo5QYHF9WGBoIIyXO91dYn704ZdX5IHMHIK
         9EGA==
X-Gm-Message-State: APjAAAVkTXCRYqEpZUKb2I8MoYcjDjciqCEg58BHe73eT4M6DtmB7oe7
        hS/4b1Vg9vg89puDmUvKSmSbVdqMB0gdUJ20nsgePQxg
X-Google-Smtp-Source: APXvYqzzihlA7LDlkcni2l26UodMtNxYn5TS7X3HGj79Ggz46iuBS/zFfn7Y8dbvRMAKw1EPb4ijbhYkLw/vQXdA4vM=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr28747980otq.231.1582278565490;
 Fri, 21 Feb 2020 01:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20200221080510.197337-1-saravanak@google.com> <20200221080510.197337-2-saravanak@google.com>
 <20200221092540.GA71325@kroah.com>
In-Reply-To: <20200221092540.GA71325@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 21 Feb 2020 01:48:49 -0800
Message-ID: <CAGETcx_yQZtU4O2KgMxVt-hSJCBtNsOpyWsSXc+OZcjjJ91M3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Call sync_state() even if supplier
 has no consumers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 1:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 21, 2020 at 12:05:08AM -0800, Saravana Kannan wrote:
> > The initial patch that added sync_state() support didn't handle the case
> > where a supplier has no consumers. This was because when a device is
> > successfully bound with a driver, only its suppliers were checked to see
> > if they are eligible to get a sync_state(). This is not sufficient for
> > devices that have no consumers but still need to do device state clean
> > up. So fix this.
> >
> > Fixes: fc5a251d0fd7ca90 (driver core: Add sync_state driver/bus callback)
>
> Should be:
> Fixes: fc5a251d0fd7 ("driver core: Add sync_state driver/bus callback")

Sorry, late night sleepy patches are never good!
Btw I thought the sha should be only 12 characters but then saw
another instance where you used 16 chars. What's the right one?

>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> So this needs to go to 5.5 also, right?

Did you mean 5.4? Yes.

-Saravana
