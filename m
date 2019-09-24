Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB4BBFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 03:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503864AbfIXBYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 21:24:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503852AbfIXBYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:24:30 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54A81C057EC6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 01:24:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r187so215555wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Kh47YIewkbENbNlBISmf1v6nAO/ZKvNmZeXMUMYf0k=;
        b=QArHehUpS2yPyDIql3uWmIEDFSW5uC4osdFaD10wcHYVFs/KawENWcuzS92F3SgQek
         Xa1KQPRXsFCIC/O7kmpggJPQzt1t4LXYvKg45VXLY8HXJ0o7RvEz00RvL8l7zLgdouRE
         R2aXskONNO/cZkTMjrQ0NarD290O2U4098V94NAng0OVKW5GeirefBI8n/5ragzo2Hd9
         FBfQm5ApaXU1DCxQmKHANa8qaJLt9mw5RreRzKvqUZ8vKU/enZ3HhQlyzZe1csQMNmVr
         z9PZu9XuBtVUDVfuIpfZpQsjdxuqDkm/bn4G2HR62CB1mcar3WHqN5OSCYXrCGxuiw9B
         dQfQ==
X-Gm-Message-State: APjAAAWTB5gnXZ1iHqY+QD0UyCNZW2gUwmkcjXzQ1dMZxoml+Jcv78t0
        DUZb3JMPtXIDpq8s72KGIxRZoWns6rVoGnheI3WwUkZPgb5UPATeXRTQVVw+yoIonShuzkScJh0
        bWGX4HQSscTKv6VaLhrfEYKqc
X-Received: by 2002:adf:c58b:: with SMTP id m11mr138605wrg.252.1569288268894;
        Mon, 23 Sep 2019 18:24:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRII0EJw95wZVOcvvmB/RtoZVMvjh+6kvorgSFu8xaDuTqYzxLieJS2EkMPfjHfVlYgiaP5A==
X-Received: by 2002:adf:c58b:: with SMTP id m11mr138594wrg.252.1569288268651;
        Mon, 23 Sep 2019 18:24:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id o12sm234071wrm.23.2019.09.23.18.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 18:24:28 -0700 (PDT)
Subject: Re: [PATCH 13/17] KVM: monolithic: x86: drop the kvm_pmu_ops
 structure
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-14-aarcange@redhat.com>
 <057fc5f2-7343-943f-ed86-59f1ad5122e5@redhat.com>
 <20190924005152.GA4658@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <aa31edbb-6082-1b95-4d65-059351ac4884@redhat.com>
Date:   Tue, 24 Sep 2019 03:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924005152.GA4658@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/19 02:51, Andrea Arcangeli wrote:
> This was covered in the commit header of patch 2:

Oops, sorry.

> Lot more patches are needed to get rid of kvm_x86_ops entirely because
> there are lots of places checking the actual value of the method
> before making the indirect call. I tried to start that, but then it
> got into potentially heavily rejecting territory, so I thought it was
> simpler to start with what I had, considering from a performance
> standpoint it's optimal already as far as retpolines are concerned.

The performance may be good enough, but the maintainability is bad.
Let's make a list of function pointers that are checked, and function
pointers that are written at init time.

For the former, it should be possible to make them __weak symbols so
that they are NULL if undeclared.  For the latter, module parameters can
be made extern and then you can have checks like kvm_x86_has_...() in
inline functions in a header file.

Paolo
