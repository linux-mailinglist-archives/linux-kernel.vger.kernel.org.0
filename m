Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB0124CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLRQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 11:18:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfLRQS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:18:28 -0500
Received: from zn.tnic (p200300EC2F0B8B009D1D67E59157F47A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8b00:9d1d:67e5:9157:f47a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 640811EC05B0;
        Wed, 18 Dec 2019 17:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576685907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mYgMkr+bARNjL6EZJiJMKopGv36OxLWLBBdhBNmcynU=;
        b=mB6F5CRI3SPwmtL9swsspuLi/U1OMA8fOzm10p2XewVSTpv6+f1wTPhPrtzbQQ1sZFdPoH
        7vNT/CCa4IuLTlJoxWFTaMdR78PXSQO+ccx/x4lFkxHrjvHyD+khwE+6mrK43Hjf0lTFTI
        QdR8UTJ+AGBCLT2fehDS6SoQb8JGg7M=
Date:   Wed, 18 Dec 2019 17:18:21 +0100
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
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v24 08/24] x86/sgx: Enumerate and track EPC sections
Message-ID: <20191218161821.GG24886@zn.tnic>
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
 <20191129231326.18076-9-jarkko.sakkinen@linux.intel.com>
 <20191218091856.GA24886@zn.tnic>
 <20191218151944.GA25201@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218151944.GA25201@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 07:19:44AM -0800, Sean Christopherson wrote:
> Yes, EPC pages are architecturally defined to be 4k sized and aligned.
> 
>   36.5 Enclave Page Cache
> 
>   The EPC is divided into EPC pages. An EPC page is 4KB in size and always
>   aligned on a 4KB boundary.

Aha, thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
