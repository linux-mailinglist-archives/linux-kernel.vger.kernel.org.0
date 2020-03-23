Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F346C18FE60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCWUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 16:00:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34225 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgCWUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584993656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cY+H9r1hyt0W+F/eh6c6o3kR9Aied7i4vmIsTGqyvm8=;
        b=bCuqD3sYav/rMPCtGTKmvRTbkWfGL+KXpOCXCfCiTeEhBXM9CZ0WIF/teLROpnsjgWdZ4U
        frAMcZHC/7hTIYU+qebt/GOdNAVTS8ITKwVZmNGnl9Ss2kD87mV6FkHAeanZRuK6vLvbLl
        mpMC6O2gDuG4tTDAc6t3sXjqnik1UuA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-81WvkUxJPF-3OxYYqOIRSg-1; Mon, 23 Mar 2020 16:00:55 -0400
X-MC-Unique: 81WvkUxJPF-3OxYYqOIRSg-1
Received: by mail-wr1-f70.google.com with SMTP id o9so7905801wrw.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cY+H9r1hyt0W+F/eh6c6o3kR9Aied7i4vmIsTGqyvm8=;
        b=R+Fd92hTrLDNkrngtrwewoYkNfdFdQ4mOrCYIdYX/mu67rGe3auSIYoXhxiKi4ZYNX
         oH/buxtUo0SijDSvaxsGH+iUuaXh6TSlIjfDqbC4Nr7+vfkXc+DmROpM8B0XV/iYgirZ
         Wu01Y+AKsvrN+psHo7+T31NcSIZ91lE9ZqjFEzM5v8EjGllspr3CsmXwWZYvpQVs/ebh
         ZrTstFTWyIndouWr1J67z5OQXvX+VLR2hbL7p2hFrg3Bw40dDgbVMVwqGkvRW0ltMl9J
         RlafbgR2PDz+6xyirBgUEnCrasa3eDw2LN1VPCl7Sr4lwkcwbhD9xewFITtN5wuNGHI0
         4dNw==
X-Gm-Message-State: ANhLgQ0IgnhTxoposPSb9PcnCc9sPM/YUqg4pAihOvJELh0IX9MzodOJ
        rMe3EiUu9FQXHiSsYx9iuct1/8zzNlHeCRikXyVieD22a2sUvui84h4wX7iX/taRHhwgfvgXwbU
        R7V1rsP18YNerL841wOgUWTMu
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr26655838wrp.230.1584993653905;
        Mon, 23 Mar 2020 13:00:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvXyqIbkkktOwq1/2ooUCj01kGPzulVzA6RfK1uS8wG/GOec0veo7shFCpnK1NWAqj8WTc9EQ==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr26655802wrp.230.1584993653686;
        Mon, 23 Mar 2020 13:00:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id 98sm25182715wrk.52.2020.03.23.13.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 13:00:53 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] KVM: VMX: Configure runtime hooks using
 vmx_x86_ops
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
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
References: <20200321202603.19355-1-sean.j.christopherson@intel.com>
 <20200321202603.19355-5-sean.j.christopherson@intel.com>
 <87ftdz9ryn.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7915319-8795-e466-e2df-478b1bf9734c@redhat.com>
Date:   Mon, 23 Mar 2020 21:00:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87ftdz9ryn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 13:27, Vitaly Kuznetsov wrote:
>> -	kvm_x86_ops->check_nested_events = vmx_check_nested_events;
>> -	kvm_x86_ops->get_nested_state = vmx_get_nested_state;
>> -	kvm_x86_ops->set_nested_state = vmx_set_nested_state;
>> -	kvm_x86_ops->get_vmcs12_pages = nested_get_vmcs12_pages;
>> -	kvm_x86_ops->nested_enable_evmcs = nested_enable_evmcs;
>> -	kvm_x86_ops->nested_get_evmcs_version = nested_get_evmcs_version;
>> +	ops->check_nested_events = vmx_check_nested_events;
>> +	ops->get_nested_state = vmx_get_nested_state;
>> +	ops->set_nested_state = vmx_set_nested_state;
>> +	ops->get_vmcs12_pages = nested_get_vmcs12_pages;
>> +	ops->nested_enable_evmcs = nested_enable_evmcs;
>> +	ops->nested_get_evmcs_version = nested_get_evmcs_version;
> 
> A lazy guy like me would appreciate 'ops' -> 'vmx_x86_ops' rename as it
> would make 'git grep vmx_x86_ops' output more complete.
> 

I would prefer even more a kvm_x86_ops.nested struct but I would be okay
with a separate patch.

Paolo

