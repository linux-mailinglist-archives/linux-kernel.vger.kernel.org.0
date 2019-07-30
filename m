Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E57A384
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfG3JAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 05:00:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41358 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbfG3JAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:00:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so61644702wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OXM02iYz2IRdbVYTSZ1WZe77JTnwpAeIa8FaghuZo4c=;
        b=uQkRYZ7Mw7MlRKBbU1Mr/RICrq381Tzf4WG4qJS4s8UGCOZGKVKdk5MC4bXYNTc6Zy
         3eTIVV7BbpPfzqH3m+QzvPeq9wQ0gKm+JE6cTIqy4Ue1lkGjz8uWuDAmO0xieWICEADn
         aMTqcZlWV3vjg+Bs2jYhDqoKRYtqNaXSBuOmIdHgA6sKAZ8ur6zhxFlRbXjSLcUbSp+a
         A0tXMB8OVbM+PLNTxkR5hxFfIaxSFL2cwD8ceAGias03wBj4O/0dNWL40EdP3R3AxZH9
         fFzAjLxL93iQ/v9HhIybTIYYL+BlsuaKdnLBpLW9IpCxaRoY+nBhstHnhY9UbVBAYHED
         nU7g==
X-Gm-Message-State: APjAAAWAx/bbs6g2oehMeDh0YIlCVJRR9Mn6lkJD2LREe3dvPa/UtkBU
        K20ClT+38lgEn4yrxfdBbL4lSsBzNJU=
X-Google-Smtp-Source: APXvYqxVuoAVEo5L0whFkRYU53jDf4dvvaMxhfAYJm0ZVclfasplU5lwtvKcELxa3jmCorypxW7/kw==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr126870879wrn.31.1564477209192;
        Tue, 30 Jul 2019 02:00:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id y6sm56247471wrp.12.2019.07.30.02.00.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:00:08 -0700 (PDT)
Subject: Re: [RFC PATCH 11/16] RISC-V: KVM: Implement stage2 page table
 programming
To:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <20190729115544.17895-12-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ebde80e-e8a9-6b7b-52ea-656b9a9e5e5b@redhat.com>
Date:   Tue, 30 Jul 2019 11:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-12-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:57, Anup Patel wrote:
> This patch implements all required functions for programming
> the stage2 page table for each Guest/VM.
> 
> At high-level, the flow of stage2 related functions is similar
> from KVM ARM/ARM64 implementation but the stage2 page table
> format is quite different for KVM RISC-V.

FWIW I very much prefer KVM x86's recursive implementation of the MMU to
the hardcoding of pgd/pmd/pte.  I am not asking you to rewrite it, but
I'll mention it because I noticed that you do not support 48-bit guest
physical addresses.

Paolo
