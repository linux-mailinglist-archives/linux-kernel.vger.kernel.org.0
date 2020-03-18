Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEC418A15C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 13:17:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25431 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbgCRRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584551859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElhWjdRMCoGK2Lc8uZXX8uK2whTvzsICGIGF/xooqpM=;
        b=ansNdrsqTThDNLBVlrPKPfc61plV/BXMwDyuLAjtD6QQtX1dw+m7+01B1jjdC9R2KsEyiK
        aHhO6yz5DsD3/kdzklLeRJw2Kd1D8QKZ2OrE8+biQog1vK6pNY+0AsJU0vAcjAX25Qcd9S
        X+NgZF5vON4gJigVnq2QHYR9CTw2wZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-GgHO57tRPyiDm3k0yDU9DQ-1; Wed, 18 Mar 2020 13:17:38 -0400
X-MC-Unique: GgHO57tRPyiDm3k0yDU9DQ-1
Received: by mail-wm1-f70.google.com with SMTP id 20so1344361wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ElhWjdRMCoGK2Lc8uZXX8uK2whTvzsICGIGF/xooqpM=;
        b=abSgJKiCcWy80Q6itMBjk3cNJD7vNFp/cPKg8lgjS8NdVe5o0tyuiOEhLoryglfSFC
         UV5iCqULC734E1wddlOH6i7qfF/nFrjf3Tm1JhA3YwfvVEU3OOxOXRKsT1AoU2xrxegH
         fValFY6nYjvADO58TwKL55BLf+aVuxJw3DMyYX5+D4x3OJVgdOIGiMGji/Qubo4eGvz8
         LQW71bdEGXh1kfJ0aBbMUDjSBmLNkaurOlnRlOVhh3y3NgvWjBOsPjBpmeDg1WNwDaXQ
         lVHNNagwKwOT5pEs7SHhqVerznUTA6NNirUxfNq9I+Bi7YI6s8rLlQnLFmrbL9TaRqZI
         Bmdg==
X-Gm-Message-State: ANhLgQ1I+XyP4ndWCNqjLU+5X4/ScDn3lW/P7rOSZ1lFVo/qDAsSDYLK
        dI57sxIM9/T8tTKBhV0WWRhROdhLk5NO+hsJoE8jRiJtr1ZdZTI20q5K1h9zyrojwiDkuDiWWVA
        nvVRl0UHckpNJIBSAktddvfPW
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr6556008wrr.406.1584551857189;
        Wed, 18 Mar 2020 10:17:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuLNTKjD3r3M43CNF3bs8kW9P2xtl0cL/v67E32HQFeJpZLIMHlaNw6rmfihVJhQipQ+Kn6vw==
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr6555987wrr.406.1584551856929;
        Wed, 18 Mar 2020 10:17:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u144sm3129625wmu.39.2020.03.18.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:17:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 2/2] KVM: VMX: untangle VMXON revision_id setting when using eVMCS
In-Reply-To: <87mu8pdgci.fsf@vitty.brq.redhat.com>
References: <20200306130215.150686-1-vkuznets@redhat.com> <20200306130215.150686-3-vkuznets@redhat.com> <908345f1-9bfd-004f-3ba6-0d6dce67d11e@oracle.com> <20200306230747.GA27868@linux.intel.com> <ceb19682-4374-313a-cf05-8af6cd8d6c3b@oracle.com> <20200307002852.GA28225@linux.intel.com> <87mu8pdgci.fsf@vitty.brq.redhat.com>
Date:   Wed, 18 Mar 2020 18:17:34 +0100
Message-ID: <87r1xp1t1t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>
>>   enum vmcs_type {
>> 	VMXON_VMCS,
>> 	VMCS,
>> 	SHADOW_VMCS,
>>   };
>>
>
> No objections from my side. v4 or would it be possible to tweak it upon
> commit?

It seems this slipped through the cracks, rebased v4 is comming to
rescue!

-- 
Vitaly

