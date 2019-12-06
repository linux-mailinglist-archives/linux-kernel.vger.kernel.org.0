Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D581B115890
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 22:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLFVXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 16:23:08 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:33869 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfLFVXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LoKaIeDjhZSfcKeTupjxDeuwFFPSIeC+7wDiw8+vuGA=; b=xUYJuXxyqZHxS2jyrinnwMTegV
        8Z8BWJEXsjtj+ogxqnoW1jElqMjMAn2topAivkf6NL5p+LSFPlkDJ/hErKE92jDFfwrB4Bj2xVYPb
        bs8geU58fI+J/OAXMZrHUTtw9buhhi7HJsjmOgIZizEnCnCZEfJOpN1whlFTVmOkd3JGeEKtNJHXZ
        rzmV8bixm8yX9CBgl1gV8AVmBmW4DqZp2nR4ctPqg8xZPwjLIibLDhD77pdQz25mPj5Y97M2heO2O
        kS/3SmrTLUw9EIMcvIyEPkHQLN34RN/duM9DFOGuU27Nv9eDbpAivxbOxspsF8zGzuccqBmagDNAH
        SqszrxzQ==;
Received: from 91-154-92-5.elisa-laajakaista.fi ([91.154.92.5] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@linux.intel.com>)
        id 1idL42-0003Ij-Hu; Fri, 06 Dec 2019 23:23:02 +0200
Date:   Fri, 6 Dec 2019 23:23:01 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Neil Horman <nhorman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v24 01/24] x86/sgx: Update MAINTAINERS
Message-ID: <20191206212301.GF9971@linux.intel.com>
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
 <20191129231326.18076-2-jarkko.sakkinen@linux.intel.com>
 <20191130013824.GA28617@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130013824.GA28617@hmswarspite.think-freely.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 91.154.92.5
X-SA-Exim-Mail-From: jarkko.sakkinen@linux.intel.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 08:38:24PM -0500, Neil Horman wrote:
> On Sat, Nov 30, 2019 at 01:13:03AM +0200, Jarkko Sakkinen wrote:
> > Add the maintainer information for the SGX subsystem.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0154674cbad3..08a67272ed14 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8512,6 +8512,17 @@ F:	Documentation/x86/intel_txt.rst
> >  F:	include/linux/tboot.h
> >  F:	arch/x86/kernel/tboot.c
> >  
> > +INTEL SGX
> > +M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > +M:	Sean Christopherson <sean.j.christopherson@intel.com>
> > +L:	linux-sgx@vger.kernel.org
> > +S:	Maintained
> > +Q:	https://patchwork.kernel.org/project/intel-sgx/list/
> > +T:	git https://github.com/jsakkine-intel/linux-sgx.git
> > +F:	arch/x86/include/uapi/asm/sgx.h
> > +F:	arch/x86/kernel/cpu/sgx/*
> > +K:	\bSGX_
> > +
> >  INTERCONNECT API
> >  M:	Georgi Djakov <georgi.djakov@linaro.org>
> >  L:	linux-pm@vger.kernel.org
> > -- 
> > 2.20.1
> > 
> Wheres patch 12/24?
> Neil

I've had issues with my VPN connection lately. I'll do a repost
next week.

/Jarkko
