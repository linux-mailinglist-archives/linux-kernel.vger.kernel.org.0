Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68B81368EE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgAJI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 03:27:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgAJI1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:27:08 -0500
Received: from zn.tnic (p200300EC2F0ACA007185EBC54541D9EE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:7185:ebc5:4541:d9ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BE811EC0CAD;
        Fri, 10 Jan 2020 09:27:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578644827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=thsT2Ib6pOGGPEREvb10XVWQL+6ZSHA8kOKKSpRzIdI=;
        b=KuxjUeQznR8vzHnCFnVG3CD/Jql+AIpM3j5xn6KAFZDAYmAOWJdOareO++O69UyILt4Pz8
        y2pRyPSqlXCwCEImnaPUe35x/aS5NVon/MriwGz0nUS1v1riAeckjgwvKSQ4vopyCrloga
        N9b1rwAx8BsEfWyeGp3jCxowNdl/WnU=
Date:   Fri, 10 Jan 2020 09:27:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200110082700.GA19453@zn.tnic>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic>
 <20200109204638.GA523773@rani.riverdale.lan>
 <20200109205041.GJ5603@zn.tnic>
 <CAFH1YnNdmHD9rnriTVx-se-Z5MHsgUZ0jYWMrg6OYVjr4Ap+JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFH1YnNdmHD9rnriTVx-se-Z5MHsgUZ0jYWMrg6OYVjr4Ap+JQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:09:38AM +0800, Zhenzhong Duan wrote:
> I indeed used additional parameters as below for daily build.
> # make O=/build/kernel/ -j4 EXTRA_CFLAGS=-Wall binrpm-pkg

And in no point in time it did occur to you that you should mention this
important piece of information in your commit message so that a person
looking at the patch knows how you triggered it?!?

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
