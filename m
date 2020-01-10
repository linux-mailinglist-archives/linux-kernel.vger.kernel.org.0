Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3E136950
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgAJJAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 04:00:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54820 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgAJJAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:00:41 -0500
Received: from zn.tnic (p200300EC2F0ACA007185EBC54541D9EE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:7185:ebc5:4541:d9ee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DABD71EC0CBB;
        Fri, 10 Jan 2020 10:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578646840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mTMlzOe0+DyrJHAHZBzt5QDKd6QMgD0mHD/ALQs24cc=;
        b=QPyZK2TuKZ6HqfcX/2Ov9RD+NKTt/aXONZiylnZVk+a5paDBBn6SMOgpRQ6GXf2JWIpTzC
        zjP1dt3mzCjPCSOIuYxzOkNrWq7pLNMNLcEYRrgyGt38D4GRkCBfpMyrzxQcml8Eoczxk0
        kJCufAyrDrR08Ejndq07PBsZqqr0p8I=
Date:   Fri, 10 Jan 2020 10:00:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200110090032.GB19453@zn.tnic>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic>
 <20200109204638.GA523773@rani.riverdale.lan>
 <CAFH1YnNA9qfM4tPzKKDaQD6DPxnE=tJsB7AUZQBohDTW3zm=Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFH1YnNA9qfM4tPzKKDaQD6DPxnE=tJsB7AUZQBohDTW3zm=Xg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:27:02AM +0800, Zhenzhong Duan wrote:
> Yes. Will you send this formally?

And then a flood of fix-this-trivial-warning patches ensues?

You should know that they have the lowest prio when it comes to looking
at them.

> Not clear if there is other reason making KBUILD_CFLAGS for
> arch/x86/boot/compressed different from other part.

Maybe because the kernel proper build system should not break the
compressed kernel's build as the two are quite different... maybe for
historical raisins...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
