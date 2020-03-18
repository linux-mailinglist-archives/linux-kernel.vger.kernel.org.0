Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB42189A16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCRK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:59:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46098 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgCRK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584529157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMtZ4jmJycvgiYeU4inzJpOO5pgYuaE53x0jqDSCJMY=;
        b=ABwYvkSKjrJTN9oVCeWZYqL1mDj7yumgWiQgFNoz+07clDA1rrhV3ruynqEW8Xpi3hI4T5
        s1hjT3djUcNOR94cGbPIFPsTN/AuF/SI9rloALkCrA3kql1WPZm2D9DHv3wTNR0yybpyL4
        ihCfMdVLrXpS2XLa/KNBnJZuRyukGCs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-QBGxuCGjNjetbMjm0iBrYg-1; Wed, 18 Mar 2020 06:59:16 -0400
X-MC-Unique: QBGxuCGjNjetbMjm0iBrYg-1
Received: by mail-wm1-f70.google.com with SMTP id a11so839503wmm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMtZ4jmJycvgiYeU4inzJpOO5pgYuaE53x0jqDSCJMY=;
        b=LbvIk1tFhhysGzmIZnARxoMftlFkCSQ+HK9rMJ5nQ/rAYw+8xdYfe+hI+Mgy5qWIBS
         oOk/94kDyz/lb5axm+oi2rTkBFktQbesx56Av6Xdnb92JtYZwHEwS9w2Dz8nq0CRL5BS
         7h5mD/xm6X78grepw2fapCQLS9Bk4ueeQf26v1OTZqkwr0FQATobMmoDasDLkNr1qBT5
         HpQBBr/T1CQt8MUjlRpb9naeOxc8UKPdKWAcxRq8bIHkHk1cgEyFph0Ltmvmh2yw+Kgc
         ycwjXWhzE538x3L01juucM3tw8Yqg4Dt4xQA82rsmXofd90Uv4joJgibDa649IrFimM8
         nITQ==
X-Gm-Message-State: ANhLgQ26wqmtFBJmhL3Y9cExwadVn7wvznWd3civ1RZo8ZTOypllE3yh
        m4sQDObsl+Z4Y8kpuzCSp5H/Lyif5HBp7md9YBgc1Dh2gCAHqyy7+BMnSVoLFEzfdJ4bl1OO0/P
        lpP7RNFabJ9cYeJt8+uB24ecX
X-Received: by 2002:a5d:4088:: with SMTP id o8mr5101797wrp.144.1584529154938;
        Wed, 18 Mar 2020 03:59:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsqJPtOCO7Bop1hF8dkWynp+0emhgYuxiGeDzjWNh+m03OZOuGNFzkn+9eJ8E5YITVCMV0eaQ==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr5101782wrp.144.1584529154751;
        Wed, 18 Mar 2020 03:59:14 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id 19sm3498623wma.3.2020.03.18.03.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 03:59:14 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: remove side effects from
 nested_vmx_exit_reflected
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1584468059-3585-1-git-send-email-pbonzini@redhat.com>
 <87tv2m2av4.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <803177a8-c5ef-ac5e-087b-52b09398d78c@redhat.com>
Date:   Wed, 18 Mar 2020 11:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tv2m2av4.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/20 11:52, Vitaly Kuznetsov wrote:
> The only functional difference seems to be that we're now doing
> nested_mark_vmcs12_pages_dirty() in vmx->fail case too and this seems
> superfluous: we failed to enter L2 so 'special' pages should remain
> intact (right?) but this should be an uncommon case.
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I'm not entirely sure if the PID could be written before the processor
decrees a vmfail.  It doesn't really hurt anyway as you say though.
Thanks for the review!

Paolo

