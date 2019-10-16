Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D93D8CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbfJPJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfJPJlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:41:06 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2696FC05686D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:41:06 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w2so11521627wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+/XXGrpNozCSyajreXrVJeY8SJDmqfMaPcvU+nilJic=;
        b=l/7D8NHTcfwx2n5hsy2xVtcQXUROkb93abeISHaqExQPq9kfYUW4uoqV9ad++g5vI1
         d3ku7XkAsoVaIuoeJ4hzSw/X+XX+5l/NZVZJtq35BGjaXLY7Q2lNBx5V1hU66tKa411k
         uVEgThBNpSsn8GPgu/6BVaBZ5V+aukpUJyOBOAoY7TAazW8LyAvPLAVWUfMEovtLkwzb
         /ZCA9Snqo1hqkweyrXnH/B7obE2o34aaxp0digi13q9YQRR0US1AjbMrN0yEpFRVGnM9
         3bFXoU0p3elMmoa7k4kFhumlx0KfDIgqreUHjfM0uQSviQatAOIBrW83ft3d6AaQOI1h
         2XLQ==
X-Gm-Message-State: APjAAAXbjGI2Cld8m9QA+gXYx9SCxscs5rH9gaNFvkBHhVjKgFsY9Ic1
        LcLxlE6R9srgohY3MdZ2bhBAgRQoproaj3qktICypRQbb4SsDUrlBg5KXwOdM/2zg0ZqXcy96LB
        7rH0VSYVWdtgea5KPcOG4YJvR
X-Received: by 2002:adf:fa86:: with SMTP id h6mr1830015wrr.186.1571218864813;
        Wed, 16 Oct 2019 02:41:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgwsHpBb20L1PvDo1LFEyusoLMGQ0MOWWfnLaWu+kFJ88D3mS8OS7IaVf4s07z4/xuk+xOKg==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr1829999wrr.186.1571218864577;
        Wed, 16 Oct 2019 02:41:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id 33sm42277584wra.41.2019.10.16.02.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 02:41:04 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com>
 <87y2xn462e.fsf@vitty.brq.redhat.com>
 <d14d22e2-d74c-ed73-b5bb-3ed5eb087deb@redhat.com>
 <6cc430c1-5729-c2d3-df11-3bf1ec1272f8@intel.com>
 <245dcfe2-d167-fdec-a371-506352d3c684@redhat.com>
 <11318bab-a377-bb8c-b881-76331c92f11e@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <10300339-e4cb-57b0-ac2f-474604551df0@redhat.com>
Date:   Wed, 16 Oct 2019 11:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <11318bab-a377-bb8c-b881-76331c92f11e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 09:48, Xiaoyao Li wrote:
> BTW, could you have a look at the series I sent yesterday to refactor
> the vcpu creation flow, which is inspired partly by this issue. Any
> comment and suggestion is welcomed since I don't want to waste time on
> wrong direction.

Yes, that's the series from which I'll take your patch.

Paolo
