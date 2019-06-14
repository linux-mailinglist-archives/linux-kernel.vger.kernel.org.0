Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E846029
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfFNOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 10:10:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFNOKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:10:19 -0400
Received: from zn.tnic (p200300EC2F097F0010F3CEDA9C41B474.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:10f3:ceda:9c41:b474])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 208851EC0911;
        Fri, 14 Jun 2019 16:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560521418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m8x7R9c/EDsa4nv2hfjxZO5gkYQUphth/JS0Fj6Jfn0=;
        b=Sc4aN3oypEBEVK7xUH5ByZG+btRqYLVrnG7IwSqFefujK2n8NtFKwQaA2Yc0eqbsNWEZhi
        Qd7P2GwdcY56CClCgensKa6JWB05g3qCADjUn4AiM89m+qt8HHcF0QBNClutng4QM/B9Rd
        KeaADvNGn3fS9HfseCcZsmRD338mIqQ=
Date:   Fri, 14 Jun 2019 16:10:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614141010.GG2586@zn.tnic>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614135105.GB198207@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614135105.GB198207@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:51:05AM -0700, Fenghua Yu wrote:
> CPUID_7_1_EAX is defined in patch 0003. Should I combine patch 0002 and 0003
> into one patch?

That was just an example diff. Generally, patches should do one logical
thing. In this case, I'd suggest you make the kvm change the first and
separate patch, from the other three.

> Need to check CPUID_LNX_2 and CPUID_LNX_3 as well?

Yes, all linux-defined feature words.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
