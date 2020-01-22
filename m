Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB914590A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 10:51:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57084 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgAVPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579708304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Oh+HefrYBghvTz0gRuE0ctztS1fd6vHOChnV/W4YF0=;
        b=W/HuxZ+B+kG6Cm+yjt9J6i3rB7im6jF0OON7SQZ6w2ZQSypsxZNHppRjeGEllFoTKMWQEz
        icIwajjzqmREAZDkPNMewmoo7vgM27gf1QPrFoPNH6Ha08pIl8zLXAF7O56QbwYMPjRe1r
        0zyOdXqceM1aFDQ1zpzQrnlqEUaxLEk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Kzx_kZ8TOHuYpEGBGnB9rw-1; Wed, 22 Jan 2020 10:51:43 -0500
X-MC-Unique: Kzx_kZ8TOHuYpEGBGnB9rw-1
Received: by mail-wr1-f70.google.com with SMTP id u18so3245500wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 07:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Oh+HefrYBghvTz0gRuE0ctztS1fd6vHOChnV/W4YF0=;
        b=sS7vJ/55HaBY5ip1FGAysZ4iGKrwzx7CHoCeDHry7hMhHxpuAHxWxmftuAEXEK57zX
         GoO6He4B/Z0POZ3j36w3zPTLcrb6IWqxvCG6tzcMklTpLELyu2kos4M4jCFg/UnSTZm7
         VRQwldYT5ZKUZtyIJDXvr+QWcXfhFryY2/kq6eBPLTRA7eSSN1Q4XdLbdFkE213azzF8
         2fiC7ODWVblyK1AOxFTdOWZVBL/mN9YHLFjGcM/PPBtVeF3r/9xN/Fr7yF8u9e5BHpzn
         574V2sI7bmsN83aRSZltzm+PL4pcSuBxzpncgHgXCJQ5SFkR+szu8I2XbKBk/HF7osNS
         LyCA==
X-Gm-Message-State: APjAAAUm5uKtQwKGfpCK777kvkdo63gbJFMGcIdgPV5968n7ofm/Uz3C
        mYR4Aw1/G3UGkm//7qBmxkMfg0cZ8QfcrXnkALGnqtiRQWUfQPMHSnVuWWbJacH6SJOkclkE8wg
        rChwyiBws7aW/zYnxppC/hEYi
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr11438550wrs.424.1579708302153;
        Wed, 22 Jan 2020 07:51:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqA6lRooDUJzcEoLeIgVcxs3FkI8+hHgraQm2Lzb3LAPvygoLb1ZpEpKdyiont2219ajtlBQ==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr11438522wrs.424.1579708301921;
        Wed, 22 Jan 2020 07:51:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id f207sm5374746wme.9.2020.01.22.07.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 07:51:41 -0800 (PST)
Subject: Re: [PATCH v5 03/18] kvm: x86: Introduce APICv inhibit reason bits
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, joro@8bytes.org, vkuznets@redhat.com,
        rkagan@virtuozzo.com, graf@amazon.com, jschoenh@amazon.de,
        karahmed@amazon.de, rimasluk@amazon.com, jon.grimm@amd.com
References: <1573762520-80328-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1573762520-80328-4-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcfb997f-ab6c-d7c3-2856-22470ce62329@redhat.com>
Date:   Wed, 22 Jan 2020 16:51:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573762520-80328-4-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple slight improvements, after which get_enable_apicv is unused.

Paolo

On 14/11/19 21:15, Suravee Suthikulpanit wrote:
> @@ -6848,6 +6848,7 @@ static int vmx_vm_init(struct kvm *kvm)
>  			break;
>  		}
>  	}
> +	kvm_apicv_init(kvm, vmx_get_enable_apicv(kvm));
>  	return 0;
>  }
>  

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 01f60d6cd881..d011ffaec7ee 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6852,7 +6852,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			break;
 		}
 	}
-	kvm_apicv_init(kvm, vmx_get_enable_apicv(kvm));
+	kvm_apicv_init(kvm, enable_apicv);
 	return 0;
 }
 
> @@ -9347,10 +9364,11 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  		goto fail_free_pio_data;
>  
>  	if (irqchip_in_kernel(vcpu->kvm)) {
> -		vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu->kvm);
>  		r = kvm_create_lapic(vcpu, lapic_timer_advance_ns);
>  		if (r < 0)
>  			goto fail_mmu_destroy;
> +		if (kvm_apicv_activated(vcpu->kvm))
> +			vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu->kvm);
>  	} else
>  		static_key_slow_inc(&kvm_no_apic_vcpu);
>  
> 

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c62abb4fdd9..cc9f84527a55 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9236,7 +9236,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		if (r < 0)
 			goto fail_mmu_destroy;
 		if (kvm_apicv_activated(vcpu->kvm))
-			vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu->kvm);
+			vcpu->arch.apicv_active = true;
 	} else
 		static_key_slow_inc(&kvm_no_apic_vcpu);
 

