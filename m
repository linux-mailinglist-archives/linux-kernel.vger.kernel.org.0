Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01CF83A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 22:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHFUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 16:40:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50826 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfHFUkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 16:40:12 -0400
Received: from zn.tnic (p200300EC2F136900E5DBE4FCCFA1B2C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:6900:e5db:e4fc:cfa1:b2c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D4C91EC0C31;
        Tue,  6 Aug 2019 22:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565124010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k4zPEwmdmht2EGq4uiNoEqfggbjI7/dfnEuVWNCrSl8=;
        b=S4i3zgRzIS1zEMycqQXBxTCT02zf9q0IgcLoogzyYT7buX+V7yZA6sFTMqE6LHSsVijHvl
        7worZi2ZQlJT3AkYpQBKQvDnHdL1ozUUm7sMfqOed3PbPpIfDFVoQDqHq6d+zZkTFgtogh
        JazyuJARKoTFcQul5T9t6sqpBdQTcOU=
Date:   Tue, 6 Aug 2019 22:40:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190806204054.GD4698@zn.tnic>
References: <20190803094423.GA2100@zn.tnic>
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
 <20190806191559.GB4698@zn.tnic>
 <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:22:22PM -0700, Reinette Chatre wrote:
> ... because some platforms differ in which SKUs support cache
> pseudo-locking. On these platforms only the SKUs with inclusive cache
> support cache pseudo-locking, thus the additional check.

Ok, so it sounds to me like that check in get_prefetch_disable_bits()
should be extended (and maybe renamed) to check for cache inclusivity
too, in order to know which platforms support cache pseudo-locking.
I'd leave it to tglx to say how we should mirror cache inclusivity in
cpuinfo_x86: whether a synthetic X86_FEATURE bit or cache the respective
CPUID words which state whether L2/L3 is inclusive...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
