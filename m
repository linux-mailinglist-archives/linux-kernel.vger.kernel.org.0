Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B74ECF5B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfJHJJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 05:09:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbfJHJJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:09:43 -0400
Received: from zn.tnic (p200300EC2F0B510054990CC7734BB19B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5100:5499:cc7:734b:b19b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B0CA1EC0586;
        Tue,  8 Oct 2019 11:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570525781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qt4hy0nHJpZzoW+FdanfkOoQrJ3VcoxYAWMats/0cuY=;
        b=d86V74O523mB29Lrfe7xMwqw93h5ms5psG6yR7hcCoIgxSi5PEiyu47/agTwTCT/IIbWt8
        BIPm+2KnntWEpPpFkLTdYVjBIJGPdxzc8Fx1QGdGlywjgUm9KrGXOXOAK2Hv55GNrYdbnX
        jAVfXJiG0V9CQyCuFjQXb2IFyFQxr34=
Date:   Tue, 8 Oct 2019 11:09:31 +0200
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
Subject: Re: [PATCH v22 09/24] x86/sgx: Add functions to allocate and free
 EPC pages
Message-ID: <20191008090931.GC14765@zn.tnic>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-10-jarkko.sakkinen@linux.intel.com>
 <20191005164408.GB25699@zn.tnic>
 <20191007145011.GA18016@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007145011.GA18016@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 07:50:11AM -0700, Sean Christopherson wrote:
> The caller is responsible for ensuring EREMOVE can be safely executed,
> e.g. by holding the enclave's lock.

lockdep_assert_held() here maybe?

> For many ENCLS leafs, EREMOVE included, the CPU requires exclusive access
> to the SGX Enclave Control Structures (SECS)[*] and will signal a #GP if
> a different logical CPU is already executing an ENCLS leaf that requires
> exclusive SECS access.  The SGX subsystem uses a per-enclave mutex to
> serialize such ENCLS leafs, among other things.
>
> [*] The SECS is a per-enclave page that resides in the EPC and can only be
>     directly accessed by the CPU.  It's used to track metadata about the
>     enclave, e.g. number of child pages, base, size, etc...

Ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
