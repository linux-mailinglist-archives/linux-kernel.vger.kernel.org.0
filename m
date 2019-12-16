Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C211F441
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 22:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLNVaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 16:30:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLNVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 16:30:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so2650357wrn.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZE43dsMkpbOowbdThDfr++A+vm8RAdpXC2KmBWEMOmk=;
        b=GdWGTxKQxlxuSKElGDnFU8WiA2IFAvEmSQg2vzKcxkinj4Cb1yT1SuQeKu9UWcc23N
         miPgUxYb/GSsPl+TCdFF4/NMU0YuJd5dm1s4J0eGr9462tl7XCHZMoIBQzvalBRJ644e
         j4xPQ3AkKsP/TDNRDElTi+TPbnvcg+KV72f+oP/JDbooHbU4BBbdsYNcIVNNnufLBqwy
         gRCvC35HXk+r/F2be2MqMH1JDVHchBQR5E7qnpLElczt63rdbm3bstOvcGpwXIqBKUEt
         lw4EiYo3sRSetaVnzLFOviAHUB4+/6mQjcMBL7UQBYsdJioCvVUiPFhZQZnLga+6h8sa
         8h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZE43dsMkpbOowbdThDfr++A+vm8RAdpXC2KmBWEMOmk=;
        b=jsT5jIBGsAeHNQ9WK879rGpdGFj2bgvl7Y8I+DKW+J5TWXudXRxpIwYjRoisrgIX1Z
         7sSgQkskU96n4DMDsgMw0PMtzsEWa88fYeObsxPGQ8ndY1OlJDuOePmgzhhq01DreOiB
         3YQQ2z0/+AeB7uz57TuyEQKBGfkxbj8Nql6+7XFwsMiBjwRJsgrjOKZQXy+DOgRWHRcA
         DgTGFcmOvpanCNiaL8q0DxCVfQcpR37Tvri59yT53z8QdjaE1cULwsIzgWlLeswzf9Wc
         56fSQRudZrcEiEsAVtNMhDgXkRCvA1OTMaBLL/MonZn65JfKbJDAkMjPOGHCtgrKxQli
         m+vQ==
X-Gm-Message-State: APjAAAXHnlF1iYvaj0ssE+L20WYtalL6+jk3nXgstYggwYMpdgN7HAC3
        iUVX+vRArz9JE5RctaQvVwmPYmlKW1/O9AejKdz1wQ==
X-Google-Smtp-Source: APXvYqzgOkE0x4xUEugYy4zK1uM8VFvf6LnslZO0PGkZA6sUWQduZPl1VoXiuJHt8LwZu2c8eMW42/6WGFWe+KlS1N8=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr19877635wrj.325.1576359009672;
 Sat, 14 Dec 2019 13:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20191214175735.22518-1-ardb@kernel.org> <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan> <20191214194936.GB140998@rani.riverdale.lan>
 <CAKv+Gu_JQz=xd_UmqiuZ8TvA+ksT_rY4iXP_j7OdW4F5sfZt9g@mail.gmail.com>
 <20191214201334.GC140998@rani.riverdale.lan> <CAKv+Gu-A4bE0DM96-dNjtsYG=a3g-X4f-y=NcJ5ZCvZHaDJZmw@mail.gmail.com>
 <20191214211725.GG140998@rani.riverdale.lan>
In-Reply-To: <20191214211725.GG140998@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 14 Dec 2019 21:30:08 +0000
Message-ID: <CAKv+Gu85yLS6cYaGPTLc=hjHjvjjYYX-E0wCwKK+1W+T9dxAcQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2019 at 22:17, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sat, Dec 14, 2019 at 08:27:50PM +0000, Ard Biesheuvel wrote:
> > On Sat, 14 Dec 2019 at 21:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Sat, Dec 14, 2019 at 07:54:25PM +0000, Ard Biesheuvel wrote:
> > > > On Sat, 14 Dec 2019 at 20:49, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> > > > > > On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > > > > > > +
> > > > > > > +#define efi_table_attr(table, attr, instance) ({                   \
> > > > > > > +   __typeof__(((table##_t *)0)->attr) __ret;                       \
> > > > > > > +   if (efi_is_native()) {                                          \
> > > > > > > +           __ret = ((table##_t *)instance)->attr;                  \
> > > > > > > +   } else {                                                        \
> > > > > > > +           __typeof__(((table##_32_t *)0)->attr) at;               \
> > > > > > > +           at = (((table##_32_t *)(unsigned long)instance)->attr); \
> > > > > > > +           __ret = (__typeof__(__ret))(unsigned long)at;           \
> > > > > > > +   }                                                               \
> > > > > > > +   __ret;                                                          \
> > > > > > > +})
> > > > > >
> > Yes. I'm open to suggestions on how to improve this, but mixed mode is
> > somewhat of a maintenance burden, so if new future functionality needs
> > to leave mixed mode behind, I'm not too bothered.
> >
>
> Maybe just do
>         if (sizeof(at) < sizeof(__ret))
>                 __ret = (__typeof__(__ret))(uintptr_t)at;
>         else
>                 __ret = (__typeof__(__ret))at;
> That should cover most of the cases.

But the compiler will still be unhappy about the else clause if __ret
is a pointer type, since we'll be casting an u32 to a pointer,
