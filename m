Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2810DAB9F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393716AbfIFNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 09:55:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34336 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393701AbfIFNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:55:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so3565381pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGrgHLmTZM3PM2l0Ts23dBPdy3ALk/x2NZy1I9A04dg=;
        b=QtD3nkmCeb2RsfD+3LyHKbHhgVgUoh6hdmKB5jg0UCWf067bT4Aw3MMoRr2YNYZq3e
         tLtBvIcaUgMtnuanAnbghaCCmdEDN9uggDvPbipIICZxrTsH9nXyTF2u7BA1s3vNXQVc
         ENyQO7dvr1ejkU0Z/QKfoI80gDsJPDa+eLxNPz4JHX/xzBJCQWaiSCBws+Rnq1AKN1/3
         z+RWbUH5LdaJFfihSnoYpHC+Z4X6BQup0IoEeGVcqVOUnQOEPMQt5ZBwIQxWv6+j7w8f
         6gvRCFCrjqb/6XGMGv2knFSiHyA4Meufj3E5UCFJa3YhPX/RI0+ZlELTTwebzN6OPJ57
         UpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGrgHLmTZM3PM2l0Ts23dBPdy3ALk/x2NZy1I9A04dg=;
        b=g4RKVZuT5hDTUX6dJ7EHjUTReSjoBpMtiInZ2DUPvT/HZ2QOakUpPlEOhHpzJ7KW7N
         O0J4bZQQgqWq36QVdoc0uOYVOGecMCgbs+jV8Re896/nNdgJp+0vQrAGkHisPpjBovHJ
         KYeIPA0V2B/LhKyPK5anh1yulRuhSgaVB1p8Dd/KT374Lix/mECGSxrJMslrynwciBxW
         VxidDEjkMLYIuECOQRJ9v7zcRSEpuKHjwkG8gu7VVHxxYo5RmVmkm09UxdDdrX5DZo8M
         Go+2yzoJRiGynbJrmqn6yat3CRpak1ST+y1ltFO+9XHlnJN/J4A5tXjYfojtiD4W9tnw
         z5aQ==
X-Gm-Message-State: APjAAAW27SIaKq0H1gDVd6AeRpDpqg8ORkoNDrhHG79YoC+yX8IK3HJ6
        C4e+Vy+qR0k4Nuo2PmEuuQIYoly/htw5TOHYTM7C9KYnBSAK0Q==
X-Google-Smtp-Source: APXvYqxu5mPai3FTuY6dqBaDeUimrPXqNkeU1cOQKCkXjsUhoXkRD9aHM0I81dhiBmWxbt7Cra6QV/wSHBvajSi5pqw=
X-Received: by 2002:a63:c442:: with SMTP id m2mr8218161pgg.286.1567778133668;
 Fri, 06 Sep 2019 06:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <c28135c82eaf6d6e2c7e02c1ebc2b99a607d8116.1567615235.git.andreyknvl@google.com>
 <20190906135151.d74nq3qzjmhe4mb5@willie-the-truck>
In-Reply-To: <20190906135151.d74nq3qzjmhe4mb5@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 6 Sep 2019 15:55:22 +0200
Message-ID: <CAAeHK+zDZo6oaSDnJfiD_S1WYqAT13yEFP7hbehZ62C-BBp3rQ@mail.gmail.com>
Subject: Re: [PATCH ARM64] selftests, arm64: add kernel headers path for tags_test
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:51 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 04, 2019 at 06:41:00PM +0200, Andrey Konovalov wrote:
> > tags_test.c relies on PR_SET_TAGGED_ADDR_CTRL/PR_TAGGED_ADDR_ENABLE being
> > present in system headers. When this is not the case the build of this
> > test fails with undeclared identifier errors.
> >
> > Fix by providing the path to the KSFT installed kernel headers in CFLAGS.
> >
> > Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> > Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  tools/testing/selftests/arm64/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
>
> Damn, I just tagged the arm64 queue for 5.4 and didn't spot this patch.
>
> I'll queue it at -rc1 instead, if that's ok? It doesn't look urgent.

Sorry, I guess I should have pinged you directly.

I think it should be fine to leave it for rc1. It might cause a build
error in some kernel CI systems if they run kselftests though.
