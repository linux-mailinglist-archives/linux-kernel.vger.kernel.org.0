Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6115B937
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 06:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgBMFww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 00:52:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43592 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgBMFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:52:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so5089826wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdNWu4OHnOgTnZiF3+iov76jtcPjdaRd9E5mmZYnJZQ=;
        b=ZL2pLDixvviRDFR7HKhowdwY5D9HTezhNYaZAZeAUDM3FCQoKjcfV7eapgMV7HxOc/
         yg7fUCnvwqUJIVHAjkwHZLZ2XaOs1YaBrs4GY7uQp68IZCAN9ny+WPbOiG/LvzA6IAxk
         aItYKxpSh6wCrLH0VlcTnDWw34XpObKix/Yl1UQnuJ1aS7AbDfVJDNVixphEcqHHeLCT
         4kwmUz2qbGISe7OtxIDgduO6/QeruniCwTB7vqRvbedOhza23Pg6bMrx0ODTORkUdevN
         g2LQ9x4xkcwK6sbgYpTsxpsK++d0D/6IKtLddRABtYy8H7FIkBPOUx3K3eQPWRRkBHPw
         TKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdNWu4OHnOgTnZiF3+iov76jtcPjdaRd9E5mmZYnJZQ=;
        b=nVsv0Hwuqp5y5AZ5TpJb7l4eg/conuoCJjMXMOubjeB7hswsmVIHAjP1Fx7+qa5za2
         VSgThd/N4xKzpwK4uAsUSKkbbXSlTLxNlEBYwOnk1RDH3CvrcwgP7AHWt3cpkT1e6lfJ
         HqmsUo64L1eLIFAnvIifUyvCHahTyAL5U5YU5FlSfd6Kzx643i2I80Yza4OcMjKCPiE+
         gPi3YrVANHRRjMgJ8VhbI8O9kig1Rm0PRunTAh+QwX3YzLFveSs0PoldvoMBGWa+b514
         iNT7y80xcf0GQP7BSKhd2jnoQDczOenVIfYTZ9r415HgtfSACF7UZlUmjEuZvDh9u9qH
         ckQg==
X-Gm-Message-State: APjAAAXl/IIqT8y9zW71BOAZkb8viS5+bz36iIzt0ChII92TtLVhBVeB
        Pf4Obtovk/eNFEERz0HPCZQtMzZ2FPyQUPpGvvUfXQ==
X-Google-Smtp-Source: APXvYqz2f/qeG+2bmZU1I3dr9L3f3Z4lMg9obUh6HEngf9qlbNWufTKB6zFfHZOr7ynAGtypkwl/PJ8frUoGatEithg=
X-Received: by 2002:a5d:5305:: with SMTP id e5mr19669063wrv.18.1581573170260;
 Wed, 12 Feb 2020 21:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20200212204652.1489-1-tony.luck@intel.com> <20200212230815.GA3217@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200212230815.GA3217@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 12 Feb 2020 21:52:39 -0800
Message-ID: <CALCETrXx7ah9c=TYGm3ZXvwUnoJkDHP1vbuqaudih9fik5W9_A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] New way to track mce notifier chain actions
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 3:08 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Wed, Feb 12, 2020 at 12:46:47PM -0800, Tony Luck wrote:
> > Part 4 is where things are interesting and need a great deal more
> > thought.  A bunch of things on the chain return NOTIFY_STOP which
> > prevents anything else on the chain from being run.  For the moment
> > I ignored that semantic and added code everywhere to set the BIT
> > even though nobody else will see it.  This is because I think at
> > least some of them should NOT be NOTIFY_STOP.
>
> NOTIFY_STOP is just one mechanism for preventing every function
> on the mce chain from reporting an error.
>
> The other bit I'd like to reconsider is edac_get_report_status().
> Back in the day we seemed to be paranoid about reporting the same
> error more than once via all the different reporting mechanisms.
>
> Since then I've had to track down numerous "Why didn't this error
> get reported?" questions that frequently resolved to "It was reported,
> but not in the place that you expected".
>
> So now my attitude is "Let's just log it everywhere in so that
> whatever log the user is checking, they'll find the error"

I HATE notifier chains for exceptions, and I REALLY HATE NOTIFY_STOP.
I don't suppose we could rig something up so that they are simply
notifiers (for MCE and, eventually, for everything) and just outright
prevent them from modifying the processing?

As an example that particularly bothers me, do_debug():

        if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
                                                        SIGTRAP) == NOTIFY_STOP)
                goto exit;

There is all kind of garbage hidden in there, and it's mostly
somewhere between slightly buggy and violently buggy.  All this crap
should be open-coded.
