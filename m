Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2D173CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1QYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:24:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34050 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1QYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:24:00 -0500
Received: from zn.tnic (p200300EC2F084600F4D7BC1685508240.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:4600:f4d7:bc16:8550:8240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10A0F1EC0CF6;
        Fri, 28 Feb 2020 17:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582907039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cdbBnTgYTQoXKrYT3pTGtwBJB6vH0ncPdNFJY+NQKms=;
        b=Fz2efFjSnnzpY0qvIANeKMAog/lwwfY8wsaH8gtChXojbks69plYzmLa0f8/G0enazIUSH
        m18K0Dja0v4E34ZKMG60rhNYWzEEcIRM9lFQbEasv4YyP8x6lNYcO6GnAstONRNSJuuWl6
        QqNqC74kGXYAvDmxHg6PvE0D3+GVSkE=
Date:   Fri, 28 Feb 2020 17:23:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200228162359.GC25261@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-9-yu-cheng.yu@intel.com>
 <20200221175859.GL25747@zn.tnic>
 <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
 <20200228121724.GA25261@zn.tnic>
 <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:53:38AM -0800, Yu-cheng Yu wrote:
> Yes, saving only supervisor states is optimal, but doing XSAVES with a
> partial RFBM changes xcomp_bv.

... and that means what exactly in plain english?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
