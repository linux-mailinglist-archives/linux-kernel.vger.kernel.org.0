Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4391A5EE8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 23:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfGCVag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 17:30:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56928 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:30:36 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1himpl-0001Uy-5x; Wed, 03 Jul 2019 23:30:33 +0200
Date:   Wed, 3 Jul 2019 23:30:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static
 key
In-Reply-To: <F521E659-4F8A-44FC-994B-5B9E2B229184@vmware.com>
Message-ID: <alpine.DEB.2.21.1907032324020.1802@nanos.tec.linutronix.de>
References: <20190703105431.096822793@linutronix.de> <20190703105917.044463061@linutronix.de> <1DC35A28-DEBC-4A46-AC35-3AADD23AA40D@vmware.com> <alpine.DEB.2.21.1907032213250.1802@nanos.tec.linutronix.de> <F521E659-4F8A-44FC-994B-5B9E2B229184@vmware.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-749829697-1562189433=:1802"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-749829697-1562189433=:1802
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jul 2019, Nadav Amit wrote:
> > On Jul 3, 2019, at 1:34 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 3 Jul 2019, Nadav Amit wrote:
> >>> On Jul 3, 2019, at 3:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> void default_send_IPI_all(int vector)
> >>> {
> >>> -	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
> >>> +	if (static_branch_likely(&apic_use_ipi_shorthand)) {
> >>> 		apic->send_IPI_mask(cpu_online_mask, vector);
> >>> 	} else {
> >>> 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
> >> 
> >> It may be better to check the static-key in native_send_call_func_ipi() (and
> >> other callers if there are any), and remove all the other checks in
> >> default_send_IPI_all(), x2apic_send_IPI_mask_allbutself(), etc.
> > 
> > That makes sense. Should have thought about that myself, but hunting that
> > APIC emulation issue was affecting my brain obviously :)
> 
> Well, if you used VMware and not KVM... ;-)

Then I would have hunted some other bug probably :)
 
> >> void native_send_call_func_ipi(const struct cpumask *mask)
> >> {
> >> -	cpumask_var_t allbutself;
> >> -
> >> -	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
> >> -		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
> >> -		return;
> >> +	int cpu, this_cpu = smp_processor_id();
> >> +	bool allbutself = true;
> >> +	bool self = false;
> >> +
> >> +	for_each_cpu_and_not(cpu, cpu_online_mask, mask) {
> >> +
> >> +		if (cpu != this_cpu) {
> >> +			allbutself = false;
> >> +			break;
> >> +		}
> >> +		self = true;
> > 
> > That accumulates to a large iteration in the worst case. 
> 
> I don’t understand why. There should be at most two iterations - one for
> self and one for another core. So _find_next_bit() will be called at most
> twice. _find_next_bit() has its own loop, but I don’t think overall it is as

Indeed, misread the code and right the bit search should be fast.

> bad as calling alloc_cpumask_var(), cpumask_copy() and cpumask_equal(),
> which also have loops.
>
> I don’t have numbers (and I doubt they are very significant), but the cpumask
> allocation showed when I was profiling my microbenchmark.

Yes, that alloc/free part is completely bogus.

Thanks,

	tglx

--8323329-749829697-1562189433=:1802--
