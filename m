Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8480813
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfHCToa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 15:44:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41924 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfHCTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 15:44:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so75861506ljg.8;
        Sat, 03 Aug 2019 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSfWQiyPm4CSNo1QZhxcFsbnyy4ONPqQIsRIrlI2JSU=;
        b=sq65spdvfcqDWMWURm2mHPrMbeRMwOYn/2PNDwct/VRghQiSBcMoest3DKnfTtoV2s
         Ytl22OOHj5muQD/Q2wrKOfyZYeWRiiOCoVmXdCOYvyRcSHB57cgnBRgHAy6FE9Z5BB5V
         S1/OuUP1EHY+5YIvOfmZrOlVVgqIat8jGpyAonoN9UuteEv7l0U7wRFs7QjeGZ3AQs4/
         2yyKPl7LprUPS5jwY3oMmin9CXG/YjwlzZRNis2M8U7GFQv/XDWhdTMStl9UUOMPW91h
         79ckcXtRwqrPpVNUHepG4ua9qsG59MvKyaYlYD2vJVB6YPEp8/6PO8WyFshRCqc8tpAp
         xKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSfWQiyPm4CSNo1QZhxcFsbnyy4ONPqQIsRIrlI2JSU=;
        b=WnbrDgnxUc96NPleONrX5JCZgoX/FDjGvNP+4SwKyBFV+ZeLEyOmWSA0vWrvnihqp0
         w7+qLOeGBVj9znSD0Uf63ZwqOkpXSIaKbW0AU5IwThyXnYAkPMz0kg/aTHMx0cptcSHh
         PEWFnhcpGadOEbB9ccwwdJikyzokJZgLsueV+hYOcsIbESIJ10ZN8VdK/jCWunWTMVQN
         EH6URN9klpSir1iT+l61itKVMMakEInoO0SpTLcULy7E/HAMu78R34bG+2L9a7it1by1
         G+D30WvXOUoYAw7Tn5ZmqHxuKmP10rcP1Vdw/sI5aDrV3biYqtTqXFBt20En54/6GEXe
         Yy/Q==
X-Gm-Message-State: APjAAAXfNTmmoqwMTFv6QTanfL78uHMBt65Z1+MKlKQ2AQXZ/VOwVUuY
        2vNF0+vQfrIy1wJAnqcYOYV5SXh79QoE7RH307A=
X-Google-Smtp-Source: APXvYqxY/XpjHES7liLUUPw/H+GchVxNIeIfBBsMA/zMcEwU6uAUSiweB0Vj673JXCFgPTdpn0Pper1ktkVC2v53spk=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr63538189ljk.152.1564861467169;
 Sat, 03 Aug 2019 12:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <1564859856-5916-1-git-send-email-jrdr.linux@gmail.com> <20190803192051.GC1131@ZenIV.linux.org.uk>
In-Reply-To: <20190803192051.GC1131@ZenIV.linux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 4 Aug 2019 01:20:04 +0530
Message-ID: <CAFqt6zb5phXBZCVwLVcRBQ8hqdMQ-SLX0q4jgTJu-vwHXH_A1A@mail.gmail.com>
Subject: Re: [PATCH] arch/alpha: Remove dead code
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru,
        Matt Turner <mattst88@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Colin King <colin.king@canonical.com>,
        Greg KH <gregkh@linuxfoundation.org>, rfontana@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, firoz.khan@linaro.org,
        Jann Horn <jannh@google.com>, namit@vmware.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 12:50 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Aug 04, 2019 at 12:47:36AM +0530, Souptick Joarder wrote:
> > These are dead code since 2.6.11. If there is no plan to use
> > it further, this can be removed forever.
>
> What's the point in removing ifdefed-out debugging printks?

If those debugging printks are kept under "#if 0" purposefully, then those
can be left as it is. Other parts are under "if 0" can be removed as those are
not used since 2.6.11.

How about keeping those debugging printk under some CONFIG_*_DEBUG option ?

While browsing source code, I figure out there are huge amount of dead
code under
'#if 0"  and some of them are maintained since 2.6.* . I send few
similar patches for fbdev
driver and those are merged to linux-next.
But how about cleaning it in entire tree ( module wise) ? Does it make sense ?
