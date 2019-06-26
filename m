Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D0656EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 18:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfFZQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 12:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZQdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:33:45 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CF721726
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561566824;
        bh=VqM1Y3gTzrdg9IyL0tgDwX6DERJtwPWI97Up1+edpKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hrab3llZQA7rYtcSu2sLm8drPuB7Z/lbl1+PkCn5j5tJNB4W/zOPfj4F+kqqWzBvm
         +xpkk6NaGw8docYuVsiXNsNsjB+qwsZ43Q+tufwGnECfrQI+T0P+Yq/yzKVGKTSphe
         ATGAtIarIfZaTSYi4R6jQTyR98Ts6z+aXONe9RGU=
Received: by mail-wr1-f49.google.com with SMTP id k11so3513563wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:33:44 -0700 (PDT)
X-Gm-Message-State: APjAAAXLsCIdNw+bqcVC2TMtAFhNQW5OhrYN8s+qDnN4BrZkxDXEDZdv
        ibSYYv3MMWuykg7yBDqzhqhTk515HIDWY6bZZZBcjQ==
X-Google-Smtp-Source: APXvYqw+qgujipoGaP6i2PgoAQF9ULqoNVvKDpM7QSPLzJ/sMyDeos3Zd2x3iIXmWBq8ZLx2cKnuVEdNrfBU5Whiv4k=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr4567621wro.343.1561566823198;
 Wed, 26 Jun 2019 09:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-6-namit@vmware.com>
 <86e04985-7884-3d33-c479-92614b4e4342@intel.com>
In-Reply-To: <86e04985-7884-3d33-c479-92614b4e4342@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Jun 2019 09:33:32 -0700
X-Gmail-Original-Message-ID: <CALCETrXbC=w5KyR8x-hD24DC0BzZ3MjHR1FUOoEXkBOPHPXwXQ@mail.gmail.com>
Message-ID: <CALCETrXbC=w5KyR8x-hD24DC0BzZ3MjHR1FUOoEXkBOPHPXwXQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/mm/tlb: Optimize local TLB flushes
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 2:36 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/12/19 11:48 PM, Nadav Amit wrote:
> > While the updated smp infrastructure is capable of running a function on
> > a single local core, it is not optimized for this case.
>
> OK, so flush_tlb_multi() is optimized for flushing local+remote at the
> same time and is also (near?) the most optimal way to flush remote-only.
>  But, it's not as optimized at doing local-only flushes.  But,
> flush_tlb_on_cpus() *is* optimized for local-only flushes.

Can we stick the optimization into flush_tlb_multi() in the interest
of keeping this stuff readable?

Also, would this series be easier to understand if there was a patch
to just remove the UV optimization before making other changes?

--Andy
