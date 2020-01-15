Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B553213CC02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 19:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAOSYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 13:24:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40104 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728928AbgAOSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579112643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ga36+mfvvpplKWf5woArU2Umny7JJ0McSe9ltiEw3rA=;
        b=RREeAyxCCfIOi8ye85QOZLGfLFy6G7vJrYnTLfeqocxEwl91us2rbvvHOwcCXPDJ9D+tbT
        jTNLyCKYwD6vjRMWY6aUSF2e3WfGKz2Yr7ekSNdV+fpHvSm/QvZJwDZvbRg6G0lGs2qWCd
        k7tfuqniJm3j9YWdVb3G6IJSYExjGq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-R0WdjJJLNHa8-klvf9gLMQ-1; Wed, 15 Jan 2020 13:24:02 -0500
X-MC-Unique: R0WdjJJLNHa8-klvf9gLMQ-1
Received: by mail-wr1-f71.google.com with SMTP id y7so8333445wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ga36+mfvvpplKWf5woArU2Umny7JJ0McSe9ltiEw3rA=;
        b=GyzJLEr/EPq3W2fI37J5oCaD0L1nwWpAOGT/JBJpr3IxM15pZOkRE95gW0w2iIvmEG
         hiQSvWllgv4eGw3Oh5TW0K/8HOIFP34V7DhSM+NHD89Ir4HzPiOJt30szPqFnnqJG34N
         PndTBt4HB9uIyjlA3QPSxb98Iu+TrJ7J4YUXe9LH51Da2SyvXQA8R83d2nQO66mbUdFj
         dBHbbIgleVr3lhzOsb/2J4fmlB9anzLsmzTS4+EIZrzTHSXC/A6jGyBIpPeyedyr4X6E
         +FAZMl7HU06hgwC4gZGynlPkR1TRfJqHbMMXD1b3//ppO0YFGFsApmEmsb7k21+8Skiz
         wbbw==
X-Gm-Message-State: APjAAAWSd/V9Vze3T9LEiaXnp8CXOxtbIpBRFT58upVsHKWpB5pcMaQ3
        JaM2ERr+92ROIEINFx8JiUOm7yPNVao9KLNAeYzqVKVJf4xqPWDuXUJ/O0Pu6TffzL++oqbEfID
        kHOV7+0ZYkongjoCh6NLj3j65
X-Received: by 2002:a5d:4392:: with SMTP id i18mr34239394wrq.199.1579112640876;
        Wed, 15 Jan 2020 10:24:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjPUqUhsSp42j9K7MsZ2fvU034CQ/7nWIncYPYJk9054LYvZYQt1gO7wGM3iLAo4H4spjLEw==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr34239383wrq.199.1579112640604;
        Wed, 15 Jan 2020 10:24:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id h17sm26368396wrs.18.2020.01.15.10.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:24:00 -0800 (PST)
Subject: Re: [PATCH v2] KVM: SVM: Fix potential memory leak in svm_cpu_init()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        liran.alon@oracle.com
References: <1578128209-12891-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54acb241-9837-ed9c-49a2-976fd6e0ea36@redhat.com>
Date:   Wed, 15 Jan 2020 19:23:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1578128209-12891-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/20 09:56, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> When kmalloc memory for sd->sev_vmcbs failed, we forget to free the page
> held by sd->save_area. Also get rid of the var r as '-ENOMEM' is actually
> the only possible outcome here.
> 
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> -v2:
> 	drop var r as suggested by Vitaly
> ---
>  arch/x86/kvm/svm.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 8f1b715dfde8..5f9d6547e0e7 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1003,33 +1003,32 @@ static void svm_cpu_uninit(int cpu)
>  static int svm_cpu_init(int cpu)
>  {
>  	struct svm_cpu_data *sd;
> -	int r;
>  
>  	sd = kzalloc(sizeof(struct svm_cpu_data), GFP_KERNEL);
>  	if (!sd)
>  		return -ENOMEM;
>  	sd->cpu = cpu;
> -	r = -ENOMEM;
>  	sd->save_area = alloc_page(GFP_KERNEL);
>  	if (!sd->save_area)
> -		goto err_1;
> +		goto free_cpu_data;
>  
>  	if (svm_sev_enabled()) {
> -		r = -ENOMEM;
>  		sd->sev_vmcbs = kmalloc_array(max_sev_asid + 1,
>  					      sizeof(void *),
>  					      GFP_KERNEL);
>  		if (!sd->sev_vmcbs)
> -			goto err_1;
> +			goto free_save_area;
>  	}
>  
>  	per_cpu(svm_data, cpu) = sd;
>  
>  	return 0;
>  
> -err_1:
> +free_save_area:
> +	__free_page(sd->save_area);
> +free_cpu_data:
>  	kfree(sd);
> -	return r;
> +	return -ENOMEM;
>  
>  }
>  
> 

Queued, thanks.

Paolo

