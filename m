Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2083B7A35A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfG3Isl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 04:48:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50336 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfG3Isl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:48:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so56332195wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wubL2/vgzPA1pd7g/Ft25BpXcTqsyo1e/4gw/momGtU=;
        b=QNSz0aojMPG/1QtkhZtvyLVaOttoKQe4O9vCNWYayU0EpJrw8WbWPtO5nRZ/5wvf4X
         zonppnk6qv7rE6CfiGuJQu6NU4cvqjKE5KQRqNn9EzkDEsjvmHajt3h4vCTwSBNNWSVo
         hHMTjtfeOol5VIyvEduXgdXeSF4aVxRAUVNtyjKTzO7h1mV1w2WwzGG+5tQqz77DTgCO
         qVH+OIwofI0j+pQJCZUFnsySf/hRXCKL4jTEiQ5/ogRwZ89xeab/p+H2lGwHkmfFsl+S
         h2/DksohNjyDwRR5jt3ta1+fhe1QVuw3rkyQ9iZWTy/U1hSbbjDD0qhcdTeIUGidM0GV
         MUUw==
X-Gm-Message-State: APjAAAUsquhY5Pwga3MrX/jJ2ZRLfDoQ9bpOJ0TRvMqZ8M4L8iOG1rx5
        PG8j8l1jL728HkmxwgO4uKRAjkRKKfw=
X-Google-Smtp-Source: APXvYqyiUPbNE/jZJSqWwOHETlXCAehk9SFPzETDwVZDm9bd+5/kuQgX8raiwe8ulQU1S0IqxtSatA==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr74366958wmh.141.1564476518833;
        Tue, 30 Jul 2019 01:48:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id f3sm46989185wrt.56.2019.07.30.01.48.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:48:38 -0700 (PDT)
Subject: Re: [RFC PATCH 04/16] RISC-V: KVM: Implement VCPU create, init and
 destroy functions
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
 <20190729115544.17895-5-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ade614ae-fcfe-35f2-0519-1df71d035bcd@redhat.com>
Date:   Tue, 30 Jul 2019 10:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-5-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:56, Anup Patel wrote:
> +	cntx->hstatus |= HSTATUS_SP2V;
> +	cntx->hstatus |= HSTATUS_SP2P;

IIUC, cntx->hstatus's SP2P bit contains the guest's sstatus.SPP bit?  I
suggest adding a comment here, and again providing a ONE_REG interface
to sstatus so that the ABI is final before RISC-V KVM is merged.

What happens if the guest executes SRET?  Is that EXC_SYSCALL in hedeleg?

(BTW the name of SP2V and SP2P is horrible, I think HPV/HPP or HSPV/HSPP
would have been clearer, but that's not your fault).

Paolo

> +	cntx->hstatus |= HSTATUS_SPV;

