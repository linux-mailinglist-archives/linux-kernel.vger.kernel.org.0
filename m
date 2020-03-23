Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E818F9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 17:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCWQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 12:25:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30789 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgCWQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584980701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1Ry1yiWvSlF/GO2rvf8iBUf/GEmj9nn1/CSsWhpLSU=;
        b=bq+OpaVeHQwJK+1CzD1M4p788JtA7y4tp5XtbjAhXPbJn0JUCUqm0UARIrXVngvs455Bxm
        cbpsI9oFX2L0g2kasAZCSQ5ehYy5lfT4O0k4O+jTS7IM28Q+YLm/niaehywecAmK2vJ/mL
        YTmHLWjQxhkKnX0LPrwJ+pEbPMdfz3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-uH3J0wUhO0iur-GWCgOxuQ-1; Mon, 23 Mar 2020 12:25:00 -0400
X-MC-Unique: uH3J0wUhO0iur-GWCgOxuQ-1
Received: by mail-wm1-f72.google.com with SMTP id f207so22611wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X1Ry1yiWvSlF/GO2rvf8iBUf/GEmj9nn1/CSsWhpLSU=;
        b=m5qyvZTcWApIR1deJ+7G6Txmf2BnmWroBuI+U3rcC1K/uDDmjBwdMk1msQfQgeyHCD
         Nv9KCq+E6jrFgEDVmESH7ea0ySEFGw6+PzxmuwIvBUJKRGzzAxax2D0xDqllEQncfC74
         0Eu2eVjPcORXpLPJvy0o+NJqFaSUFQrjywAMH109llIqTgvI8p6X3FLz4Q/vUcAeueM/
         yqxzwfdKRx7GTaF0ltBjMaNEUlbSR99eklqLoTONagKWcZ9pIAcx6psn7wG6yrR7UhIR
         QkrtEa25JRoqpbe4dgkhMr+sf8N65UchrJ2xAwJ+igaduIalG4NvnTHGNKEkEOYU6hj/
         rlKA==
X-Gm-Message-State: ANhLgQ2XvkCIRi+X80dxdL/4tUTGACTN4VrkIwlaOEPT0fkTdSgj+Olt
        nF/9ZFPBW2xjzLnBtqWoDsrLkguFYWG9uKiQp+tJt9x3zozK2jsdlZPXmOs44mXregmV/nVN61S
        WnjwIF4tmfw5AYWDam/V6hnb/
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr75059wmd.94.1584980698694;
        Mon, 23 Mar 2020 09:24:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsn477+cxrvpcfJzZ9WXWmF0SKMmbIayFwHATIum/A7SWzS2LgH2WXH6U684IfdISlyncs+7g==
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr75027wmd.94.1584980698414;
        Mon, 23 Mar 2020 09:24:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p10sm19419160wrm.6.2020.03.23.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:24:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] KVM: x86: Move init-only kvm_x86_ops to separate struct
In-Reply-To: <20200323152909.GE28711@linux.intel.com>
References: <20200321202603.19355-1-sean.j.christopherson@intel.com> <20200321202603.19355-3-sean.j.christopherson@intel.com> <87lfnr9sqn.fsf@vitty.brq.redhat.com> <20200323152909.GE28711@linux.intel.com>
Date:   Mon, 23 Mar 2020 17:24:56 +0100
Message-ID: <87o8sn82ef.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Mar 23, 2020 at 01:10:40PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > +
>> > +	.runtime_ops = &svm_x86_ops,
>> > +};
>> 
>> Unrelated to your patch but I think we can make the naming of some of
>> these functions more consistend on SVM/VMX, in particular I'd suggest 
>> 
>> has_svm() -> cpu_has_svm_support()
>> is_disabled -> svm_disabled_by_bios()
>> ...
>> (see below for VMX)
>> 
>> > +
>> >  static int __init svm_init(void)
>> >  {
>> > -	return kvm_init(&svm_x86_ops, sizeof(struct vcpu_svm),
>> > +	return kvm_init(&svm_init_ops, sizeof(struct vcpu_svm),
>> >  			__alignof__(struct vcpu_svm), THIS_MODULE);
>> >  }
>> >  
>> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> > index 07299a957d4a..ffcdcc86f5b7 100644
>> > --- a/arch/x86/kvm/vmx/vmx.c
>> > +++ b/arch/x86/kvm/vmx/vmx.c
>> > @@ -7842,11 +7842,8 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
>> >  }
>> >  
>> >  static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>> > -	.cpu_has_kvm_support = cpu_has_kvm_support,
>> > -	.disabled_by_bios = vmx_disabled_by_bios,
>> > -	.hardware_setup = hardware_setup,
>> >  	.hardware_unsetup = hardware_unsetup,
>> > -	.check_processor_compatibility = vmx_check_processor_compat,
>> > +
>> >  	.hardware_enable = hardware_enable,
>> >  	.hardware_disable = hardware_disable,
>> >  	.cpu_has_accelerated_tpr = report_flexpriority,
>> > @@ -7981,6 +7978,15 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>> >  	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
>> >  };
>> >  
>> > +static struct kvm_x86_init_ops vmx_init_ops __initdata = {
>> > +	.cpu_has_kvm_support = cpu_has_kvm_support,
>> > +	.disabled_by_bios = vmx_disabled_by_bios,
>> > +	.check_processor_compatibility = vmx_check_processor_compat,
>> > +	.hardware_setup = hardware_setup,
>> 
>> cpu_has_kvm_support() -> cpu_has_vmx_support()
>> hardware_setup() -> vmx_hardware_setup()
>
> Preaching to the choir on this one.  The VMX functions without prefixes in
> in particular annoy me to no end, e.g. hardware_setup().  Though the worst
> is probably ".vcpu_create = vmx_create_vcpu", if I had a nickel for every
> time I've tried to find vmx_vcpu_create()...
>
> What if we added a macro to auto-generate the common/required hooks?  E.g.:
>
>   static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
> 	MANDATORY_KVM_X86_OPS(vmx),
>
> 	.pmu_ops = &intel_pmu_ops,
>
> 	...
>   };
>
> That'd enforce consistent naming, and would provide a bit of documentation
> as to which hooks are optional, e.g. many of the nested hooks, and which
> must be defined for KVM to function.

Sounds cool! (not sure that with only two implementations people won't
call it 'over-engineered' but cool). My personal wish would just be that
function names in function implementations are not auto-generated so
e.g. a simple 'git grep vmx_hardware_setup' works but the way how we
fill vmx_x86_ops in can be macroed I guess.

-- 
Vitaly

