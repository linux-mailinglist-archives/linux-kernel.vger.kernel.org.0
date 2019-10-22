Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902E0E05EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbfJVOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 10:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388191AbfJVOE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:04:58 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8208C0021D7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:04:57 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id z5so4495388wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRXx0prZyWf8Ie3WBmFM/bIRv9+8DKKzcw/xRf9RZ/k=;
        b=kOjUQ5PNQ5MbBZkhOCMHlRLO1cs9tbqpROuldXMn5PW9yocBNIXk9d9UnmRZqebDAr
         rXpMJ0tgLCC2chfpeZb9kHU3HmYqaL7Gqocdy/6DUE8MvVFpFJGz8QaTEUaHNdQXRnqG
         28djvW9s2NXvR6ZSIV/rCBSic5xGhLd86aeaJcuej+IFP1zs3H6bp437Ak9F4ZAYVZov
         gg0FeRsAHrtFfhIYrIVU5RAgraWwmYhiKyZSpvsLZdkAxyzgMVXxrrIPEU/3l2CiyBoo
         pnZoTpZaLTy5DD8/TJJ/5zrUFkVbcW84A5TPVbz1Zj+e8zZCi6x3Gg8pzXLjony3jRNf
         4BqA==
X-Gm-Message-State: APjAAAVdgvoTZ4xAiXHhwtnaYUCFptjfNC7hCR31mtrQsoGrMfg7JMTN
        lQLz0DItDC1W45/vH0YPtc/v7xAMeHh3jUF1TZyITnEPYAtxBLWStoZVyNHcyAzLKwY6BRpt6RT
        2wqVqF3icVmSDgNgO8dTZ4uZh
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr3319575wmc.84.1571753096251;
        Tue, 22 Oct 2019 07:04:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWqRcFVSe00YfZqVULXyrnOBOt0DAtwntm2KhRrr6N6A/cSYud38QIAc8/I73DEBmlFbuFZw==
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr3319555wmc.84.1571753095982;
        Tue, 22 Oct 2019 07:04:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id b196sm11755492wmd.24.2019.10.22.07.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:04:55 -0700 (PDT)
Subject: Re: [PATCH v2 00/15] KVM: Dynamically size memslot arrays
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20191022003537.13013-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <129444cc-5211-5b60-15fc-0f0fe998f023@redhat.com>
Date:   Tue, 22 Oct 2019 16:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022003537.13013-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/19 02:35, Sean Christopherson wrote:
> The end goal of this series is to dynamically size the memslot array so
> that KVM allocates memory based on the number of memslots in use, as
> opposed to unconditionally allocating memory for the maximum number of
> memslots.  On x86, each memslot consumes 88 bytes, and so with 2 address
> spaces of 512 memslots, each VM consumes ~90k bytes for the memslots.
> E.g. given a VM that uses a total of 30 memslots, dynamic sizing reduces
> the memory footprint from 90k to ~2.6k bytes.
> 
> The changes required to support dynamic sizing are relatively small,
> e.g. are essentially contained in patches 12/13 and 13/13.  Patches 1-11
> clean up the memslot code, which has gotten quite crusy, especially
> __kvm_set_memory_region().  The clean up is likely not strictly necessary
> to switch to dynamic sizing, but I didn't have a remotely reasonable
> level of confidence in the correctness of the dynamic sizing without first
> doing the clean up.
> 
> Testing, especially non-x86 platforms, would be greatly appreciated.  The
> non-x86 changes are for all intents and purposes untested, e.g. I compile
> tested pieces of the code by copying them into x86, but that's it.  In
> theory, the vast majority of the functional changes are arch agnostic, in
> theory...
> 
> v2:
>   - Split "Drop kvm_arch_create_memslot()" into three patches to move
>     minor functional changes to standalone patches [Janosch].
>   - Rebase to latest kvm/queue (f0574a1cea5b, "KVM: x86: fix ...")
>   - Collect an Acked-by and a Reviewed-by

I only have some cosmetic changes on patches 14-15.  Let's wait for
testing results.

Paolo
