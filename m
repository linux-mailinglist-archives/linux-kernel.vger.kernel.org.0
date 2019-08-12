Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E08B8981F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfHLHqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:46:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:49821 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfHLHqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:46:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 00:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="183488324"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2019 00:46:51 -0700
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
 <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
 <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com>
 <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
 <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <1803ad97-74f4-28c6-58c8-c52b3d1e5b1f@linux.intel.com>
Date:   Mon, 12 Aug 2019 15:46:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/9 20:54, Thomas Gleixner wrote:
> Some newer machines do not advertise legacy timers. The kernel can handle
> that situation if the TSC and the CPU frequency are enumerated by CPUID or
> MSRs and the CPU supports TSC deadline timer. If the CPU does not support
> TSC deadline timer the local APIC timer frequency has to be known as well.
> 
> Some Ryzens machines do not advertize legacy timers, but there is no
> reliable way to determine the bus frequency which feeds the local APIC
> timer when the machine allows overclocking of that frequency.

Are these platforms are all ACPI HW-reduced platform?

> 
> As there is no legacy timer the local APIC timer calibration crashes due to
> a NULL pointer dereference when accessing the not installed global clock
> event device.
> 
> Switch the calibration loop to a non interrupt based one, which polls
> either TSC (frequency known) or jiffies. The latter requires a global
> clockevent. As the machines which do not have a global clockevent installed
> have a known TSC frequency this is a non issue. For older machines where
> TSC frequency is not known, there is no known case where the legacy timers
> do not exist as that would have been reported long ago.
> 
> Reported-by: Daniel Drake <drake@endlessm.com>
> Reported-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> 
> Note: Only lightly tested, but of course not on an affected machine.
> 
>       If that works reliably, then this needs some exhaustive testing
>       on a wide range of systems so we can risk backports to stable
>       kernels.
> 
> ---
>  arch/x86/kernel/apic/apic.c |   70 +++++++++++++++++++++++++++++++++-----------
>  include/linux/acpi_pmtmr.h  |   10 ++++++
>  2 files changed, 64 insertions(+), 16 deletions(-)
> 
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -851,7 +851,8 @@ bool __init apic_needs_pit(void)
>  static int __init calibrate_APIC_clock(void)
>  {
>  	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
> -	void (*real_handler)(struct clock_event_device *dev);
> +	u64 tsc_perj = 0, tsc_start = 0;
> +	unsigned long jif_start;
>  	unsigned long deltaj;
>  	long delta, deltatsc;
>  	int pm_referenced = 0;
> @@ -878,29 +879,65 @@ static int __init calibrate_APIC_clock(v
>  	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
>  		    "calibrating APIC timer ...\n");
>  
> -	local_irq_disable();
> -
> -	/* Replace the global interrupt handler */
> -	real_handler = global_clock_event->event_handler;
> -	global_clock_event->event_handler = lapic_cal_handler;
> +	/*
> +	 * There are platforms w/o global clockevent devices. Instead of
> +	 * making the calibration conditional on that, use a polling based
> +	 * approach everywhere.
> +	 */
>  
> +	local_irq_disable();
>  	/*
>  	 * Setup the APIC counter to maximum. There is no way the lapic
>  	 * can underflow in the 100ms detection time frame
>  	 */
>  	__setup_APIC_LVTT(0xffffffff, 0, 0);
>  
> -	/* Let the interrupts run */
> -	local_irq_enable();
> +	/*
> +	 * Methods to terminate the calibration loop:
> +	 *  1) Global clockevent if available (jiffies)
> +	 *  2) TSC if available and frequency is known
> +	 */
> +	jif_start = READ_ONCE(jiffies);
> +
> +	if (tsc_khz) {
> +		tsc_start = rdtsc();
> +		tsc_perj = div_u64((u64)tsc_khz * 1000, HZ);
> +	}
> +
> +	while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {

Is this loop still meaningful, can we just invoke the handler twice
before and after the tick?

Thanks,
-Aubrey

> +		/*
> +		 * Enable interrupts so the tick can fire, if a global
> +		 * clockevent device is available
> +		 */
> +		local_irq_enable();
>  
> -	while (lapic_cal_loops <= LAPIC_CAL_LOOPS)
> -		cpu_relax();
> +		/* Wait for a tick to elapse */
> +		while (1) {
> +			if (tsc_khz) {
> +				u64 tsc_now = rdtsc();
> +				if ((tsc_now - tsc_start) >= tsc_perj) {
> +					tsc_start += tsc_perj;
> +					break;
> +				}
> +			} else {
> +				unsigned long jif_now = READ_ONCE(jiffies);
> +
> +				if (time_after(jif_now, jif_start)) {
> +					jif_start = jif_now;
> +					break;
> +				}
> +			}
> +			cpu_relax();
> +		}
> +
> +		/* Invoke the calibration routine */
> +		local_irq_disable();
> +		lapic_cal_handler(NULL);
> +		local_irq_enable();
> +	}
>  
>  	local_irq_disable();
>  
> -	/* Restore the real event handler */
> -	global_clock_event->event_handler = real_handler;
> -
>  	/* Build delta t1-t2 as apic timer counts down */
>  	delta = lapic_cal_t1 - lapic_cal_t2;
>  	apic_printk(APIC_VERBOSE, "... lapic delta = %ld\n", delta);
> @@ -943,10 +980,11 @@ static int __init calibrate_APIC_clock(v
>  	levt->features &= ~CLOCK_EVT_FEAT_DUMMY;
>  
>  	/*
> -	 * PM timer calibration failed or not turned on
> -	 * so lets try APIC timer based calibration
> +	 * PM timer calibration failed or not turned on so lets try APIC
> +	 * timer based calibration, if a global clockevent device is
> +	 * available.
>  	 */
> -	if (!pm_referenced) {
> +	if (!pm_referenced && global_clock_event) {
>  		apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
>  
>  		/*
> --- a/include/linux/acpi_pmtmr.h
> +++ b/include/linux/acpi_pmtmr.h
> @@ -18,6 +18,11 @@
>  extern u32 acpi_pm_read_verified(void);
>  extern u32 pmtmr_ioport;
>  
> +static inline bool acpi_pm_timer_available(void)
> +{
> +	return pmtmr_ioport != 0;
> +}
> +
>  static inline u32 acpi_pm_read_early(void)
>  {
>  	if (!pmtmr_ioport)
> @@ -28,6 +33,11 @@ static inline u32 acpi_pm_read_early(voi
>  
>  #else
>  
> +static inline bool acpi_pm_timer_available(void)
> +{
> +	return false;
> +}
> +
>  static inline u32 acpi_pm_read_early(void)
>  {
>  	return 0;
> 

