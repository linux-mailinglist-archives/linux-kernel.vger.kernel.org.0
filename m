Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2DBBF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503608AbfIXAQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 20:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503595AbfIXAQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:16:40 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36ABCC049E32
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 00:16:40 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b6so29002wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0UXLU1GiG9GRzblHITT/kKxOAXLFHZe9KDWnxtoZOGA=;
        b=kRWcJ9/uhSrlIhoLJqlN0nfq2MrECl4XBtLSKKmbwvi8vNxqPmjq9QRiQ7eImcWPaC
         o3DcsJlCHiiXJUqr7GgIRvBjhGeNy+BXFsdKPxaXfCKj27HNyjI05/oCgOt6DMruMHKl
         3/c7jrn1H62SmmezF3Xf9CiZoo1BTdFraSXYC18sKwt9o7mLPXoBBGQju/m09vm+TRLa
         pvoMADsqr7APCF5eyKQ7w09XAhFEtdjqD9NyzePNxjWgVwNDSojCn/xChNRBUeAiU9cY
         QeSRiDix055rPC1bruJZBJ8TtwY/xKvIoW0EU3fBqZwV+z7Hv9k2/Yl1cRVzQVd4QyoL
         Q1sA==
X-Gm-Message-State: APjAAAW+PiGH8yJLkqmNQHb7sl40gaqaUzYZe4rvH0EcJA73eQaV8PyB
        aQvoinxJmQSlsiBMmEr6NzZ/VkJFZfmlCQxEtavJ0715mtbTi2t3pcM3StA7tKxPso1ufmHfIi1
        QtBGPVWslC2GkBRmKJ3up9wGG
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr160868wmc.140.1569284198725;
        Mon, 23 Sep 2019 17:16:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuhYEIpCLaIhhJwLlMrVqI8HUjBy2gaKWE6B54jqPQVSetTSpKm+thCwJsN4HqBygNpzUWyQ==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr160853wmc.140.1569284198377;
        Mon, 23 Sep 2019 17:16:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id s12sm48776wra.82.2019.09.23.17.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:16:37 -0700 (PDT)
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
 <20190923190514.GB19996@redhat.com> <20190923202349.GL18195@linux.intel.com>
 <20190923210838.GA23063@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b58d2305-284f-8652-a0f3-380b26642fe0@redhat.com>
Date:   Tue, 24 Sep 2019 02:16:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923210838.GA23063@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 23:08, Andrea Arcangeli wrote:
> The two most attractive options to me remains what I already have
> implemented under #ifdef CONFIG_RETPOLINE with direct calls
> (optionally replacing the "if" with a small "switch" still under
> CONFIG_RETPOLINE if we give up the prioritization of the checks), or
> the replacement of kvm_vmx_exit_handlers with a switch() as suggested
> by Vitaly which would cleanup some code.
> 
> The intermediate solution that makes "const" work, has the cons of
> forcing to parse EXIT_REASON_VMCLEAR and the other vmx exit reasons
> twice, first through a pointer to function (or another if or switch
> statement) then with a second switch() statement.

I agree.  I think the way Andrea did it in his patch may not the nicest
but is (a bit surprisingly) the easiest and most maintainable.

Paolo
