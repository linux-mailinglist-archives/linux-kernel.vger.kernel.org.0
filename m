Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB4475B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfFPQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 12:07:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfFPQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:07:16 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcXgU-00025J-GU; Sun, 16 Jun 2019 18:07:10 +0200
Date:   Sun, 16 Jun 2019 18:07:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
In-Reply-To: <2ca2aa50-ed07-c59f-2fec-bf9596281f30@infradead.org>
Message-ID: <alpine.DEB.2.21.1906161805360.1760@nanos.tec.linutronix.de>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com> <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de> <2ca2aa50-ed07-c59f-2fec-bf9596281f30@infradead.org>
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

On Sun, 16 Jun 2019, Randy Dunlap wrote:
> On 6/13/19 11:54 PM, Thomas Gleixner wrote:
> > +
> > +There exist two mechanisms to read and write the FS/FS base address:
> 
> should this be...                                   FS/GS

Indeed.

> > +FSGSBASE instructions enablement
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > + The instructions are enumerated in CPUID leaf 7, bit 0 of EBX. If
> > + available /proc/cpuinfo shows 'fsgsbase' in the flag entry of the CPUs.
> > +
> > + The availability of the instructions is not enabling them
> 
> prefer:                                  does not enable them

ok.

> > + automatically. The kernel has to enable them explicitely in CR4. The
> 
> typo:                                            explicitly

ok.

Randy, thanks for reviewing that!


       tglx
