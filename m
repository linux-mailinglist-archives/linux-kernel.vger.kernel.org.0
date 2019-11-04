Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105E9EE297
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfKDOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:32:45 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:46771 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfKDOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:32:44 -0500
Received: by mail-io1-f49.google.com with SMTP id c6so18600150ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pPoc1LYjuuWW85w5om7p6J+XA/2Iiyol16QOP7FwRGU=;
        b=lyVW5vXOD7ThTrnsn2DY0eCQkEyMbv/U7Sr+YigbWns8kxBBvKvu10euWMUMb+FEpz
         p6aa2S8RKRnGntEKUz6pOXZ2cUtAXGuDWKTu8yf7GEVv6vM2oTY2WTtLrrMXmZNtjiPM
         m5fXHEUPf5rgupIGT4bDAVnR6IF8KW3mrmOyZ8+GUblTJVP4a6Ddmp37j5w1fJkXci4b
         1GCau1W/kFlYI0tlLtjF3K8UK1FXsFlBj73fgDNl6Siy88f6bZj4wgYmTnLJOibG3qZu
         VLp7YJEEVsv88yVH+6YFfQLWJ02XKASZEucjQVva2BLQlV6nmVHHTYE99hXyBAAIeXcT
         GdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pPoc1LYjuuWW85w5om7p6J+XA/2Iiyol16QOP7FwRGU=;
        b=c6t/yp8mfm5njtqGd7lPYC3hzFRGaMctLo6sErRVMQlpDwfz5P53WPj8/4eikLrib1
         xqR6+bnVS+W29PZIP1ig1A2tpq5AjjxV3xp5j/oMyZcLygQecYKIkvSWzXtbiv3W2KH6
         sM3RolZqeK++Uf2TvdvsavFzS+lvMI5oVu1MMUg0aVs1Bq69ftYjh8qVhSVvh5CSud+g
         SfRmc/YJEzk1zDyrvOk4Q28tlsnjAaNBw/2ULresC4ZYjbnBiMyNW70Em19TVUcHd3qG
         j7bEwM+5wShPS2B+lzB5jtn+04SFt0bESSq04x8KNzPj9utBiZ+NJ4gVyRKygWx2P5Mr
         ojqw==
X-Gm-Message-State: APjAAAWtgF5zBF8s3V3Q8BJW3kYsDWOYUC5GCbDIVKRuXmltcFJGWmvm
        RmfT+2v9pBVaetseGCRXR148MQRVNYwYGkPowZrHLaOc
X-Google-Smtp-Source: APXvYqx6MDx6C3PO2aqgCXGuFud0ElWF1FLT862wB4fORTO+GoUuV6nfKQZllGGbF8zFknZ9v9Ch1Zy2BUq3DpvuCI8=
X-Received: by 2002:a6b:7b4d:: with SMTP id m13mr16990964iop.23.1572877962831;
 Mon, 04 Nov 2019 06:32:42 -0800 (PST)
MIME-Version: 1.0
References: <CAFSh4UxSx7SYT=Ja6TbwFwCJm_yn6VtMapXGv3B=+g2rQcALSA@mail.gmail.com>
 <20191104135111.GF28764@mit.edu>
In-Reply-To: <20191104135111.GF28764@mit.edu>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Mon, 4 Nov 2019 14:32:30 +0000
Message-ID: <CAFSh4UxquUDSbw+JA1t=VBpe1yn+ar3MjsFbJP9bRo5a3BWAnw@mail.gmail.com>
Subject: Re: Power management - HP 15-ds0502na
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:51 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> This is actually the laptop's ACPI and/or EC not supporting
> suspend-to-ram at all.  Suspend to idle is the new hotness, because it
> gives the OS much more control (but also gives the OS much more
> opportunity to screw up).  The Dell XPS 13 (models 9370 and 9380)
> supports both s2idle and s2ram, but s2idle doesn't work well at all on
> Linux.  (Well, at least not the upstream kernels; the official Dell
> Ubuntu kernel and userspace apparently has enough tweaks that it works
> well.)

s2idle sort of works - the thing appears to go to sleep and wake up
okay - but the power savings are not really enough to make it
worthwhile.  Putting it into s2idle state and putting it in a bag
results in a very hot laptop - and of course that makes battery life
not great.  I'm guessing this is the Ryzen 7 CPU idle states not being
very well supported?

> > * There are a few devices that appear to be on I2C buses and declared
> > in the ACPI tables (eg the fingerprint sensor) which don't show up
> > under Linux.  They did under Windows, until I blew the Windows
> > installation away to install Linux, and I'm assuming that Windows
> > found them through the ACPI DSDT.  Now thinking it may have been handy
> > to keep Windows around for debugging, but that's regrets for you.
>
> Even if they showed up, it's unclear the device driver would exist for
> Linux.  Most fingerprint readers have proprietary interfaces and
> aren't well supported by Linux in general.

Yes, understood.  But the first step would be enumerating them through
the ACPI tables (if indeed that is how they are announced).

> > Is this the right place to raise this?  If there's some other place
> > that Linux ACPI issues are dealt with, please point me there as I've
> > not had any luck googling.
>
> There is the linux-acpi@vger.kernel.org mailing list and the
> linux-pm@vger.kernel.org (pm --> "power management") where you might
> try asking about the s2idle.  A lot of the issues with s2idle appear
> to be very device driver specific, and not about the power management
> core, so it's unclear folks on those lists will be able to help.  But
> it's worth a try...

Thanks.

Tom
