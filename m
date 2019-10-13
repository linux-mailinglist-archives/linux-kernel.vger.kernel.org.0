Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC944D5567
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfJMJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 05:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfJMJGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 05:06:32 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4573486663
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 09:06:31 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w10so7024947wrl.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 02:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VqGJ+hSukCwxrY9wctom7RVU8clkF/NcvjQS4FJ08d8=;
        b=kycMxKeGcjE4l4k64ANasUcrIcxxoOZye0PMSjmYp+mEL8smWvFiEsQrxBWhQFF3D3
         CgC3NiwESlPsRtK3iNuimKXm0q0KLG2oBk0iGTBGpKgtm1X+eUSSC6VH3fFibi6QtdLl
         sq6vTI42zisuMYcM2UyyQsL+Amg+A0Vf4oJSMj7T/Y1ySRfEyamnnO4qA3I28UrP0WAu
         femeSzPLd0DeJBboRYx61USIpe4hDk7rA9ZONcAIucAxbGx4BCKy+caB8Kl6rTLNtLcq
         TvLJTkxNYh7FUSYF5aPOu0tluXBKWu21p3su/3Ilk1m6qV5TU22z4dUDtV5KhR+Txtqk
         BtYg==
X-Gm-Message-State: APjAAAU0bAAXE90g4MemobFB0gwPzBPY5kdUi4aVe6jt0X/w9sm8Jjs9
        pXBxMGwpHZujdVrdntCILsy8mrHOy5jyyCbhrLSlZh3WTAnukoVSWMbsCD04A3Gih4TwenVY27P
        lZSDTRczqPivsEcXNwX+T7Iyh
X-Received: by 2002:a1c:a556:: with SMTP id o83mr11323965wme.0.1570957589791;
        Sun, 13 Oct 2019 02:06:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9H7YU924Gq8Q6Bdsu5/sBl5aGWk9k6285SStbrDxHGELMBwGpeswMbxzpq3J1tU1U+Tx6Gg==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr11323930wme.0.1570957589541;
        Sun, 13 Oct 2019 02:06:29 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.110])
        by smtp.gmail.com with ESMTPSA id z189sm25692604wmc.25.2019.10.13.02.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 02:06:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, peterz@infradead.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 2/5] x86/kvm: Change print code to use pr_*() format
In-Reply-To: <1570439071-9814-3-git-send-email-zhenzhong.duan@oracle.com>
References: <1570439071-9814-1-git-send-email-zhenzhong.duan@oracle.com> <1570439071-9814-3-git-send-email-zhenzhong.duan@oracle.com>
Date:   Sun, 13 Oct 2019 11:06:26 +0200
Message-ID: <87lftp5819.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> pr_*() is preferred than printk(KERN_* ...), after change all the print
> in arch/x86/kernel/kvm.c will have "kvm_guest: xxx" style.
>
> No functional change.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krcmar <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/kernel/kvm.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 3bc6a266..ef836d6 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -7,6 +7,8 @@
>   *   Authors: Anthony Liguori <aliguori@us.ibm.com>
>   */
>  
> +#define pr_fmt(fmt) "kvm_guest: " fmt
> +
>  #include <linux/context_tracking.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -286,8 +288,8 @@ static void kvm_register_steal_time(void)
>  		return;
>  
>  	wrmsrl(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
> -	pr_info("kvm-stealtime: cpu %d, msr %llx\n",
> -		cpu, (unsigned long long) slow_virt_to_phys(st));
> +	pr_info("stealtime: cpu %d, msr %llx\n", cpu,
> +		(unsigned long long) slow_virt_to_phys(st));
>  }
>  
>  static DEFINE_PER_CPU_DECRYPTED(unsigned long, kvm_apic_eoi) = KVM_PV_EOI_DISABLED;
> @@ -321,8 +323,7 @@ static void kvm_guest_cpu_init(void)
>  
>  		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
>  		__this_cpu_write(apf_reason.enabled, 1);
> -		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
> -		       smp_processor_id());
> +		pr_info("setup async PF for cpu %d\n", smp_processor_id());
>  	}
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI)) {
> @@ -347,8 +348,7 @@ static void kvm_pv_disable_apf(void)
>  	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
>  	__this_cpu_write(apf_reason.enabled, 0);
>  
> -	printk(KERN_INFO"Unregister pv shared memory for cpu %d\n",
> -	       smp_processor_id());
> +	pr_info("Unregister pv shared memory for cpu %d\n", smp_processor_id());
>  }
>  
>  static void kvm_pv_guest_cpu_reboot(void *unused)
> @@ -469,7 +469,8 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  		} else {
>  			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
>  				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, icr);
> -			WARN_ONCE(ret < 0, "KVM: failed to send PV IPI: %ld", ret);
> +			WARN_ONCE(ret < 0, "kvm_guest: failed to send PV IPI: %ld",
> +				  ret);
>  			min = max = apic_id;
>  			ipi_bitmap = 0;
>  		}
> @@ -479,7 +480,8 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  	if (ipi_bitmap) {
>  		ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
>  			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, icr);
> -		WARN_ONCE(ret < 0, "KVM: failed to send PV IPI: %ld", ret);
> +		WARN_ONCE(ret < 0, "kvm_guest: failed to send PV IPI: %ld",
> +			  ret);
>  	}
>  
>  	local_irq_restore(flags);
> @@ -509,7 +511,7 @@ static void kvm_setup_pv_ipi(void)
>  {
>  	apic->send_IPI_mask = kvm_send_ipi_mask;
>  	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> -	pr_info("KVM setup pv IPIs\n");
> +	pr_info("setup pv IPIs\n");

Not your fault but in WARN_ONCE() above we use 'PV' capitalized so I'd
suggest we converge on something: either capitalize them all or make
them all lowercase.

>  }
>  
>  static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
> @@ -631,11 +633,11 @@ static void __init kvm_guest_init(void)
>  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>  		smp_ops.send_call_func_ipi = kvm_smp_send_call_func_ipi;
> -		pr_info("KVM setup pv sched yield\n");
> +		pr_info("setup pv sched yield\n");

here

>  	}
>  	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/kvm:online",
>  				      kvm_cpu_online, kvm_cpu_down_prepare) < 0)
> -		pr_err("kvm_guest: Failed to install cpu hotplug callbacks\n");
> +		pr_err("failed to install cpu hotplug callbacks\n");
>  #else
>  	sev_map_percpu_data();
>  	kvm_guest_cpu_init();
> @@ -738,7 +740,7 @@ static __init int kvm_setup_pv_tlb_flush(void)
>  			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
>  				GFP_KERNEL, cpu_to_node(cpu));
>  		}
> -		pr_info("KVM setup pv remote TLB flush\n");
> +		pr_info("setup pv remote TLB flush\n");

and here too.

>  	}
>  
>  	return 0;
> @@ -866,8 +868,8 @@ static void kvm_enable_host_haltpoll(void *i)
>  void arch_haltpoll_enable(unsigned int cpu)
>  {
>  	if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL)) {
> -		pr_err_once("kvm: host does not support poll control\n");
> -		pr_err_once("kvm: host upgrade recommended\n");
> +		pr_err_once("host does not support poll control\n");
> +		pr_err_once("host upgrade recommended\n");
>  		return;
>  	}

Other than the above,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
