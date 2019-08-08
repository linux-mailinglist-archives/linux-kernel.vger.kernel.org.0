Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96BD85C79
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfHHIIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 04:08:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731658AbfHHIIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:08:00 -0400
Received: from zn.tnic (p200300EC2F0FD700B5ECB790597D1186.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:b5ec:b790:597d:1186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C0461EC0BF2;
        Thu,  8 Aug 2019 10:07:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565251678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rc80BBrVYz2/MVH2OYw1CCPq3Xf4SRzXHnHyfmI+Ffo=;
        b=mtT9v/Qplf9BXzeub/cJvFGzb5d+rlX6FAzg9WDo1HVRQUsdPPE6Wmx3ilgCn1vdNLpM2L
        NXiWro8/CJYra2BMEkIzk2ZVYW+rQi6u2EC2nluLz/PuVKM/AoBUbVUeAcX8BGF2ykTzhO
        rPgUfBdYFKUFAxyQLWmojK1oj0XqloA=
Date:   Thu, 8 Aug 2019 10:08:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
Message-ID: <20190808080841.GA20745@zn.tnic>
References: <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
 <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
 <20190806183333.GA4698@zn.tnic>
 <e86c1f54-092d-6580-7652-cbc4ddade440@intel.com>
 <20190806191559.GB4698@zn.tnic>
 <18004821-577d-b0dd-62b8-13b6f9264e72@intel.com>
 <20190806204054.GD4698@zn.tnic>
 <98eeaa53-d100-28ff-0b68-ba57e0ea90fb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98eeaa53-d100-28ff-0b68-ba57e0ea90fb@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:16:10PM -0700, Reinette Chatre wrote:
> > I'd leave it to tglx to say how we should mirror cache inclusivity in
> > cpuinfo_x86: whether a synthetic X86_FEATURE bit or cache the respective
> > CPUID words which state whether L2/L3 is inclusive...
> 
> Thank you very much. I appreciate your guidance here.

Ok, tglx and I talked it over a bit on IRC: so your 1/10 patch is pretty
close - just leave out the generic struct cacheinfo bits and put the
cache inclusivity property in a static variable there. It will be a
single bit of information only anyway, as this is system-wide and we can
always move it to generic code when some other arch wants it too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
