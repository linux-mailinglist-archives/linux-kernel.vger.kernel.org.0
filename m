Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8537164163
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGJGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 02:30:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43480 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:30:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so981569edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 23:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rvur+pL6SwVM9cGHoVikR51t5tf0bnhvGJDyTiXY9BE=;
        b=VPxhU4HwrmenqJ16xBbxXZKmCuvgxuxt29Ojp7zhQv+agvnAkBZYfBat1XpXNY4l6P
         xa/OQNNszmXz3muMRahG3u/LNwHttIg4mpzk3fRnCU1mHX3BekB+sqZqaXzjjrNfqshB
         vYhD1fKsxtmszqHHWaUUdIzNxHON0inHLcNMXQ3XZX0QOeWqAeEKRswKpaJiEevZvlgE
         GetjKdlRoKhFvBwnpbYobr8zYGYSPjt+cGa9wOrnazR91vWVYYGVIxOhOia4ZXGJ7ujr
         vXiS3jDYM7ekeRmZJRJSZBdRK6SKeA5CRU7ftx4B1S+G6ltwTPW34xJ/zfKmy3eUiBXP
         GtYA==
X-Gm-Message-State: APjAAAVyDwAgTRNJtg5DcGvQ+BqdsMkRm6HBfC5i0G1JX84LHYpZPwPl
        PX8OFp7sAo5ila1A4aewkxIbEA==
X-Google-Smtp-Source: APXvYqwfk0eQty195Cfbv+hHT/wlTlKvc80rGaY/BWrCn5EDlE8QxaU6F+qSXsf3HM9jqLV6l68OCA==
X-Received: by 2002:a50:b3fb:: with SMTP id t56mr29768205edd.303.1562740233474;
        Tue, 09 Jul 2019 23:30:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id 91sm1833204wrp.3.2019.07.09.23.30.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 23:30:32 -0700 (PDT)
Subject: Re: [PATCH 2/5] KVM: cpuid: extract do_cpuid_7_mask and support
 multiple subleafs
To:     Jing Liu <jing2.liu@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20190704140715.31181-1-pbonzini@redhat.com>
 <20190704140715.31181-3-pbonzini@redhat.com>
 <5af77de6-3a18-a3b9-b492-c280ac4310a1@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3454d11-97fb-42f2-0a0c-add0456b076c@redhat.com>
Date:   Wed, 10 Jul 2019 08:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5af77de6-3a18-a3b9-b492-c280ac4310a1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/19 09:07, Jing Liu wrote:
>>
> And when adding subleaf 1, plan to add codes,
> 
> case 1:
>     entry->eax |= kvm_cpuid_7_1_eax_x86_features;
>     entry->ebx = entry->ecx = entry->edx =0;
>     break;
> 
> What do you think?

This should be "&=", not "|=".  Otherwise yes, that's the idea.

Paolo

