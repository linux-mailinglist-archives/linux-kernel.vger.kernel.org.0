Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAC2D267
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 01:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfE1XYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 19:24:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45846 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfE1XYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:24:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id t24so135834otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGPN9OjlN0u2vkYT7lUEXn5/y2a9ZsC+Dfozs38xwo0=;
        b=Ot3EWkd25DfNtyqQZi2lKoCMywsWj1GEkyVsamx8IhpKmMYoQlNVtFXDsN5kzZ6ztV
         G0G4l+Yn9BT/91zveLip+MqoiQ9WY7KdLEeUnxKqsGaf/8a6P6TCdXsDzggmJbd8BC7j
         j7g/1ER+6QZ5ydhZ3Bf+DMekuCVU7XQ2krnuSQI+4HCJgoVYtDwKLQjR3UkiqRBl2ZBC
         Hbgfr4g8WcFCgwSmqfiyN+oPogiE52ZKR9MwXWkiESYTJsOEtnnzFKKAjkloisXxqBPE
         +CTyleolaoiiIlj62zgtnI49WL88oeZM7ei1tnil/DaLguKbl4ERfII14rmEY0DmU5Lo
         55/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGPN9OjlN0u2vkYT7lUEXn5/y2a9ZsC+Dfozs38xwo0=;
        b=BYQPlaW8tBSYTY+bsUWEFCGBvy2qZWUjcxkHlopOqx8rFD+Nj0snEQvCmQf6nFRcYa
         yk97cneq1UXVRy2tm7GO6mZd2LEFl0IH0xfovgxNmjN6OMmmmEzbT3p2eRRiKM49WRSU
         vGHKvak6vBaNJOQHaHrADy9tn9ZdlaDz7GgoENoBKM4whHDtqLLwmZlWa2zgb38L5f10
         hZ5VwvJ21vHIuruBnYAjgcTsxifS1XebxKZGwHKIMGPDJEfUshyrELGcBgNunZ6qeXsZ
         eku4zYHFO9RRW1gLlFkWPlK4oPh1JMX6erMNNpyZJO9grY/BXEqYf+qJ5+lx08ry8rnK
         gYqw==
X-Gm-Message-State: APjAAAXSixCpGjJO7xbdy7u+7y5gHZrvCnD1PrJnJ/19h7Gn6BnGWldN
        PCDDh1EdLL//I9CRMAsWcawmjOzagJFuypDpgUUSEw==
X-Google-Smtp-Source: APXvYqzRVCXeGxin0Tw+MDHx9N4J9nIhwON+HiBvCivgZkw6Vu0lhpKmb1+NRC/UKwUe3iqj0TpzPBIsvDgNEbU7wmE=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr5793otp.110.1559085842981;
 Tue, 28 May 2019 16:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <10418.1559084686@warthog.procyon.org.uk>
In-Reply-To: <10418.1559084686@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 01:23:36 +0200
Message-ID: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 1:04 AM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > It might make sense to redesign this stuff so that watches don't hold
> > references on the object being watched.
>
> I explicitly made it hold a reference so that if you place a watch on an
> automounted mount it stops it from expiring.
>
> Further, if I create a watch on something, *should* it be unmountable, just as
> if I had a file open there or had chdir'd into there?

I don't really know. I guess it depends on how it's being used? If
someone decides to e.g. make a file browser that installs watches for
a bunch of mountpoints for some fancy sidebar showing the device
mounts on the system, or something like that, that probably shouldn't
inhibit unmounting... I don't know if that's a realistic use case.
