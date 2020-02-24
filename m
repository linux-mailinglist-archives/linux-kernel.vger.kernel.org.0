Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D0816B4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBXXM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:12:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40721 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbgBXXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582585946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vs3dntWvSoZuKohT+PUhBTZyrkXf/ZjGkKMw3SgzXtU=;
        b=cSwd29eCR3ZlzaQflWp6QwzXmEXTJfJQw4DDErM7Kv2L9iwV/70SWulXV8IGWRlhNcZJa6
        h9FJeDZMtASGmvTe4aFviALpXzMMX8NN9zm3AndwMotQghKGm4Wz7w2Fc7hxoj8O5rXHgE
        JpUAHkgv3Y2mOaZ2+XxMTxw+E7qNzJY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-g65_IdZqPd-Dm9V_dqoNww-1; Mon, 24 Feb 2020 18:12:25 -0500
X-MC-Unique: g65_IdZqPd-Dm9V_dqoNww-1
Received: by mail-wr1-f69.google.com with SMTP id o6so6313016wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Vs3dntWvSoZuKohT+PUhBTZyrkXf/ZjGkKMw3SgzXtU=;
        b=cixw65PrqegSlecLktDsg6ceS7RS2mXc1jsVyv0RwPMaDpszokyBs8jNteccRiE/5X
         MCrqYSHUmMOoBg4/89v/Gs7BSRDDdz9+bENfkJ2EjO1NeQKT+opnutH8CBK5LjjO9JAo
         WWFNMeFgL/GsMA8tpdbvjL9WanrvQJNDMwfpKC8SDdtoOQcZKqivuF6PrZuWVN9Tegh2
         a+LXW3gpZy2MCxqakbBiH3jsBy64rFx0PRBkYOZwSJAyymD+zhRM8Ooybs5gzqf4lMDt
         uyeyGlFFTkHelrpYI5RPCxhG1CVBFQ16QNiLrYi/l+zeRPGqI3DHwigeOJxJzYdJuIJC
         qo4A==
X-Gm-Message-State: APjAAAUoR5LL/sw6YqHjkv2I+osvyVctl7MFKtdWIX6O4rKyEB6Xedpu
        dqTo6xN2p6zQY4a+8QMQiAwFT9Ck3JK7wV8J7CY6QRKgBvLo5GDO2hoXKakCKfWU8qOlr9jCuxy
        jCzywAQAOKMwSjvPBJJeohEM3
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr1238010wmd.69.1582585943933;
        Mon, 24 Feb 2020 15:12:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgQZ09o1S3AQ6goRcV2RRdIuwUHwSHfgfjMonpALA8g9GRiuIjN7qDVPsCp3yZB1JBAtesqw==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr1237992wmd.69.1582585943720;
        Mon, 24 Feb 2020 15:12:23 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t1sm1367352wma.43.2020.02.24.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:12:23 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/61] KVM: x86: Encapsulate CPUID entries and metadata in struct
In-Reply-To: <20200224215551.GL29865@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-17-sean.j.christopherson@intel.com> <87y2swq95k.fsf@vitty.brq.redhat.com> <20200224215551.GL29865@linux.intel.com>
Date:   Tue, 25 Feb 2020 00:12:22 +0100
Message-ID: <87imjvmvft.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Fri, Feb 21, 2020 at 03:58:47PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>
>> > +			if (!entry)
>> >  				goto out;
>> >  		}
>> >  		break;
>> > @@ -802,22 +814,22 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>> >  	return r;
>> >  }
>> >  
>> > -static int do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 func,
>> > -			 int *nent, int maxnent, unsigned int type)
>> > +static int do_cpuid_func(struct kvm_cpuid_array *array, u32 func,
>> > +			 unsigned int type)
>> >  {
>> > -	if (*nent >= maxnent)
>> > +	if (array->nent >= array->maxnent)
>> >  		return -E2BIG;
>> >  
>> >  	if (type == KVM_GET_EMULATED_CPUID)
>> > -		return __do_cpuid_func_emulated(entry, func, nent, maxnent);
>> > +		return __do_cpuid_func_emulated(array, func);
>> 
>> Would it make sense to move 'if (array->nent >= array->maxnent)' check
>> to __do_cpuid_func_emulated() to match do_host_cpuid()?
>
> I considered doing exactly that.  IIRC, I opted not to because at this
> point in the series, the initial call to do_host_cpuid() is something like
> halfway down the massive __do_cpuid_func(), and eliminating the early check
> didn't feel quite right, e.g. there is a fair amount of unnecessary code
> that runs before hitting the first do_host_cpuid().
>
> What if I add a patch towards the end of the series to move this check into
> __do_cpuid_func_emulated(), i.e. after __do_cpuid_func() has been trimmed
> down to size and the early check really is superfluous.
>

Works for me, thanks!

-- 
Vitaly

