Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4578FEFD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 13:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfKEMeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 07:34:02 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40416 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbfKEMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:02 -0500
Received: by mail-yb1-f196.google.com with SMTP id y18so2265691ybs.7;
        Tue, 05 Nov 2019 04:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJGMDXro90WxA6y75/ENgcmXBbk3M6LGVcBnPKmTHfs=;
        b=g5BGdVmNTrkzI0Ll0TJbEeoH+V0yr1EtP6O7bbbhhmn4CRXJ9YGHZF011pkaH2VYHE
         lmK2vzJuCCYWcKytTH/mfW/Q4Jir477njTkLEnmnYyEVUcNaZWmZ8ZQe6LjDKL91P0pD
         AZb4s2M8W3waSFn3O9YsYtcJzBNVMYIe39XpOFOQSgDaEFCcs7in5t5LpnQ+NEzkMluO
         juQR74d338mKvzpdfbyCuyksd3CdAb95evGgBRgTOP1CquQvI7lOuO0ovZsxJFtQaeve
         L4HKGRzi7dG32wh7avrW+6XWd2qcFOLKK2YefI4clCpTjXWW5V9EQTNBUBVVRB1JhVSD
         fhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJGMDXro90WxA6y75/ENgcmXBbk3M6LGVcBnPKmTHfs=;
        b=qTLSHRwaiFqjJYK8DWmqqJdj+VMroFZJ9Y1ylK6k3EijZayD/NPoH1zXyjwYp7DRfh
         2D0HX1G6Tx8UMfy/a6hysknuka/CYTSJMuq0g5hkcR/GYps3NS+EBMn8z7bCYwX75Vt7
         BRKW5Mm3cjMSOawaFHRkePTt3qLVtWp+RPeaQeQcW4rqSWbCOrc28zqHdgo1jukBMBm6
         qWHS8jQBG6EXd6YrkCKBTxkcYqh2pcY/ZYC5Tpqj1JpU1zznroF3YX+PIW7WZC2n3V6x
         VuftrHa6ASmk+ecvwmIKIev1bEdud4g1vdXMcPbbOHXVP1craXaqerQ/Ey9EKSN7IbAU
         iL6w==
X-Gm-Message-State: APjAAAXT9omYViFFHiLBytnb9wBbK/0oTg1cgOY7WBVbjkXcpJORgTBl
        2LhrayQK4QV0mpOuhq8gaf9WNDKNhUrUkh/42lw=
X-Google-Smtp-Source: APXvYqx/fjN4mLhQZ6e2bs5Kbn0i26opeFytqR0Z0sJCNMdboxypD1+Wssl8GAbbAVmCw3SGpYZA/ifzVIVmq7pQeJU=
X-Received: by 2002:a25:e909:: with SMTP id n9mr27325262ybd.428.1572957239291;
 Tue, 05 Nov 2019 04:33:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
 <20191105115431.GD26580@mbp>
In-Reply-To: <20191105115431.GD26580@mbp>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Nov 2019 14:33:48 +0200
Message-ID: <CAOQ4uxjm=tWsQpfLkY9O_3qWK86X=kCD19P8zJAQjs5ms_RfZw@mail.gmail.com>
Subject: Re: 5.4-rc1 boot regression with kmemleak enabled
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Theodore Tso <tytso@mit.edu>, fstests <fstests@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 1:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> (sorry if you got this message twice; our SMTP server went bust)
>
> On Tue, Nov 05, 2019 at 09:14:06AM +0200, Amir Goldstein wrote:
> > My kvm-xfstests [1] VM doesn't boot with kmemleak enabled since commit
> > c5665868183f ("mm: kmemleak: use the memory pool for early allocations").
> >
> > There is no console output when running:
> >
> > $ kvm -boot order=c -net none -machine type=pc,accel=kvm:tcg -cpu host \
> >     -drive file=$ROOTFS,if=virtio,snapshot=on -vga none -nographic \
> >     -smp 2 -m 2048 -serial mon:stdio --kernel $KERNEL \
> >     --append 'root=/dev/vda console=ttyS0,115200'
>
> This was fixed in 5.4-rc4, see commit 2abd839aa7e6 ("kmemleak: Do not
> corrupt the object_list during clean-up").
>

Did not fix my issue.
Still not booting with 5.4-rc6.
Any other suggestions?

Thanks,
Amir.
