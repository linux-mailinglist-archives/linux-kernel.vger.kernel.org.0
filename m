Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847CEF1C32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfKFROo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:14:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfKFROo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:14:44 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02D5F821CC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2019 17:14:44 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id v6so5255850wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QPuewg+igX+Y9jROhNdPAEozZADLHEAOgnbpEs8tHxs=;
        b=Kq6WwUFlSF9ujkvrNtVrdWhqtbGnsBiBzn7cb9f9VN2BFBd53kQJeEG+gBVsV8jEr/
         Sc1q6/fBdf+mljPxmDokHXAEbtGLnVsCxDcZggjp720FPVoVB7lbzsjoz/l9Y3OpY5W/
         bAdaGQ/hjBEXa61ggIomC1zbcGoUBHTaNHEPW507vak6A6SqCzFBbwT31TWM4UejiOiw
         atwRbyYpgfeb6QLmDi0Ql9KpH+swsegwrVn2Gb8LXNrN6M4c0gQpE1he3g14tCq+y1xW
         RnKIyl9Wr17oU7XwIrMR0B0j8pTJAppUhyyxVhu/XlGr2yFnGm0jePkAPg3mdMCqYtWs
         vE+w==
X-Gm-Message-State: APjAAAWEpa2+vPo2qJHkZ8EWWet+cwVgXSyTPif9SMk8E1qa3PUaqNT3
        4T3CWbCsdufP9id7Pmmn39noaz+c5tT5fqSnjQ/2urJMy/cbSLH74Q7iyYLDBFIfE1SLiPtCg/g
        2PZAzFIuHn6F+B+DvvW4l1w++
X-Received: by 2002:a5d:448f:: with SMTP id j15mr3616055wrq.70.1573060482631;
        Wed, 06 Nov 2019 09:14:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcqvKi/yfxsnHz+4Kb94GBXp/EaSDtrQzEUSyZMEwzz9UPgjC0hCLIufNNRbA+TILPZ0ZWHg==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr3616032wrq.70.1573060482299;
        Wed, 06 Nov 2019 09:14:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id j6sm3193919wrr.34.2019.11.06.09.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:14:41 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being
 reserved
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20191106170727.14457-1-sean.j.christopherson@intel.com>
 <20191106170727.14457-2-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8ba98630-9ca0-85c2-3c94-45d54a448fca@redhat.com>
Date:   Wed, 6 Nov 2019 18:14:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191106170727.14457-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/19 18:07, Sean Christopherson wrote:
>  void kvm_get_pfn(kvm_pfn_t pfn)
>  {
> -	if (!kvm_is_reserved_pfn(pfn))
> +	if (!kvm_is_reserved_pfn(pfn) && !WARN_ON(kvm_is_zone_device_pfn(pfn)))
>  		get_page(pfn_to_page(pfn));
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_pfn);

Can you call remap_pfn_range with a source address that is ZONE_DEVICE?
 If so, you would get a WARN from the kvm_get_pfn call in
hva_to_pfn_remapped.

Paolo
