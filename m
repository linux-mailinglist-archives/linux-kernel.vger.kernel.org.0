Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04CB2917
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 02:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbfINA1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 20:27:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45127 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbfINA1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:27:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id x3so13932821plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 17:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5es07BvzqsMy7pziZwvTU1930QZZgB++nX0PDauOi1M=;
        b=PeuljHJ7nNghdeskilqAwYi19w2xaTohXkf5vS6WzH5RIsK/9TxcokHMYBjm1uFGC+
         Ahh1L+ipBBDTXrs0dCB4N9aAZYrJ/d7Q/YFmFW0FacB0AJ5kFZKXwUwXBri16Jym8JiY
         M9l1IODj4oWq6fuCgmwMVx4UD5cO8/yfzoQoLA1HVB0gBUEdm7dN5Q+YRdVXFGWBOUq5
         PgoARg9tvA33d2DLIb4LYXDNyKG3gPbKXZfGHq5/b7WUFm3wGc4QyrNwdfz377Wd97n7
         lBzixn0YeC0oJ72Z75nKWFPIG60lyL2k8M1+UpSqaAGk4bPLafeBJKkHPC3yVCRL146l
         BkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5es07BvzqsMy7pziZwvTU1930QZZgB++nX0PDauOi1M=;
        b=OCB5vzBMHc4QgEo9uf6YlIwpjlFT7kjyLSEdKMGgm/p8jjc/KlQkbCAMrwo9gkxUoc
         dW45Iyywqm2w0OuUoDh1u3pWNZ0M+6bzqsm1YYOXO06CYbcs57ZGRsY31UhhjSVmR5vK
         tol5WoZdNIei4hF7g0ylWV4O78P0VA14b86EEJKK+41FHNlpXoJoy11qsQZ/PfGoOUC1
         Ix8g6Pu7IhcMuBuP0sZD8KW9exBR6WAEQdQLkJdyr5C4YfF9FDURvtqhX3Bn6bPjJZCW
         +yeRXU/JxGbj/Cu3qkkA4wReIIu9m12WgegPlJFiB4WedYdFxLnPmoRWONz3kTDnybpw
         EWJA==
X-Gm-Message-State: APjAAAWFwuw625uymG0VVhNhg1Xwz44o9XCOPLunHoVbTiP3Dojy9gqt
        bpOhCjFJYKxB7kLauwND5gMlOA==
X-Google-Smtp-Source: APXvYqxh3jw6r9vd0ODdQz42q9KkjDeL8JM4/20v2erKuXKoXCyKoRNxs2WBqMxZL4o2XdDKCcUyQQ==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr53013544plo.279.1568420863279;
        Fri, 13 Sep 2019 17:27:43 -0700 (PDT)
Received: from ?IPv6:2600:1010:b020:48a9:95f9:675c:ced:7824? ([2600:1010:b020:48a9:95f9:675c:ced:7824])
        by smtp.gmail.com with ESMTPSA id s141sm43006659pfs.13.2019.09.13.17.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 17:27:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/4] x86: use the correct function type for sys_ni_syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <CABCJKud9ikdsfy9-bugbqKb-C7VXEEPJ_P1bO5KpGqv62Wuc7Q@mail.gmail.com>
Date:   Fri, 13 Sep 2019 17:27:40 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, will.deacon@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E76DD0A-7FB0-4BDB-A8B5-920265337ACB@amacapital.net>
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-4-samitolvanen@google.com> <CALCETrWquNJJ6yXdHA_F3h71hVrFjnpwmdH2NmGZyFu-V6Lnfg@mail.gmail.com> <CABCJKud9ikdsfy9-bugbqKb-C7VXEEPJ_P1bO5KpGqv62Wuc7Q@mail.gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2019, at 4:26 PM, Sami Tolvanen <samitolvanen@google.com> wrote=
:
>=20
>> On Fri, Sep 13, 2019 at 3:45 PM Andy Lutomirski <luto@kernel.org> wrote:
>> Should this be SYSCALL_DEFINE0?
>=20
> It can be, and that would also fix the issue. However, it does result
> in unnecessary error injection to be hooked up here, which is why
> arm64 preferred to avoid the macro when I fixed it there. S390 uses
> SYSCALL_DEFINE0 for this though and since sys_ni_syscall always
> returns -ENOSYS, it shouldn't be a huge problem. Thoughts?
>=20


I don=E2=80=99t see why all syscalls except these  few should have error inj=
ection hooked up.  It=E2=80=99s also IMO nicer from a maintenance perspectiv=
e to have all syscalls use the same macros.

Will, is there something I=E2=80=99m missing?=
