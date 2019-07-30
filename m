Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5287A6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfG3LRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 07:17:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35359 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfG3LRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:17:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so56254379wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvgPUBGV/7rlprGq2UKvQw64RD69l3r+T5crm34cB+M=;
        b=XlgpwRHygvjKo95MsbMiQAA+tU6jlqt6UP2kUYKTFuiTDRqVgELxVFHw1h9XcMSZlI
         T0Kc/OpUBYS90DU9EvlPgzL0P/ERvrrAHIJwrBsuDrNaGjQXV5HZT6GvyEipk6d4f6r0
         /QYdVy9S2xXXop/v5y9+wuc1P2ip3IbRRBGJSLUfR7YssxkAFKRIEKxxgRX/nY4GEHt7
         ZR9YihqPq9TdYyoDz4sBG/kjYgFN/293cu5SJlJWJavxJEMMsOBdEWrxnZnYPIUub9EQ
         vtGjPBnwh6gTIMkXI4Li/Ddwk3Dt05mGELXu5EfL68NMyn1t1LzX6q/G4wfDaAKgduhr
         wJEw==
X-Gm-Message-State: APjAAAXI9uMZnSGgeqyTiylARFuMQlhF92V6tZAsr8VliwiHzm/VaqJS
        wilDREqCJqHnVWZ54oToctKttEDNvf0=
X-Google-Smtp-Source: APXvYqw1KI7sUmp8Sdn4ayOXJmdRYtU432fiBUYC6ad6hlnK6fthEw1AC7gy+vYWxxfF/ync6NcJCA==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr2101800wme.99.1564485449180;
        Tue, 30 Jul 2019 04:17:29 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b203sm78741169wmd.41.2019.07.30.04.17.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:17:28 -0700 (PDT)
Subject: Re: [RFC PATCH 05/16] RISC-V: KVM: Implement VCPU interrupts and
 requests handling
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
 <20190729115544.17895-6-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f9d09e5-49bc-f8e3-cfe1-bd5221e3b683@redhat.com>
Date:   Tue, 30 Jul 2019 13:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-6-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, something that is not clear to me: how do you deal with a guest
writing 1 to VSIP.SSIP?  I think that could lead to lost interrupts if
you have the following sequence

1) guest writes 1 to VSIP.SSIP

2) guest leaves VS-mode

3) host syncs VSIP

4) user mode triggers interrupt

5) host reenters guest

6) host moves irqs_pending to VSIP and clears VSIP.SSIP in the process

Perhaps irqs_pending needs to be split in two fields, irqs_pending and
irqs_pending_mask, and then you can do this:

/*
 * irqs_pending and irqs_pending_mask have multiple-producer/single-
 * consumer semantics; therefore bits can be set in the mask without
 * a lock, but clearing the bits requires vcpu_lock.  Furthermore,
 * consumers should never write to irqs_pending, and should not
 * use bits of irqs_pending that weren't 1 in the mask.
 */

int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
{
	...
	set_bit(irq, &vcpu->arch.irqs_pending);
	smp_mb__before_atomic();
	set_bit(irq, &vcpu->arch.irqs_pending_mask);
	kvm_vcpu_kick(vcpu);
}

int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
{
	...
	clear_bit(irq, &vcpu->arch.irqs_pending);
	smp_mb__before_atomic();
	set_bit(irq, &vcpu->arch.irqs_pending_mask);
}

static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
{
	...
	WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
}

and kvm_riscv_vcpu_flush_interrupts can leave aside VSIP bits that
aren't in vcpu->arch.irqs_pending_mask:

	if (atomic_read(&vcpu->arch.irqs_pending_mask)) {
		u32 mask, val;

		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask, 0);
		val = READ_ONCE(vcpu->arch.irqs_pending) & mask;

		vcpu->arch.guest_csr.vsip &= ~mask;
		vcpu->arch.guest_csr.vsip |= val;
		csr_write(CSR_VSIP, vsip);
	}

Also, the getter of CSR_VSIP should call
kvm_riscv_vcpu_flush_interrupts, while the setter should clear
irqs_pending_mask.

On 29/07/19 13:56, Anup Patel wrote:
> +	kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
> +	kvm_vcpu_kick(vcpu);

The request is not needed as long as kvm_riscv_vcpu_flush_interrupts is
called *after* smp_store_mb(vcpu->mode, IN_GUEST_MODE) in
kvm_arch_vcpu_ioctl_run.  This is the "request-less vCPU kick" pattern
in Documentation/virtual/kvm/vcpu-requests.rst.  The smp_store_mb then
orders the write of IN_GUEST_MODE before the read of irqs_pending (or
irqs_pending_mask in my proposal above); in the producers, there is a
dual memory barrier in kvm_vcpu_exiting_guest_mode(), ordering the write
of irqs_pending(_mask) before the read of vcpu->mode.

Similar to other VS* CSRs, I'd rather have a ONE_REG interface for VSIE
and VSIP from the beginning as well.  Note that the VSIP setter would
clear irqs_pending_mask, while the getter would call
kvm_riscv_vcpu_flush_interrupts before reading.  It's up to userspace to
ensure that no interrupt injections happen between the calls to the
getter and the setter.

Paolo

> +		csr_write(CSR_VSIP, vcpu->arch.irqs_pending);
> +		vcpu->arch.guest_csr.vsip = vcpu->arch.irqs_pending;
> +	}

