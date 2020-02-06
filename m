Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0814154707
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 16:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgBFPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 10:06:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727389AbgBFPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581001563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+K+K1lzfnMrsdr5Lps83cVjNAUCj3VKAmVhjs/GwTg=;
        b=RO5xJlSgrTsaCt+mT7Msk+6QC/HBBTLY+ikFr2XsyK+lrj10oxLUVXQCkewxdeJ+ba7fTw
        Wz44UsfAPrNZmo6XONlK7yYW1O1gOHVvunLEDMpDJnj79BmrxHg7YC5oa3yJQWPS3a/nF1
        odFflVE6OWeajuyopsyW5ILjLyJUZ80=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Xt-gx1DbOwGVC0hFe5z_Hw-1; Thu, 06 Feb 2020 10:05:59 -0500
X-MC-Unique: Xt-gx1DbOwGVC0hFe5z_Hw-1
Received: by mail-wm1-f72.google.com with SMTP id y125so574152wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=j+K+K1lzfnMrsdr5Lps83cVjNAUCj3VKAmVhjs/GwTg=;
        b=lHdMEdS1ICYOoQvnohjp6JF8GadapZ4vY/ogEbjzn60uZ+1nUbuDy6hl+on+Tj+9P3
         fSmH5VQMstTSHIXECYObaqquubeKj3ss3neSCU1aJMtXyORmZmbDXXTuMtpXEYAfyUAA
         Kiom9eUEMIoeNmlca+xfQ+EGBJ4uO6CowaJGUA0RxJB/1T999yHqNVBmT4IxxQG97VYw
         mbw/30nf1+QKDWBb/FY1G0NADEu6XJxIhhJZoEMLhVYvUBYid7aabSM45aL6OpgMoucU
         b12GB6oq9lrGxStJ2Wj2TsDqYjXGXBd76n6X/lHZJYR1rmLU1y1zPuUIPQsQscpdMei+
         1k7Q==
X-Gm-Message-State: APjAAAWuYkzo3veLYVZx+eNeI3+xlHPEQ2eweHgOveK5wEnKE2OvVRWV
        4ThF8+4gM4L7CHrKrX/qzXizDXzZWufSXvAFnIkL8mCjnDhGG3Ty4yGQ0xszZdxs3fifmEMUgpp
        mdfhsUriHriNN9wjL4m+gj1pa
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr4130078wrw.31.1581001558650;
        Thu, 06 Feb 2020 07:05:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcZzYuxdYkxzYJYhCOokkPrC7LeG8L4v9I/T8WcVMrrfZQBR+/EO967r/qeNM8XJm+gek+sQ==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr4129888wrw.31.1581001556250;
        Thu, 06 Feb 2020 07:05:56 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v5sm4474603wrv.86.2020.02.06.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:05:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/61] KVM: x86: Simplify handling of Centaur CPUID leafs
In-Reply-To: <20200201185218.24473-4-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-4-sean.j.christopherson@intel.com>
Date:   Thu, 06 Feb 2020 16:05:54 +0100
Message-ID: <87pnerg3hp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Refactor the handling of the Centaur-only CPUID leaf to detect the leaf
> via a runtime query instead of adding a one-off callback in the static
> array.  When the callback was introduced, there were additional fields
> in the array's structs, and more importantly, retpoline wasn't a thing.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index f49fdd06f511..de52cbb46171 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -829,15 +829,7 @@ static int do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 func,
>  	return __do_cpuid_func(entry, func, nent, maxnent);
>  }
>  
> -struct kvm_cpuid_param {
> -	u32 func;
> -	bool (*qualifier)(const struct kvm_cpuid_param *param);
> -};
> -
> -static bool is_centaur_cpu(const struct kvm_cpuid_param *param)
> -{
> -	return boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR;
> -}
> +#define CENTAUR_CPUID_SIGNATURE 0xC0000000

arch/x86/kernel/cpu/centaur.c also hardcodes the value, would make sense
to put it to some x86 header instead.

>  
>  static int get_cpuid_func(struct kvm_cpuid_entry2 *entries, u32 func,
>  			  int *nent, int maxnent, unsigned int type)
> @@ -845,6 +837,10 @@ static int get_cpuid_func(struct kvm_cpuid_entry2 *entries, u32 func,
>  	u32 limit;
>  	int r;
>  
> +	if (func == CENTAUR_CPUID_SIGNATURE &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR)
> +		return 0;
> +
>  	r = do_cpuid_func(&entries[*nent], func, nent, maxnent, type);
>  	if (r)
>  		return r;
> @@ -896,11 +892,8 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  	struct kvm_cpuid_entry2 *cpuid_entries;
>  	int nent = 0, r = -E2BIG, i;
>  
> -	static const struct kvm_cpuid_param param[] = {
> -		{ .func = 0 },
> -		{ .func = 0x80000000 },
> -		{ .func = 0xC0000000, .qualifier = is_centaur_cpu },
> -		{ .func = KVM_CPUID_SIGNATURE },
> +	static const u32 funcs[] = {
> +		0, 0x80000000, CENTAUR_CPUID_SIGNATURE, KVM_CPUID_SIGNATURE,
>  	};
>  
>  	if (cpuid->nent < 1)
> @@ -918,14 +911,9 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  		goto out;
>  
>  	r = 0;
> -	for (i = 0; i < ARRAY_SIZE(param); i++) {
> -		const struct kvm_cpuid_param *ent = &param[i];
> -
> -		if (ent->qualifier && !ent->qualifier(ent))
> -			continue;
> -
> -		r = get_cpuid_func(cpuid_entries, ent->func, &nent,
> -				   cpuid->nent, type);
> +	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
> +		r = get_cpuid_func(cpuid_entries, funcs[i], &nent, cpuid->nent,
> +				   type);
>  		if (r)
>  			goto out_free;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

