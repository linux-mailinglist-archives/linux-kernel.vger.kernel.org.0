Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF31E55837
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfFYT5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 15:57:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFYT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:57:04 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfrYn-0007jr-Nv; Tue, 25 Jun 2019 21:56:57 +0200
Date:   Tue, 25 Jun 2019 21:56:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/boot/64: Fix crash if kernel images crosses page
 table boundary
In-Reply-To: <20190625193053.g5zngehu3ozgzkeg@box>
Message-ID: <alpine.DEB.2.21.1906252155430.32342@nanos.tec.linutronix.de>
References: <20190620112345.28833-1-kirill.shutemov@linux.intel.com> <alpine.DEB.2.21.1906252100290.32342@nanos.tec.linutronix.de> <20190625193053.g5zngehu3ozgzkeg@box>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Kirill A. Shutemov wrote:
> On Tue, Jun 25, 2019 at 09:04:39PM +0200, Thomas Gleixner wrote:
> 
> > > +		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
> > 
> > This part is functionally equivivalent. So what's the value of this change?
> 
> Precedence of operators were broken
> 
> 	idx =  i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
> 
> reads by compiler as
> 
> 	idx = i + ((physaddr >> PMD_SHIFT) % PTRS_PER_PMD);
> 
> not as
> 
> 	idx =  (i + (physaddr >> PMD_SHIFT)) % PTRS_PER_PMD;
> 
> Therefore 'idx' can become >= PTRS_PER_PMD.

Indeed. Please mention it in the change log. I did not spot it right away.

Thanks,

	tglx


