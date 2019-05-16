Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382C91FE27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 05:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEPD3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 23:29:48 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42420 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEPD3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:29:47 -0400
Received: by mail-vk1-f196.google.com with SMTP id u131so620980vke.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=M0gjbwnx5fbOdE5IIPZtX+7pe8myER98gW6UQG7Z08c=;
        b=c0mvPTnmFRt8pwPLF59cLXLZ2XsjQWvhy26/cmn+n47w70i1pkD2Z1LdAw5uQW4hnD
         O32W1syUa3+d+8x/AjY2WW4dcB/wH43F2k469z6Jgtoi8gLwYQVmjlEfzLRIzuaxdrfm
         Q3AvmM484lkGUgG1klaxIgX92xWuAbThMms+FgK0N/TjSdwaw7ump6UD8dQSryrCzXUV
         RQw6xR22+aIj5Ds0r7AuFEKIkulmP3Emquz9+2DDcHbK0f/9gc6FvizbDKwMSvVkylEI
         xYwthPzCrsyFSAn1L/uc9SzPBGvIUGit12aweAj4uT3T7gimwbcAqsGR7Ol54mrDTKOE
         j4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=M0gjbwnx5fbOdE5IIPZtX+7pe8myER98gW6UQG7Z08c=;
        b=p98GaQ6Bk4R+J1fmw6T0yc4/M4+QM7d2mLwJTZYvjI9FI3GdI23Lb+e1n0qlbxSxMa
         vgvyePgc5ci3PKjiU0zZNGBcDfkT/1BuKSmbIjOkFaIX4mFhhURnX6fX9PFS1WoP8FKM
         IqvvmG+epa609E2FJZHvPBWKdYVzZ4PBZ6qQsaj5Te0t2ajRlgkmq/ldPRxNi7aYyIzh
         XFOmzBz1pgnQRZKgpdvrD66ZL0zn/Op74OMjrZNL2FS9iS3gV3XZXPjrgU3AmBND0kJt
         xGEo3WG6T6AXGurRv4cqqHiqFTpsurbTROW1hTSNvfdSulncfXxdi7Qz8G08Qv51N1Pd
         U77A==
X-Gm-Message-State: APjAAAX2csyGbnh/4ZckQ201XzEn8xfGNNpt1HtWgfpc3ropdygc5r2l
        AalJ0Oh8n6QS5dT5gxCBsCUZvIUXPi8kMNgD/MU=
X-Google-Smtp-Source: APXvYqzHTzQ0uQT+CuCikxFbQOFKPOyYn+ZBp4N412+zqsajy8Adyu//9Ux3FB29Y67zwggvGC8nines+9sQmh9xfc8=
X-Received: by 2002:a1f:d6c3:: with SMTP id n186mr21499586vkg.46.1557977386507;
 Wed, 15 May 2019 20:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <1557927822-21111-1-git-send-email-arunks@codeaurora.org> <20190515134902.GI24357@fuggles.cambridge.arm.com>
In-Reply-To: <20190515134902.GI24357@fuggles.cambridge.arm.com>
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Thu, 16 May 2019 08:59:35 +0530
X-Google-Sender-Auth: Jhj8jzl7NQ5YCn7WCpPYESwNezk
Message-ID: <CAKZGPAMWDbfckAxp5BJVvr+K1k7h2aoVBp_TaW0tuyDfiopnsw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: Fix size of __early_cpu_boot_status
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arun KS <arunks@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        James Morse <james.morse@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 7:20 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, May 15, 2019 at 07:13:19PM +0530, Arun KS wrote:
> > __early_cpu_boot_status is of type int. Fix up the calls to
> > update_early_cpu_boot_status, to use a w register.
> >
> > Signed-off-by: Arun KS <arunks@codeaurora.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/arm64/include/asm/smp.h | 2 +-
> >  arch/arm64/kernel/head.S     | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Your original patch is now in mainline:
>
> https://git.kernel.org/linus/61cf61d81e32
>
> Is this still needed?
Thanks for pointing that out. We can ignore this patch.

Regards,
Arun
>
> Will
