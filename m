Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46BDFCDED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfKNSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:39:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNSj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:39:29 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVK1a-0000wV-RF; Thu, 14 Nov 2019 19:39:22 +0100
Date:   Thu, 14 Nov 2019 19:39:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V3 17/20] x86/iopl: Restrict iopl() permission scope
In-Reply-To: <20191114181324.GD7222@zn.tnic>
Message-ID: <alpine.DEB.2.21.1911141939010.29616@nanos.tec.linutronix.de>
References: <20191113204240.767922595@linutronix.de> <20191113210105.369055550@linutronix.de> <20191114181324.GD7222@zn.tnic>
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

On Thu, 14 Nov 2019, Borislav Petkov wrote:
> On Wed, Nov 13, 2019 at 09:42:57PM +0100, Thomas Gleixner wrote:
> > +config X86_IOPL_EMULATION
> > +	bool "IOPL Emulation"
> > +	---help---
> > +	  Legacy IOPL support is an overbroad mechanism which allows user
> > +	  space aside of accessing all 65536 I/O ports also to disable
> > +	  interrupts. To gain this access the caller needs CAP_SYS_RAWIO
> > +	  capabilities and permission from eventually active security
> 
> I think you mean here: s/eventually/potentially/ or so. "eventually" is
> one of the false friends. :)

Fixed
