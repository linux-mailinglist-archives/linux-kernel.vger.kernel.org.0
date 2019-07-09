Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3617963816
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGIOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:43:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45406 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:43:47 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkrLK-00005i-RW; Tue, 09 Jul 2019 16:43:42 +0200
Date:   Tue, 9 Jul 2019 16:43:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
In-Reply-To: <alpine.DEB.2.21.1907071031320.3648@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907091638350.1634@nanos.tec.linutronix.de>
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de> <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com> <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de> <3e9c8e2b-db98-6796-5241-7405f8c57564@redhat.com>
 <alpine.DEB.2.21.1907071031320.3648@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2019, Thomas Gleixner wrote:

> On Fri, 5 Jul 2019, Paolo Bonzini wrote:
> > On 05/07/19 22:25, Thomas Gleixner wrote:
> > > The more interesting question is whether this is all relevant. If I
> > > understood the issue correctly then this is mitigated by proper interrupt
> > > remapping.
> > 
> > Yes, and for Linux we're good I think.  VFIO by default refuses to use
> > the IOMMU if interrupt remapping is absent or disabled, and KVM's own
> 
> Confused. If it does not use IOMMU, what does it do? Hand in the device as
> is and let the guest fiddle with it unconstrained or does it actually
> refuse to pass through?

Read through it and it refuses to attach unless the allow_unsafe_interrupts
option is set, but again we can't protect against wilful ignorance.

So the default prevents abuse on systems without IOMMU and irq remapping,
so there is not much to worry about AFAICT.

Setting TPR to 1 and fixing the comments/changelogs still makes sense
independently.

Thanks,

	tglx
