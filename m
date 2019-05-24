Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF628FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 06:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEXEFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 00:05:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33426 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfEXEFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:05:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so7435353ljw.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMvKtFN1e33kpboGuviLZvfkEjRfz5jbm8LdT4mUCDU=;
        b=WgyI+my0JXdOEJsdGY3Vs1l2Q/d27f1OZS0CNv5G8gYHThrU3eKCmbG0Ks9W0F6obh
         2b1UUXdsa23Epz6r+vhmbgVPgbExpEmKy1okLJE5KBf9j7roDhQ1NU8X4tn5tbqNdHgw
         SYck62IL79urnywL2GC9eTu6+dov4ELvohsy4Banqu/68bCA1dUKlBg+YYZHQjYhBvQ0
         15c3wnoUfq+Qb+bUkL9w82hNs4nbkbIKKWiOu0Ampnv6qB4W2GdWvQjnCZmA7DcU3NS2
         hRtdmt1Os28GQcaTTlvO1p0lBEfjmfJK8IQ/ILHhkgPP5kG+UTY5Q8D16KpYlUEMI7fr
         BxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMvKtFN1e33kpboGuviLZvfkEjRfz5jbm8LdT4mUCDU=;
        b=jszY5GNRY9kIVX2ngEL5KySyXeMJ0kjc2WtDYdmgsM48PZMLCbup4yDyGVRgZyuvov
         g+0FBlrDZZYJ7urQntxx1QqH7x2JqyzEcyw010qQxVcGQjxQZwKLG8NZt0uvhp6eVdVY
         kgbVwOSHqfe21ecNrcoIexFAWidYpYgsHj+OcfyrISJ8hGcDvgp9MIuas3cKkSBAQ8As
         9pvCjP7XKv3jPdn0G2Od3p8Ia0QME18H1O+Wt/ga8L9OUKyA6R63yejylxweWwq4DWQ9
         zfjXBWw1M1hiUU4NDKtNJHWY7NnPUplOgATS0o7H6GFFtsfuaITjnuAZsYNbPTAD85ZL
         ynQA==
X-Gm-Message-State: APjAAAU5l3dbX1GQJd8cWi3VTmEKwv3F1xPbxUCFAWx+mSyFwku+iEQB
        YHUSA+YN3bHht67gTlr4Bor5SUftBWLcUlJdRwk=
X-Google-Smtp-Source: APXvYqx2COq+bydPlaV1tCE964ZlkfqtZ8TL30G7mGs9JJdsmHxxZkT2dz3Jc6A1xFhshtcbOczpwiaeyXLbndRY2lA=
X-Received: by 2002:a2e:2b58:: with SMTP id q85mr52647970lje.179.1558670747341;
 Thu, 23 May 2019 21:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190523124535.GA12931@gmail.com> <20190523221210.4a2bb326@oasis.local.home>
In-Reply-To: <20190523221210.4a2bb326@oasis.local.home>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 24 May 2019 06:05:36 +0200
Message-ID: <CANiq72=J_RkEByD1ToX1Y2MwkwrCdg0SFZKK02jwu_PpyADPoQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 4:12 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 23 May 2019 14:45:35 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
> I still prefer the typecast of void *, as that's used a bit more in the
> kernel, but since char * is also used (not as much), I'll leave it. But
> the parenthesis around iter are unnecessary. I'll remove them.

If the preferred style in the kernel is void *, change it on your
side, please! :-) Maybe we should mention it in the coding guidelines.

Cheers,
Miguel
