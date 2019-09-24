Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A66BD1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436598AbfIXSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 14:21:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53598 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392751AbfIXSVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:21:21 -0400
Received: from zn.tnic (p200300EC2F0DB700F545A633E8D0CA22.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b700:f545:a633:e8d0:ca22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 491A01EC0626;
        Tue, 24 Sep 2019 20:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569349279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UE/Kbgw7kSC8XiEQScxsj7WbWMVZZf2X+B/ymGZX+z0=;
        b=RcTKiWyCOmkpFqXCazzni1FtX69pD90PtBHUzOjMfv+F4HbcSqVdWL1s8MLtHoMUCldY/E
        lrJb9M465tpryfvHqByZ+bx5R/VTs9HU63kzSIH1Fz3FsphE71icAO9L3T4oval3MtQcYL
        s6f84Jm249a7+AddYRMtm3IUAiTOmp4=
Date:   Tue, 24 Sep 2019 20:21:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        haitao.huang@intel.com, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kai.svahn@intel.com, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com
Subject: Re: [PATCH v22 04/24] x86/cpu/intel: Detect SGX supprt
Message-ID: <20190924182119.GL19317@zn.tnic>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-5-jarkko.sakkinen@linux.intel.com>
 <20190924161301.GI19317@zn.tnic>
 <20190924174311.GB16218@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924174311.GB16218@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:43:11AM -0700, Sean Christopherson wrote:
> The intent of running on every CPU is to verify MSR_IA32_FEATURE_CONTROL
> is correctly configured on all CPUs.  It's extremely unlikely that
> firmware would misconfigure or fail to write the MSR on only APs, but if
> that does happen we'll spam dmesg and possibly panic or hang the kernel.
> 
> The severity of the fallout is why we're being paranoid.  KVM is similarly
> paranoid about VMX enabling since it'll BUG() on an unexpected fault due
> to a misconfigured FEATURE_CONTROL.

None of that is in the commit message or written anywhere AFAICT. And my
crystal ball doesn't show it either so please write down properly why
this is needed. Better over the function as a comment I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
