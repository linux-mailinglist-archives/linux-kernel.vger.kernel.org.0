Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEA777C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfG0IuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 04:50:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55142 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0IuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:50:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so49756036wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UPNTz4TdgzIZmMBXeTwtZgEi0MW7Uef+jaY95Hrkds=;
        b=RmkjqWEyykTcnQJOzeVJPssrZCe1IDbCTicTgCyB17xg/pyUVbCGsnH85S6mBbL6Fj
         KMDdamonixrIwb18WueFU7+3xJRnixen9A/u494I7HesUdwH6oame7qDGjhxzrmchGGp
         lSzjjMflEhF/Gshz2na4TPBgBiTr9MOxr6tyf6VVaKOaRw4mfwABG0fwW7gjolMHhIjb
         5q1Q/ANNgTQ1P8AhlvG4TfEqnVVNBALz9zjPimHVxRE6O5YKgCC22ZoGf0+FtozAcCwq
         FWUUD7tXJ5x4giwLCoyjLx8ak3CrI7Bc8e96iwr1YjUGleMOs8o1srXOiUk6YKt+bVC1
         TYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UPNTz4TdgzIZmMBXeTwtZgEi0MW7Uef+jaY95Hrkds=;
        b=IKddjAg8RCzQj45660Q3dXSRBkuDVZfFv9mM3niTuvUCY0N5r667ghv3pX12VglGkc
         3+Zw3glqUsHoqnA60/2JOSLGgW9Q4hmH+nFoJyNov5mJquVSSKcYIFDYwBxxVn1++pIe
         6HcDqhgXBO9Dig+BkYkWw+sfJ2xig24dvmUq5OLJB4HA7Li4PDkkYxzCDZIxiha/kjnW
         rPEdZeeRoeKFflfIYfUeAwude5cjZSe7OXUMMtFGqn/iQGr+CdwR3Ym4F8R5FkDFPPbE
         AgKk97QDF2Q6oVvn32oef8wLXYFfD709BhJxwGpcseU3vc2q4glKwdNpVUm6K2WQZjml
         J25g==
X-Gm-Message-State: APjAAAWW29eYMPWVvL+SWCDvXKhaCuyr+lyWf7S9g6wIMds8GOR4oQPg
        vIqW7biIR6sPfo5oj6IHcpUJ66SGk9vR5m4dbO0=
X-Google-Smtp-Source: APXvYqzQ4Q9GNrarrIHfE0HUsoXwYb1yvJMPY2nvjma+Y+fGnO61LESEhgXK1xRqBYxX/g71uSVyV/no2h0IlZs2xMQ=
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr84386351wme.103.1564217409437;
 Sat, 27 Jul 2019 01:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com>
 <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
 <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com> <alpine.DEB.2.21.9999.1907261625220.26670@viisi.sifive.com>
 <MN2PR04MB6061790AFE4E0AAA838678028DC30@MN2PR04MB6061.namprd04.prod.outlook.com>
 <alpine.DEB.2.21.9999.1907270043190.26998@viisi.sifive.com>
 <CAAhSdy0Eycc0ORSnh6LJeC_D_x9yLOkoc7OkPNuN6qOcZEGVWg@mail.gmail.com> <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907270108420.26998@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 27 Jul 2019 14:19:58 +0530
Message-ID: <CAAhSdy1pqZP+M27idvfOB8eB8zhPD_7hx9S60FpOmWRHs-R2qg@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 1:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sat, 27 Jul 2019, Anup Patel wrote:
>
> > If your only objection is uppercase letter not agreeing with YMAL schema
> > then why not fix the YMAL schema to have regex for RISC-V ISA string?
>
> I don't agree with you that the specification compels software to accept
> arbitrary case combinations in the riscv,isa DT string.

DT describes HW and HW follows RISC-V spec.

Enforcing software choices in DT YMAL schema is not correct approach.

Some other OS (such as FreeBSD, NetBSD, etc) might choose to go with
upper-case characters only in their DTS files.

>
> > The YMAL schema should not enforce any artificial restriction which is
> > theoretically allowed in the RISC-V spec.
>
> Unless someone can come up with a compelling reason for why restricting
> the DT ISA strings to all lowercase letters and numbers is insufficient to
> express the full range of options in the spec, the additional complexity
> to add mixed-case parsing, both in this patch and in the other patches in
> this series, seems pointless.

So, using strncasecmp() in-place of strncmp() and using tolower() for
each character comparison is complex for you ?

Why do we need a pointless restriction  in YAML schema ?

Regards,
Anup
