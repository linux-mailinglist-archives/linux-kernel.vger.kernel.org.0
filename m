Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344A79694D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfHTTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 15:23:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52886 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfHTTXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:23:09 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i09ig-0004qc-Fs; Tue, 20 Aug 2019 21:23:02 +0200
Date:   Tue, 20 Aug 2019 21:23:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
In-Reply-To: <e7002524-2572-57af-176a-d6b924c98738@shipmail.org>
Message-ID: <alpine.DEB.2.21.1908202122420.2223@nanos.tec.linutronix.de>
References: <20190818143316.4906-1-thomas_os@shipmail.org> <20190818143316.4906-3-thomas_os@shipmail.org> <20190820113203.GM2332@hirez.programming.kicks-ass.net> <597132a4-2514-2f13-5786-b423d82b7fd4@shipmail.org> <alpine.DEB.2.21.1908201540400.2223@nanos.tec.linutronix.de>
 <e7002524-2572-57af-176a-d6b924c98738@shipmail.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1379392158-1566328982=:2223"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1379392158-1566328982=:2223
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Aug 2019, Thomas Hellström (VMware) wrote:
> On 8/20/19 3:42 PM, Thomas Gleixner wrote:
> > > What confuses me a bit is, if it's clarity we're after, why don't people
> > > use
> > > 
> > > #define VMWARE_HYPERCALL 					\
> > > 	ALTERNATIVE_2("inl (%%dx)", 				\
> > > 		      "vmcall", X86_FEATURE_VMW_VMCALL,		\	
> > > 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
> > > 
> > > Seems to build fine here. Is it fear of old assemblers not supporting, for
> > > example vmmcall
> > The requirement for binutils is version >= 2.21. If 2.21 supports vmcall and
> > vmmcall all good.
> > 
> > Thanks,
> > 
> > 	tglx
> 
> So I tested 2.20.1 and 2.21.1 from ftp.gnu.org/gnu/binutils, and both seem to
> assemble (as-new) and disassemble (objdump -S) vmcall and vmmcall fine so I
> think we should be OK using the mnemonic format then.

Perfect!
--8323329-1379392158-1566328982=:2223--
