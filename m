Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9918E31F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCURGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 13:06:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51475 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgCURGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 13:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584810398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBf1jZFDWJfil6GPICcnYrVVsebcDeSgyL/zqAgKcgA=;
        b=XIdniJhmtCO3/466WnlNbfdynrJlbFmFCzN4PLbYgIds+yufDmGwsejrqar2OtVRueuR+W
        D3RSeocbSwkXIzNjaTUigTz0uNr4500U2Za6JlH460ALz6MvX+NUiVG60PU6tBOvoq3wMN
        0fILFyddxBMbYcXDKxsM4YeCE2A++XY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-yTN2EcWiP-qAhET707zaAA-1; Sat, 21 Mar 2020 13:06:36 -0400
X-MC-Unique: yTN2EcWiP-qAhET707zaAA-1
Received: by mail-wm1-f71.google.com with SMTP id g26so3136073wmk.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 10:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qBf1jZFDWJfil6GPICcnYrVVsebcDeSgyL/zqAgKcgA=;
        b=jjprzr7ue/V8yGtXAdcEGX1gWhHzIwJ/EF5LtoE+BBAht324gyeO15+nJgYPFA+dCn
         yStJRWwjU/daBLxAQWREWmvCh1VLHRsUy6kClygR1Ap5f4038gzDGFk5wP/avPZ6rgkk
         D8Rsuw6SrhIYSMIQg5uolQ4XK8nYnfXt89khDJ8XBbDZpBXpaMb0w5Y+AE1TRqIKkp9P
         ptHoJPLLXXYefBiQOQ3GaHprSIbQEXOCUTMQ2x547alwj1qEkymV4e3WdO9MiulgrmuO
         scrJvXmf/OfuDguNiOUFk04i38c4MqWgLj99Lz/bgE5tFzBcpUYL3XJD1OHB0xU0ewG0
         Wb8A==
X-Gm-Message-State: ANhLgQ0tNoaWMPKJeJLs337tPnG/VDHTEXBcbjjdv+EoufUMG6+rQ8xo
        hkY1gc4FYulq6HK3bcrvxpVD3JZ4/ODcBr0jFmp0wZlGvs5qFgLf9YA4ei9lLShdz4OXL0rqYwp
        JVkzT1G5mrODbTtSdpsP1Qbvz
X-Received: by 2002:adf:a54a:: with SMTP id j10mr19111321wrb.188.1584810395123;
        Sat, 21 Mar 2020 10:06:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQWpokduTrQpxfBkLp1mdxfKHuTe0bXRbdEj8z+pkh5ZTL/y0qBziCDs5v7r/l08R5TSnuUg==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr19111297wrb.188.1584810394875;
        Sat, 21 Mar 2020 10:06:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id q72sm13155861wme.31.2020.03.21.10.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 10:06:34 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Issue WBINVD after deactivating an SEV guest
To:     Tom Lendacky <thomas.lendacky@amd.com>, Greg KH <greg@kroah.com>
Cc:     David Rientjes <rientjes@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <c8bf9087ca3711c5770bdeaafa3e45b717dc5ef4.1584720426.git.thomas.lendacky@amd.com>
 <alpine.DEB.2.21.2003201333510.205664@chino.kir.corp.google.com>
 <7b8d0c8c-d685-627b-676c-01c3d194fc82@amd.com>
 <20200321090030.GA884290@kroah.com>
 <fd8fccbb-2221-dcef-fd88-931a9c6b1b85@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34e7eef3-9f13-c471-89b5-914126e9e499@redhat.com>
Date:   Sat, 21 Mar 2020 18:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fd8fccbb-2221-dcef-fd88-931a9c6b1b85@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/20 13:16, Tom Lendacky wrote:
>>
>> Yes, I have had to go around and clean up after maintainers who don't
>> seem to realize this, but for KVM patches I have been explicitly told to
>> NOT take any patch unless it has a cc: stable on it, due to issues that
>> have happened in the past.
>>
>> So for this subsystem, what you suggested guaranteed it would NOT get
>> picked up, please do not do that.
> 
> Thanks for clarifying that, Greg.
> 
> Then, yes, it should have the Cc: to stable that David mentioned. If it
> gets applied without that, I'll follow the process to send an email to
> stable to get it included in 5.5-stable.

No, don't worry, I do add the stable tags myself based on the Fixes tags.

Paolo

