Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A183CD002D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJHRx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:53:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51414 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfJHRx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:53:29 -0400
Received: from zn.tnic (p200300EC2F0B51004985F04ADA683F0C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5100:4985:f04a:da68:3f0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9AF11EC095C;
        Tue,  8 Oct 2019 19:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570557207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/t0Fn1dkz0fQaykC6yWCDyFJtdQCcuQhyKmR491JueY=;
        b=sciuKyVyPaduQ4UbbmjZILO1bXoVkS+2gnuF3Bi6Jaq52jyrmMOGdCHhMDRAzVRLUe2pTH
        YUufHXB+RPY8AQZ9Ed1TanAQi5YDbA4QrE/Z1ZeoIEt5cDHIPovf7xsCXeu4XSfHtVdgcY
        RtJiW7LBpktbWjHUWKFvnSAUa0ik83c=
Date:   Tue, 8 Oct 2019 19:53:19 +0200
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
Subject: Re: [PATCH v22 10/24] x86/sgx: Add sgx_einit() for wrapping
 ENCLS[EINIT]
Message-ID: <20191008175318.GM14765@zn.tnic>
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <20190903142655.21943-11-jarkko.sakkinen@linux.intel.com>
 <20191008173035.GK14765@zn.tnic>
 <20191008174537.GC14020@linux.intel.com>
 <20191008174619.GD14020@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008174619.GD14020@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:46:19AM -0700, Sean Christopherson wrote:
> On Tue, Oct 08, 2019 at 10:45:37AM -0700, Sean Christopherson wrote:
> > On Tue, Oct 08, 2019 at 07:30:35PM +0200, Borislav Petkov wrote:
> > > I was about to ask why isn't this export _GPL() but it goes away in a
> > > later patch.
> > 
> > Speaking of later patches, don't bother reviewing patches 19/24 or 20/20,
> > the vDSO function and selftest respectively.  I'm in the process of
> > reworking them for v23, reviewing them in their current state is likely a
> > waste of your time.
> 
> Gah, 20/24...

Thanks for the heads-up - appreciate it!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
