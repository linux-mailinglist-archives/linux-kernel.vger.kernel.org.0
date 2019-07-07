Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1737561477
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGGIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 04:37:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfGGIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 04:37:17 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hk2fa-0002mj-Ma; Sun, 07 Jul 2019 10:37:14 +0200
Date:   Sun, 7 Jul 2019 10:37:13 +0200 (CEST)
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
In-Reply-To: <3e9c8e2b-db98-6796-5241-7405f8c57564@redhat.com>
Message-ID: <alpine.DEB.2.21.1907071031320.3648@nanos.tec.linutronix.de>
References: <20190704155145.617706117@linutronix.de> <20190704155608.636478018@linutronix.de> <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com> <alpine.DEB.2.21.1907052213360.3648@nanos.tec.linutronix.de> <3e9c8e2b-db98-6796-5241-7405f8c57564@redhat.com>
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

On Fri, 5 Jul 2019, Paolo Bonzini wrote:
> On 05/07/19 22:25, Thomas Gleixner wrote:
> > The more interesting question is whether this is all relevant. If I
> > understood the issue correctly then this is mitigated by proper interrupt
> > remapping.
> 
> Yes, and for Linux we're good I think.  VFIO by default refuses to use
> the IOMMU if interrupt remapping is absent or disabled, and KVM's own

Confused. If it does not use IOMMU, what does it do? Hand in the device as
is and let the guest fiddle with it unconstrained or does it actually
refuse to pass through?

> (pre-VFIO) IOMMU support was removed a couple years ago.  I guess the
> secure boot lockdown patches should outlaw VFIO's
> allow_unsafe_interrupts option, but that's it.

I'm not worried too much about command line options. The important thing is
the default behaviour. If an admin decides to do something stupid, so be
it.

Thanks,

	tglx
