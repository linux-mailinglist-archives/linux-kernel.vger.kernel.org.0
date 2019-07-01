Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043901ACA8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfELOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 10:34:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35938 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfELOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 10:34:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so5392404pgb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rj1xYp3bdbLmB5I4rmF5eddBCdDybeCIweQdtWz6Qds=;
        b=uBjJnZYujXqLDjdsyGju48YBheW3/jE8xCPZQJjpgJd9RZWkns4nx6DTpkmfTtRT1k
         ei249ShnwoxPskGiuNU2YeD9/BPNrZPrtoYO8ZyHf0ot27+I+0f1WBbkzVZZpEeLt/kW
         jMSMhpzEhHai35mqb0aIYC/YGM/oqvuYZs9wYq3ePwDMbwoZmFU3rxbRBhaDIDN1S6R1
         a/KqZ5WR+U0qpaUapt170v2T+DDaFp0TqrA+OPkRdWL9hxxezVgcp5Cs0gSS7DpwKd7t
         sqfCFn5Ds12xQx0WBUYk9RVzc2LzeATQ4N9jnrzRwoWXYd1UOcCnKnfe74JIJjmISotF
         tvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rj1xYp3bdbLmB5I4rmF5eddBCdDybeCIweQdtWz6Qds=;
        b=hjcO5+0SrQPOk6AKJe+FjPwvA6PPXoLCQd9kyjCVS09E3r7N8xhpCwPESBbZUO0Hue
         kwUdoI1XuT3ca4Avs3cstE8F8p3R+vbJ/lLQxmzMLmTxeF7RPfP5JMQqmbr/U45yoI8I
         rL2n3lRzED/kJ+KqX8fpk5yhpmAjG7BMXRL14oSH/t+xT/vwdBR/XzCZJ0K75VowLOO3
         n/2vnSuXVNysPuag3bp/QmC5wJ5/OPwX1vpIy5d3PLQ9AePe4X4iVuykTf1/WPO77cTW
         OFHpPlonzcYf7SCdInQ4d/g+J0bMNqpk22SuwrJokqNKgXP9JPeYhqAsAlQ2bkhOTb3e
         BjYA==
X-Gm-Message-State: APjAAAV9QULPHiu2diHruff7XhA7hzeskMJC1umINb5OnYU/H2v8g5wL
        2IITqyp0xDpuN2aUNPguV1fgeg==
X-Google-Smtp-Source: APXvYqxtlm8OaNR9+qSGiL3A5V/7CCZj49vprk8OtBfg/XFvVYf4ruk29Ug1AqpNP0BNvhXhL8FQyQ==
X-Received: by 2002:a62:3892:: with SMTP id f140mr27329042pfa.128.1557671668210;
        Sun, 12 May 2019 07:34:28 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1112:65f7:3af0:f60d? ([2601:646:c200:1ef2:1112:65f7:3af0:f60d])
        by smtp.gmail.com with ESMTPSA id k10sm11400208pgo.82.2019.05.12.07.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 07:34:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190512133549.ymx5yg5rdqvavzyq@yavin>
Date:   Sun, 12 May 2019 07:34:26 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ED963D0-4C31-45B1-B361-E4A75DFBF7C1@amacapital.net>
References: <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com> <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com> <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net> <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com> <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com> <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com> <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net> <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com> <20190512133549.ymx5yg5rdqvavzyq@yavin>
To:     Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 12, 2019, at 6:35 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
>> On 2019-05-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>> I bet this will break something that already exists. An execveat()
>>> flag to turn off /proc/self/exe would do the trick, though.
>>=20
>> Thinking more about it, I suspect it is (once again) wrong to let the
>> thing that does the execve() control that bit.
>>=20
>> Generally, the less we allow people to affect the lifetime and
>> environment of a suid executable, the better off we are.
>>=20
>> But maybe we could limit /proc/*/exe to at least not honor suid'ness
>> of the target? Or does chrome/runc depend on that too?
>=20
> Speaking on the runc side, we don't depend on this. It's possible
> someone depends on this for fexecve(3) -- but as mentioned before in
> newer kernels glibc uses execve(AT_EMPTY_PATH).

Why are we concerned about suid?  Don=E2=80=99t we already block suid if the=
 path being execed doesn=E2=80=99t come from the current mountns?  That shou=
ld mostly cover the things we care about, no?

I suppose we could also block suid for deleted files, so that deleting a kno=
wn-buggy suid binary becomes more reliable. But every sensible package tool s=
hould already be chmoding the suid away before unlinking.=
