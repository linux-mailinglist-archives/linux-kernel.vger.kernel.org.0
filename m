Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A29B3158
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 20:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfIOSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 14:25:54 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36780 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOSZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 14:25:54 -0400
Received: by mail-lf1-f51.google.com with SMTP id x80so25721646lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbnIhtM2BKG6IYVDdOCp6G8vpQKdSMQTGQ4f3pGk7vs=;
        b=rd8EsNf9yf0dbuq9g/TOSPhliI7d5mEgLIU6opvAUyXGQMgiDsdhhlM5NPYE4fx4fV
         1oIdwGiYWhlCrYOTnrtb9KqomL1oZuScESRZ2MCh/0i4A9dsY3NTv4oKmBhcBEZf9oYn
         l2awC19NQnKyP2X4nyreahL+qcvbxKzIwPPwfurn4sgESw4OpLCUT9SZowM4Ys9RChKO
         FeK/6/MJ+iT9QD3ZFQ85VXaXXp5wbMSQU9sKjCI//9gHJVJwONQlxeBuTzDLAUdIjfbq
         5Nu8HSKS1g6PT01zTy6vWgPv6BYBOI4cZnO+nLVNgPNTjeubShzLmv1gaAmvN2Rk7xWl
         IqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbnIhtM2BKG6IYVDdOCp6G8vpQKdSMQTGQ4f3pGk7vs=;
        b=rPupUmjtFb9cRSf63sCOvKobNO5aZfTMGqhA2bG1AZwxJyaLq6jjtqZ2rG81ailaSJ
         aP16pS6zc52rH8BCbBV/MHqCRSTGlo/qdgxgDNDbz18LFcV5/MHGYFnTh3iPNSjZ7ZzJ
         vRJ2YI82J7yDgMyylTQnQ2iFx7w8CWH/zajlxaNl6d5phAOnG4LDXyrNMLgarQ8S5Xv0
         b/c28zJ0BYGm2bhllZXR7cZwrSv/q097MpP5IMj4TRsb4PNgOdWxV+ePhYPHEFng/EY4
         wzHnmMn5YaFCieKze5qvO8lnPy562IwmGR21RSiRKwGaAuypxH3e+i6F1chSLDcu0u3x
         EGdA==
X-Gm-Message-State: APjAAAVKa38RswfuKwGVhrGjU6QR1/6B1UaTD1KRNYMsgc0NxNX7koX2
        rAKHbIAHuIVZ+KEnB2xlqB79uGJGTxQ97uAZKZY=
X-Google-Smtp-Source: APXvYqxt2+mQ3NuxseYtTtkITEVZZpuRJghHl2BxfXJUF7jA0peoLYvGXe4n93Y8vVqBjwX5kP69Ez9EJwBWCgqQPdI=
X-Received: by 2002:ac2:4902:: with SMTP id n2mr37085890lfi.0.1568571952132;
 Sun, 15 Sep 2019 11:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
 <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com> <fdd69f54908d90cd0c93af7b5d80a6c3ca3b5817.camel@perches.com>
In-Reply-To: <fdd69f54908d90cd0c93af7b5d80a6c3ca3b5817.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 15 Sep 2019 20:25:41 +0200
Message-ID: <CANiq72=H+1HGur2vJUxZmpZPbqbm5s8C1CTFwHgciTPeNFTFTA@mail.gmail.com>
Subject: Re: clang-format and 'clang-format on' and 'clang-format off'
To:     Joe Perches <joe@perches.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        llvm-dev@lists.llvm.org, Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 1:26 AM Joe Perches <joe@perches.com> wrote:
>
> Not every project is going to use only the clang-format tool.

Why? The end goal would be to enforce all code to be running under the
same formatting rules (which, in practice, means the same tool at the
moment).

Note that you can use clang-format with most editors (including vim,
emacs, VS, VSCode, XCode, Sublime, Atom...).

Cheers,
Miguel
