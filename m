Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482BC15B695
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 02:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgBMBXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 20:23:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46725 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBMBXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:23:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so4587035ljd.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 17:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Niu+kdfvvCIMBWkR6WeCCUnPagPYeQrbAxMdltvbKWQ=;
        b=MHkddpuLQxWE6bwmmePSO7R3xQcz+c+j4MZzk1C0YQpt8ceysAGKLp8x91foJ7iQlD
         4y4uMHC5B1VyhB0wx/cqmWqAC7pmpiG750t9dhUXqG0dLcNFXBoYwHITqKzQ4RKVJgzn
         DiaugaxGhLTsNZ922hTk3ke6o/ufyHGIdQX7cqkyjfFfxkGwhLQELjyIAGfawX4j1Dph
         GLtMGvROaXVjUgDtsoy5FSP5/4rbsblecCoFjlewYUy6iIFbvl0WWiQ0LpnrZojizfP7
         RGsZtE4rHLdFR4Sguj4CLf0M1Opqona0TmUQqOOn/hZqvOu047byyWKLoyTOdmvQb8ut
         TZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Niu+kdfvvCIMBWkR6WeCCUnPagPYeQrbAxMdltvbKWQ=;
        b=KJFa+uNY3URy1kRTmqbuZop5cFZj6CUgxefXZu4u/rgvWdjLLSrsQqjT+/tNKHrma6
         FtTmZWqeZu92JjJBob57cQvdxPUZ9gFwjHPaJGfnrCuilPg/pqRoT9HnKEfiVtYadRMa
         gpJgch98kwyI0+Ke4G2uhG6fMXvjpZOTKzz3Ed6reKRv6aCuwalLbGvPRkE4hdODBAJa
         ppkZUB3DvtMQ+7Wc2jSPo3b5IGvwD2h6wgkIZuCMc0pJIKG1SzgfRSHlVY2MGMXby2gu
         sW56guCqJ0Tu2AS7D2QLgy4FL/ErQL/4lilnqx9jbbZEt8CCHmR1zxMrtm28GyZI7hpI
         jY4A==
X-Gm-Message-State: APjAAAUESghpn5Ligx41eRoydJSCQzgu3l13R+acXv2nakj0eU10AlUR
        A7n2uBeIJyCiBtolplMsS/RHhiZU8VcbGcEZvNRm
X-Google-Smtp-Source: APXvYqwbCChc+ucGAtOuAwXGmDp33l5fRWnqGGG3wnZMB3ESfatRQoS6QPzn89GdgURx2pR7zDGc1Pm+MA3DOx4ZPG8=
X-Received: by 2002:a2e:86c8:: with SMTP id n8mr9208783ljj.205.1581557018182;
 Wed, 12 Feb 2020 17:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20200213003259.128938-1-zzyiwei@google.com> <20200213004029.GA2500609@kroah.com>
In-Reply-To: <20200213004029.GA2500609@kroah.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Wed, 12 Feb 2020 17:23:27 -0800
Message-ID: <CAKT=dDmo8Ui6cVdi2Rsk6PUtCeUku_07ngZ7d2xyDU1dBdHhag@mail.gmail.com>
Subject: Re: [PATCH v2] Add gpu memory tracepoints
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, linus.walleij@linaro.org,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for your prompt response!

For upstream drm gem based gfx drivers, the lower level device driver
layer is able to implement such per-process gpu memory total counters
but the common drm gem layer is probably not. At least the global
total gpu memory counter is fairly easy to implement, and then this
tracepoint can still be useful right away.

For Android, the debugfs has already been forced to be deprecated in
the coming Android 11 release. We have asked Android GPU vendors to
implement such global and per-process total memory counters. So they
can easily use this tracepoint inside the driver. This is mainly to
serve the profiling needs as well as the runtime query needs(by
attaching a eBPF program from userspace), and this patch helps
standardize the tracepoint in the kernel.

Many thanks!
Yiwei


On Wed, Feb 12, 2020 at 4:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 12, 2020 at 04:32:59PM -0800, zzyiwei@google.com wrote:
> > From: Yiwei Zhang <zzyiwei@google.com>
> >
> > This change adds the below gpu memory tracepoint:
> > gpu_mem/gpu_mem_total: track global or process gpu memory total counters
> >
> > Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
>
> If this helps gpu drivers wean themselves off of debugfs, I am all for
> it:
>         Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Thanks for doing this.
>
> greg k-h
