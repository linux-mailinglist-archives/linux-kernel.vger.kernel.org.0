Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD9182E52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgCLKyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 06:54:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:26517 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLKyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:54:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 03:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="442011857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2020 03:54:00 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCLTW-008xt7-QD; Thu, 12 Mar 2020 12:54:02 +0200
Date:   Thu, 12 Mar 2020 12:54:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Grant Likely <grant.likely@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v1 1/3] driver core: Break infinite loop when deferred
 probe can't be satisfied
Message-ID: <20200312105402.GU1922688@smile.fi.intel.com>
References: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
 <ad68e006-8a9f-7183-6313-77a5fc3f18f2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad68e006-8a9f-7183-6313-77a5fc3f18f2@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:32:32AM +0200, Peter Ujfalusi wrote:
> Hi Andy,
> 
> On 09/03/2020 16.11, Andy Shevchenko wrote:
> > Consider the following scenario.
> > 
> > The main driver of USB OTG controller (dwc3-pci), which has the following
> > functional dependencies on certain platform:
> > - ULPI (tusb1210)
> > - extcon (tested with extcon-intel-mrfld)
> > 
> > Note, that first driver, tusb1210, is available at the moment of
> > dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > won't appear till user space does something about it.
> > 
> > This is depicted by kernel configuration excerpt:
> > 
> > 	CONFIG_PHY_TUSB1210=y
> > 	CONFIG_USB_DWC3=y
> > 	CONFIG_USB_DWC3_ULPI=y
> > 	CONFIG_USB_DWC3_DUAL_ROLE=y
> > 	CONFIG_USB_DWC3_PCI=y
> > 	CONFIG_EXTCON_INTEL_MRFLD=m
> > 
> > In the Buildroot environment the modules are probed by alphabetical ordering
> > of their modaliases. The latter comes to the case when USB OTG driver will be
> > probed first followed by extcon one.
> > 
> > So, if the platform anticipates extcon device to be appeared, in the above case
> > we will get deferred probe of USB OTG, because of ordering.
> > 
> > Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > deferral race condition fix") counts the amount of triggered deferred probe,
> > we never advance the situation -- the change makes it to be an infinite loop.
> > 
> > ---8<---8<---
> > 
> > [   22.187127] driver_deferred_probe_trigger <<< 1
> > 
> > ...here is the late initcall triggers deferred probe...
> > 
> > [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > 
> > ...dwc3.0.auto is the only device in the deferred list...
> > 
> > [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > 
> > ...the counter before mutex is unlocked is kept the same...
> > 
> > [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > 
> > ...mutes has been unlocked, we try to re-probe the driver...
> > 
> > [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> 
> here dwc3 does ulpi_register_interface() which will make the tusb1210 to
> probe as it is an ulpi_driver.
> 
> > [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > [   22.263723] driver_deferred_probe_trigger <<< 2
> >
> > ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > 
> > [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> 
> and it probes fine as it has no dependencies.
> 
> > [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > 
> > ...but extcon driver is still missing...
> 
> and the dwc3 will ulpi_unregister_interface() which makes the tusb1210
> to be removed as a result since the ulpi bus it was sitting on disappeared.
> 
> > 
> > [   22.283174] platform dwc3.0.auto: Added to deferred list
> > [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> > 
> > ...and since we had a successful probe, we got counter mismatch...
> > 
> > [   22.297490] driver_deferred_probe_trigger <<< 3
> > [   22.302074] platform dwc3.0.auto: deferred_probe_work_func 2 <<< counter 3
> > 
> > ...at the end we have a new counter and loop repeats again, see 22.198727...
> > 
> > ---8<---8<---
> 
> Nice
> 
> > Revert of the commit helps, but it is probably not helpful for the initially
> > found regression. Artem Bityutskiy suggested to use counter of the successful
> > probes instead. This fixes above mentioned case and shouldn't prevent driver
> > to reprobe deferred ones.
> 
> Hrm, but at 22.256292 the tusb1210 is successfully bound which would
> increment the probe_okay?
> 
> Ah, I see you effectively counting the probes, increment the probe_okay
> on bound and decrement it in release of the driver.
> 
> It surely going to balance back in your case as dwc3 registers the ulpi
> interface (which triggers probes on the ulpi bus) and when dwc3 defers
> it unregisters the ulpi interface (which causes the drivers to be
> removed as well).
> 
> I think in theory this should not break the original fix if I play that
> (parallel probing of drivers with dependencies) scenario down in my head ;)
> 
> Let me see, successful probe will trigger the deferred list always.
> If any driver successfully probed between the start of really_probe and
> the driver which is probing got deferred then the counter should
> indicate that -> we will reprobe the driver by kicking the deferred list.
> 
> Unfortunately I don't have a setup to test this, but I trust you and
> Artem enough to:
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thank you, Peter!

Yes, under "successful probe" we understand the one that has stayed probed
after the deferred trigger cycle. That's why a decrement counter is essential
to make this scheme work.

Ideally I would like to get Grant's comment on / test of this...

> > Fixes: 58b116bce136 ("drivercore: deferral race condition fix")
> > Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/dd.c | 39 +++++++++++++++++++++------------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index b25bcab2a26b..43720beb5300 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -53,7 +53,6 @@
> >  static DEFINE_MUTEX(deferred_probe_mutex);
> >  static LIST_HEAD(deferred_probe_pending_list);
> >  static LIST_HEAD(deferred_probe_active_list);
> > -static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
> >  static struct dentry *deferred_devices;
> >  static bool initcalls_done;
> >  
> > @@ -147,17 +146,6 @@ static bool driver_deferred_probe_enable = false;
> >   * This functions moves all devices from the pending list to the active
> >   * list and schedules the deferred probe workqueue to process them.  It
> >   * should be called anytime a driver is successfully bound to a device.
> > - *
> > - * Note, there is a race condition in multi-threaded probe. In the case where
> > - * more than one device is probing at the same time, it is possible for one
> > - * probe to complete successfully while another is about to defer. If the second
> > - * depends on the first, then it will get put on the pending list after the
> > - * trigger event has already occurred and will be stuck there.
> > - *
> > - * The atomic 'deferred_trigger_count' is used to determine if a successful
> > - * trigger has occurred in the midst of probing a driver. If the trigger count
> > - * changes in the midst of a probe, then deferred processing should be triggered
> > - * again.
> >   */
> >  static void driver_deferred_probe_trigger(void)
> >  {
> > @@ -170,7 +158,6 @@ static void driver_deferred_probe_trigger(void)
> >  	 * into the active list so they can be retried by the workqueue
> >  	 */
> >  	mutex_lock(&deferred_probe_mutex);
> > -	atomic_inc(&deferred_trigger_count);
> >  	list_splice_tail_init(&deferred_probe_pending_list,
> >  			      &deferred_probe_active_list);
> >  	mutex_unlock(&deferred_probe_mutex);
> > @@ -350,6 +337,19 @@ static void __exit deferred_probe_exit(void)
> >  }
> >  __exitcall(deferred_probe_exit);
> >  
> > +/*
> > + * Note, there is a race condition in multi-threaded probe. In the case where
> > + * more than one device is probing at the same time, it is possible for one
> > + * probe to complete successfully while another is about to defer. If the second
> > + * depends on the first, then it will get put on the pending list after the
> > + * trigger event has already occurred and will be stuck there.
> > + *
> > + * The atomic 'probe_okay' is used to determine if a successful probe has
> > + * occurred in the midst of probing another driver. If the count changes in
> > + * the midst of a probe, then deferred processing should be triggered again.
> > + */
> > +static atomic_t probe_okay = ATOMIC_INIT(0);
> > +
> >  /**
> >   * device_is_bound() - Check if device is bound to a driver
> >   * @dev: device to check
> > @@ -375,6 +375,7 @@ static void driver_bound(struct device *dev)
> >  	pr_debug("driver: '%s': %s: bound to device '%s'\n", dev->driver->name,
> >  		 __func__, dev_name(dev));
> >  
> > +	atomic_inc(&probe_okay);
> >  	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
> >  	device_links_driver_bound(dev);
> >  
> > @@ -481,18 +482,18 @@ static atomic_t probe_count = ATOMIC_INIT(0);
> >  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
> >  
> >  static void driver_deferred_probe_add_trigger(struct device *dev,
> > -					      int local_trigger_count)
> > +					      int local_probe_okay_count)
> >  {
> >  	driver_deferred_probe_add(dev);
> >  	/* Did a trigger occur while probing? Need to re-trigger if yes */
> > -	if (local_trigger_count != atomic_read(&deferred_trigger_count))
> > +	if (local_probe_okay_count != atomic_read(&probe_okay))
> >  		driver_deferred_probe_trigger();
> >  }
> >  
> >  static int really_probe(struct device *dev, struct device_driver *drv)
> >  {
> >  	int ret = -EPROBE_DEFER;
> > -	int local_trigger_count = atomic_read(&deferred_trigger_count);
> > +	int local_probe_okay_count = atomic_read(&probe_okay);
> >  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
> >  			   !drv->suppress_bind_attrs;
> >  
> > @@ -509,7 +510,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >  
> >  	ret = device_links_check_suppliers(dev);
> >  	if (ret == -EPROBE_DEFER)
> > -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
> > +		driver_deferred_probe_add_trigger(dev, local_probe_okay_count);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -619,7 +620,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >  	case -EPROBE_DEFER:
> >  		/* Driver requested deferred probing */
> >  		dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
> > -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
> > +		driver_deferred_probe_add_trigger(dev, local_probe_okay_count);
> >  		break;
> >  	case -ENODEV:
> >  	case -ENXIO:
> > @@ -1148,6 +1149,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
> >  		dev_pm_set_driver_flags(dev, 0);
> >  
> >  		klist_remove(&dev->p->knode_driver);
> > +		atomic_dec(&probe_okay);
> > +
> >  		device_pm_check_callbacks(dev);
> >  		if (dev->bus)
> >  			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> > 
> 
> - P�ter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
With Best Regards,
Andy Shevchenko


