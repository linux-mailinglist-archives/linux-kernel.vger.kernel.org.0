Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAD188C49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgCQRkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:40:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36582 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgCQRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584466843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3YlvCm1lBNLjiNpS/n2yOjJThq/QHDMua9Olu9Cwy6g=;
        b=OcS5SJSkUIKWxtsFEL/OIcElz8KLEB4/bS3qcffss86Q5hB2yQqKya8nCUtH9k0cv0Cwr1
        Mm0TpPmMvqIkFwOFqeG4shbw7D8yk61jWfJwOFsQOxwIZLNiMcK9iyrjX4H9ZYftAkZP2b
        aWy65svJE1RoFfBhzxdsCwOSg0GKmzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-stm4TEUkPEq7AxQjkzI8rA-1; Tue, 17 Mar 2020 13:40:41 -0400
X-MC-Unique: stm4TEUkPEq7AxQjkzI8rA-1
Received: by mail-wm1-f71.google.com with SMTP id 20so64375wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3YlvCm1lBNLjiNpS/n2yOjJThq/QHDMua9Olu9Cwy6g=;
        b=UlLMMc7/2QlcY83ckvy37zrCeqpCFl7SAAVFGIvWZnCisNGnER6Swgk59jT5a1qCDI
         Nj/LH+RIqQuQH2SbSum3Wz/0qGHzxlIMFfCR3LcoS5oWcL7aYwUC+DhmbvfenTT8bU/8
         ULdhT+73y2pwVpu4cmIqV/Z4UoqJ1EMT3BazbhhEE/v6hTvy19SIvPI6DSCjJESHvFIT
         Md35JTWiwjPRp35Ofg8UqYUb1hTC3P+5tE851k/HVivWLyUYDQPtiDgfNRyl8Q8UTtlM
         aO5Vggf+VuuLKlnJvlqK5TGgYEobxRd7BlsLqWuOOG6WzIj5MZ/CCPgbzvRJJOn3E4Q5
         wReg==
X-Gm-Message-State: ANhLgQ0Z6JF31rrdaUwPuE1qx0fNZjwAAoeej/gMaMDe3UyLzQR3Qs2M
        rMVRM/kmh2xJENY6v5QWNl8DyHxzn5lrPn+VSHQgcVhsaiiODe0it5WJaEu0AZmAOLxGx0JanAk
        /IVqXsRDUtqsGOIat60YpbEpr
X-Received: by 2002:a1c:1b4c:: with SMTP id b73mr140312wmb.17.1584466840408;
        Tue, 17 Mar 2020 10:40:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs92iD8sXBzTaC2wszHXrLF6Lp91CBQvFML4Ry1JpAZwSbj6GU/EyKGYKgxJ+6i26ac5kJdBQ==
X-Received: by 2002:a1c:1b4c:: with SMTP id b73mr140298wmb.17.1584466840157;
        Tue, 17 Mar 2020 10:40:40 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
        by smtp.gmail.com with ESMTPSA id d21sm5274133wrb.51.2020.03.17.10.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:40:39 -0700 (PDT)
Subject: Re: [PATCH 06/10] KVM: nVMX: Convert local exit_reason to u16 in
 ...enter_non_root_mode()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
 <20200312184521.24579-7-sean.j.christopherson@intel.com>
 <87pndgnyud.fsf@vitty.brq.redhat.com>
 <20200317052922.GQ24267@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6ad902e-f2ce-2df6-5f48-c9eb6e5c75d8@redhat.com>
Date:   Tue, 17 Mar 2020 18:40:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317052922.GQ24267@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 06:29, Sean Christopherson wrote:
>>>  
>>>  	load_vmcs12_host_state(vcpu, vmcs12);
>>> -	vmcs12->vm_exit_reason = exit_reason | VMX_EXIT_REASONS_FAILED_VMENTRY;
>>> +	vmcs12->vm_exit_reason = VMX_EXIT_REASONS_FAILED_VMENTRY | exit_reason;
>> My personal preference would be to do
>>  (u32)exit_reason | VMX_EXIT_REASONS_FAILED_VMENTRY 
>> instead but maybe I'm just not in love with implicit type convertion in C.
> Either way works for me.  Paolo?
> 

Flip a coin? :)  I think your version is fine.

Paolo

