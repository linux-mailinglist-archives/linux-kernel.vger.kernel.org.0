Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16792E5EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfJZSsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 14:48:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJZSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:48:41 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iOR6y-0000Kt-Pk; Sat, 26 Oct 2019 20:48:28 +0200
Date:   Sat, 26 Oct 2019 20:48:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
In-Reply-To: <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr>
Message-ID: <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr> <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de> <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr> <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
 <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de> <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2102536042-1572115708=:10190"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2102536042-1572115708=:10190
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 26 Oct 2019, Christophe Leroy wrote:
> Le 26/10/2019 à 17:53, Thomas Gleixner a écrit :
> > > > > > gettimeofday:    vdso: 750 nsec/call
> > > > > > 
> > > > > > gettimeofday:    vdso: 1533 nsec/call
> > > > 
> > > > Small improvement (3%) with the proposed change:
> > > > 
> > > > gettimeofday:    vdso: 1485 nsec/call
> > > 
> > > By inlining do_hres() I get the following:
> > > 
> > > gettimeofday:    vdso: 1072 nsec/call
> > 
> > What's the effect for clock_gettime()?
> > 
> > gettimeofday() is suboptimal vs. the PPC ASM variant due to an extra
> > division, but clock_gettime() should be 1:1 comparable.
> > 
> 
> Original PPC asm:
> clock-gettime-realtime:    vdso: 928 nsec/call
> 
> My original RFC:
> clock-gettime-realtime:    vdso: 1570 nsec/call
> 
> With your suggested vdso_calc_delta():
> clock-gettime-realtime:    vdso: 1512 nsec/call
> 
> With your vdso_calc_delta() and inlined do_hres():
> clock-gettime-realtime:    vdso: 1302 nsec/call

That does not make any sense at all.

gettimeofday() is basically the same as clock_gettime(REALTIME) and does
an extra division. So I would expect it to be slower. 

Let's look at the code:

__cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
{
        const struct vdso_data *vd = __arch_get_vdso_data();

        if (likely(tv != NULL)) {
		struct __kernel_timespec ts;

                if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
                        return gettimeofday_fallback(tv, tz);

                tv->tv_sec = ts.tv_sec;
                tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;

IIRC PPC did some magic math tricks to avoid that. Could you just for the
fun of it replace this division with

       (u32)ts.tv_nsec >> 10;

That's obviously incorrect, but it would tell us how heavy the division
is. If that brings us close we might do something special for
gettimeofday().

OTOH, last time I checked clock_gettime() was by far more used than
gettimeofday() but that obviously depends on the use cases.

        }
	...
}

and

__cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
{
        const struct vdso_data *vd = __arch_get_vdso_data();
        u32 msk;

	/* Check for negative values or invalid clocks */
        if (unlikely((u32) clock >= MAX_CLOCKS))
                return -1;

        /*
         * Convert the clockid to a bitmask and use it to check which
         * clocks are handled in the VDSO directly.
         */
        msk = 1U << clock;
        if (likely(msk & VDSO_HRES)) {
		return do_hres(&vd[CS_HRES_COARSE], clock, ts);

So this is the extra code which is executed for clock_gettime(REAL) which
is pure logic and certainly not as heavyweight as the division in the
gettimeofday() code path.

}

static __maybe_unused int
__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
{
        int ret = __cvdso_clock_gettime_common(clock, ts);

	if (unlikely(ret))
                return clock_gettime_fallback(clock, ts);
        return 0;
}

One thing which might be worth to try as well is to mark all functions in
that file as inline. The speedup by the do_hres() inlining was impressive
on PPC.

Thanks,

	tglx

--8323329-2102536042-1572115708=:10190--
