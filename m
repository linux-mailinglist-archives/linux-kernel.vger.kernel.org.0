Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE414D4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 02:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgA3BKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 20:10:09 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34640 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgA3BKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 20:10:08 -0500
Received: by mail-il1-f195.google.com with SMTP id l4so1657201ilj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 17:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIJpdZf8sX5VGl+nHmaWeHVqzqy84GuWYzpeHSNvIXI=;
        b=hU3t0iZGT8HwRfOP4zVuOtz3kV3jIt0WgWHzgIDdGnlNgCp2nYKcn+PWAwp0+7+h83
         k6hawullwibiw+XqN8pcm0jM9t2ArylW9tcCDveOXk1XlqbZNNWlEbjmFQ5HZTnSe7Oj
         paRNmprpKbjxC7/90mZKVcKjuottHjnImoHu/Jjn88XL4aWriRPZ7Ia98oMNt2Q9mpow
         dxm2faq1/WbfnRi/a1JWHBBFg8RHhuLIZpNs2M7fXpjCciWplsUDV4jftN7WKi3VGreR
         XVruQn4izyIRR/eFIBzf2aldBBRjtZSLOIeDs2rD/9PDkgN1EyMgmGUq1RbcAgz9stut
         uF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIJpdZf8sX5VGl+nHmaWeHVqzqy84GuWYzpeHSNvIXI=;
        b=TdmjlzX5TaP/AlbAN8x3wTcFO68z1RMZ2ebfxvXZowlpRpxEV3V1xMVFk4BtETWDjU
         lSOYOdgQsyZIZJhnFXUjnyaVC++P8cvYp1fHTVCnIWJawSnhvlBYk8mFHN1gHdg08l9K
         qD8DfCpFs8HAygDk6vum3hjMM4wWfqkRLFLcAYu6WjF0WzYu0jtzdKRGvMZZahZ23scs
         toALvnS5/+MitEIzEob81MIziGUefxBI8efofjhvdSh5c7+DqMmmIs7abOK6HI5ADm5G
         nYhwzs+GUDGuxVUvlsU2gVGaNRkipn81VjDgbHyp7nwitG0RU25gQLjZiYqB15nMG8PU
         1DTA==
X-Gm-Message-State: APjAAAVHetwjGGKfNWBEF1Kq9H0A3QdwguYnzBqhUSRhVjQs3J/fezhn
        47EDvbGS1++3j+RAXPJvgYs1+K4YOgH77QukpJihbMhQ
X-Google-Smtp-Source: APXvYqxeC2m+iJmgHRACDG+z4g1eKAVmZhd7mzp1zuHnIt8LZ9jcHC+HxeAx2fW8ozb59EBiY9KxDpxdcJvvmiuP1a8=
X-Received: by 2002:a92:8c9c:: with SMTP id s28mr1981527ill.248.1580346607859;
 Wed, 29 Jan 2020 17:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20200127212256.194310-1-ehankland@google.com> <2a394c6d-c453-6559-bf33-f654af7922bd@redhat.com>
In-Reply-To: <2a394c6d-c453-6559-bf33-f654af7922bd@redhat.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Wed, 29 Jan 2020 17:09:56 -0800
Message-ID: <CAOyeoRVaV3Dh=M4ioiT3DU+p5ZnQGRcy9_PssJZ=a36MhL-xHQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry - I forgot to switch to plain text mode on my first reply.

> I think this best written as it was before commit 2924b52117:
>
>                         if (!msr_info->host_initiated)
>                                 data = (s64)(s32)data;
>                         pmc->counter += data - pmc_read_counter(pmc);
Sounds good to me.

> Do you have a testcase?
I added a testcase to kvm-unit-tests/x86/pmu.c that fails without this
patch and passes with it.
Should I send out that patch now?
