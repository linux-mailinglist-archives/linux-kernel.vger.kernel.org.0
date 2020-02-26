Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83B916FDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgBZLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 06:35:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728178AbgBZLfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582716913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvIUhrFKwmk9Ea/GdoOf5uCGGPADVd/Wpcg66GGR0yk=;
        b=Hzl3SZANuy6T9WLoCp2U1UFPL1zz5GIBI5lfvXQeGzKMZc/QFKuUu9z4dc5ad8jEP0gP7F
        /YeRRvimVLIzt5mVpslWuKH9qbA3TA1SDKGXId5TqVKYx1KmSM/7pSe2ixMElaULw/ANHx
        E+4+f5fLWLAdM1wvEOb2RT3KWDOjUEo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-D5V1BqxgOfSZzqjIneXF9Q-1; Wed, 26 Feb 2020 06:35:11 -0500
X-MC-Unique: D5V1BqxgOfSZzqjIneXF9Q-1
Received: by mail-wm1-f72.google.com with SMTP id f9so498377wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lvIUhrFKwmk9Ea/GdoOf5uCGGPADVd/Wpcg66GGR0yk=;
        b=OuCrSR/TxNRhU4NZBfgr+m/K1kF8PkAb5e5EquaQdG4X3bw+/ApwohYX1Abq2l0mKg
         4E30qXduvv+nP7nOiewMM5YF4Dq6HGTZn7OfFsQhB7AA6Aj5Y9mJME5XDHbOgrn/wmQa
         Pas+/wrWRwfOR4o6OipqohOVguANnfEDE3gjZItt/9O2JPcsoHXhT+m00Uvjuk0hIkxd
         q8saPHDEzBnHX1qC2B95uDtDkpmr/Hu7bIYLJZKhGbfEPu8urfs+FzybTAgokGUFFtQD
         +0O5dHCgI6WCrVOyS4yQiMS1nJi9Z2PjVUtY9CMIDPSr6MTcycmIRBsM/XiEret5G+Z0
         UwLw==
X-Gm-Message-State: APjAAAV8PSJuSh64K62xszl2YvtQbz5MLTkoyqyGNvPK3U5UAETeBoqA
        2q6/VgQR28L8h3m2r8JNFxAT2xIQWE76qnXINcuvD8341xDzOsfoIe8Wj8yylV66sp2v2iK/FNs
        IrjQgKf5lnp6UTiDCkCdguwJV
X-Received: by 2002:a5d:5647:: with SMTP id j7mr5081292wrw.265.1582716910231;
        Wed, 26 Feb 2020 03:35:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDd3f4Vi0FeLResGKxmUpHUh3OYBUuZ7e/luVEzmQiuyXycrrIMCW1Rytkgx2yxmucC695Fw==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr5081262wrw.265.1582716909980;
        Wed, 26 Feb 2020 03:35:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id w7sm2444135wmi.9.2020.02.26.03.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 03:35:09 -0800 (PST)
Subject: Re: [PATCH 02/61] KVM: x86: Refactor loop around do_cpuid_func() to
 separate helper
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-3-sean.j.christopherson@intel.com>
 <87sgjng3ru.fsf@vitty.brq.redhat.com> <20200207195301.GM2401@linux.intel.com>
 <04fb4fe9-017a-dcbb-6f18-0f6fd970bc99@redhat.com>
 <87zhd6k8jn.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4cb8b15-acab-38a7-a2c2-74b58f7df873@redhat.com>
Date:   Wed, 26 Feb 2020 12:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87zhd6k8jn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 16:09, Vitaly Kuznetsov wrote:
>> Apart from the stupidity of the above case, why would it be EINVAL?
>>
> I suggested -EINVAL because issuing KVM_GET_SUPPORTED_CPUID with nent=0
> looks more like a completely invalid input and not 'too many
> entries'(-E2BIG) to me (but -E2BIG is already there, let's keep it, it's
> not a big deal).

Yes, and in fact he already does that change a few patches later.

Paolo

