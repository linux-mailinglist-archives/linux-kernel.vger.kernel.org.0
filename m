Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A21457E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAVOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 09:35:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:41268 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgAVOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:35:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 06:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="283971735"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jan 2020 06:35:37 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jan 2020 16:35:36 +0200
Date:   Wed, 22 Jan 2020 16:35:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/38] platform/x86: intel_scu_ipc: Split out SCU IPC
 functionality from the SCU driver
Message-ID: <20200122143536.GT2665@lahna.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-13-mika.westerberg@linux.intel.com>
 <20200122134026.GC4963@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122134026.GC4963@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:40:26PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 21, 2020 at 07:00:48PM +0300, Mika Westerberg wrote:
> > The SCU IPC functionality is usable outside of Intel MID devices. For
> > example modern Intel CPUs include the same thing but now it is called
> > PMC (Power Management Controller) instead of SCU. To make the IPC
> > available for those split the driver into library part (intel_scu_ipc.c)
> > and the SCU PCI driver part (intel_scu_pcidrv.c) which then calls the
> > former before it goes and creates rest of the SCU devices.
> > 
> > We also split the Kconfig symbols so that INTEL_SCU_IPC enables the SCU
> > IPC library and INTEL_SCU_PCI the SCU driver and convert the users
> > accordingly. While there remove default y from the INTEL_SCU_PCI symbol
> > as it is already selected by X86_INTEL_MID.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/Kconfig                        |  2 +-
> >  arch/x86/include/asm/intel_scu_ipc.h    | 16 +++++
> >  drivers/mfd/Kconfig                     |  4 +-
> >  drivers/platform/x86/Kconfig            | 26 ++++---
> >  drivers/platform/x86/Makefile           |  1 +
> >  drivers/platform/x86/intel_scu_ipc.c    | 90 ++++++++++++-------------
> >  drivers/platform/x86/intel_scu_pcidrv.c | 54 +++++++++++++++
> >  7 files changed, 135 insertions(+), 58 deletions(-)
> >  create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 5e8949953660..aca17d1583c4 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -594,7 +594,7 @@ config X86_INTEL_MID
> >  	select I2C
> >  	select DW_APB_TIMER
> >  	select APB_TIMER
> > -	select INTEL_SCU_IPC
> > +	select INTEL_SCU_PCI
> >  	select MFD_INTEL_MSIC
> >  	---help---
> >  	  Select to build a kernel capable of supporting Intel MID (Mobile
> > diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> > index 2a1442ba6e78..252ea0046f16 100644
> > --- a/arch/x86/include/asm/intel_scu_ipc.h
> > +++ b/arch/x86/include/asm/intel_scu_ipc.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _ASM_X86_INTEL_SCU_IPC_H_
> >  #define  _ASM_X86_INTEL_SCU_IPC_H_
> >  
> > +#include <linux/ioport.h>
> >  #include <linux/notifier.h>
> >  
> >  #define IPCMSG_INDIRECT_READ	0x02
> > @@ -19,6 +20,21 @@
> >  	#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
> >  	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
> >  
> > +struct device;
> > +
> > +/**
> > + * struct intel_scu_ipc_pdata - Platform data for SCU IPC
> > + * @mem: Base address of SCU IPC MMIO registers
> > + * @irq: The IRQ number used for SCU (optional)
> > + */
> > +struct intel_scu_ipc_pdata {
> > +	struct resource mem;
> > +	int irq;
> > +};
> > +
> > +int intel_scu_ipc_register(struct device *dev,
> > +			   const struct intel_scu_ipc_pdata *pdata);
> > +
> >  /* Read single register */
> >  int intel_scu_ipc_ioread8(u16 addr, u8 *data);
> >  
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 420900852166..59515142438e 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -593,7 +593,7 @@ config INTEL_SOC_PMIC_MRFLD
> >  	tristate "Support for Intel Merrifield Basin Cove PMIC"
> >  	depends on GPIOLIB
> >  	depends on ACPI
> > -	depends on INTEL_SCU_IPC
> > +	depends on INTEL_SCU
> >  	select MFD_CORE
> >  	select REGMAP_IRQ
> >  	help
> > @@ -625,7 +625,7 @@ config MFD_INTEL_LPSS_PCI
> >  
> >  config MFD_INTEL_MSIC
> >  	bool "Intel MSIC"
> > -	depends on INTEL_SCU_IPC
> > +	depends on INTEL_SCU
> >  	select MFD_CORE
> >  	help
> >  	  Select this option to enable access to Intel MSIC (Avatele
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index dd4326736d11..50deff627b46 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -986,25 +986,33 @@ config INTEL_VBTN
> >  	  be called intel_vbtn.
> >  
> >  config INTEL_SCU_IPC
> > -	bool "Intel SCU IPC Support"
> > +	bool
> > +
> > +config INTEL_SCU
> > +	bool
> > +	select INTEL_SCU_IPC
> > +
> > +config INTEL_SCU_PCI
> > +	bool "Intel SCU PCI driver"
> >  	depends on X86_INTEL_MID
> > -	default y
> > -	---help---
> > -	  IPC is used to bridge the communications between kernel and SCU on
> > -	  some embedded Intel x86 platforms. This is not needed for PC-type
> > -	  machines.
> > +	select INTEL_SCU
> > +	help
> > +	  This driver is used to bridge the communications between kernel
> > +	  and SCU on some embedded Intel x86 platforms. It also creates
> > +	  devices that are connected to the SoC through the SCU. This is
> > +	  not needed for PC-type machines.
> >  
> >  config INTEL_SCU_IPC_UTIL
> >  	tristate "Intel SCU IPC utility driver"
> > -	depends on INTEL_SCU_IPC
> > -	---help---
> > +	depends on INTEL_SCU
> > +	help
> >  	  The IPC Util driver provides an interface with the SCU enabling
> >  	  low level access for debug work and updating the firmware. Say
> >  	  N unless you will be doing this on an Intel MID platform.
> >  
> >  config INTEL_MID_POWER_BUTTON
> >  	tristate "power button driver for Intel MID platforms"
> > -	depends on INTEL_SCU_IPC && INPUT
> > +	depends on INTEL_SCU && INPUT
> >  	help
> >  	  This driver handles the power button on the Intel MID platforms.
> >  
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > index 42d85a00be4e..c7a42feaa521 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -68,6 +68,7 @@ intel_cht_int33fe-objs		:= intel_cht_int33fe_common.o \
> >  obj-$(CONFIG_INTEL_INT0002_VGPIO) += intel_int0002_vgpio.o
> >  obj-$(CONFIG_INTEL_HID_EVENT)	+= intel-hid.o
> >  obj-$(CONFIG_INTEL_VBTN)	+= intel-vbtn.o
> > +obj-$(CONFIG_INTEL_SCU_PCI)	+= intel_scu_pcidrv.o
> >  obj-$(CONFIG_INTEL_SCU_IPC)	+= intel_scu_ipc.o
> >  obj-$(CONFIG_INTEL_SCU_IPC_UTIL) += intel_scu_ipcutil.o
> >  obj-$(CONFIG_INTEL_MFLD_THERMAL) += intel_mid_thermal.o
> > diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> > index 93a810fa6c8a..a5ca1aae9547 100644
> > --- a/drivers/platform/x86/intel_scu_ipc.c
> > +++ b/drivers/platform/x86/intel_scu_ipc.c
> > @@ -18,11 +18,8 @@
> >  #include <linux/errno.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > -#include <linux/pci.h>
> > -#include <linux/pm.h>
> > -#include <linux/sfi.h>
> > +#include <linux/io.h>
> >  
> > -#include <asm/intel-mid.h>
> >  #include <asm/intel_scu_ipc.h>
> >  
> >  /* IPC defines the following message types */
> > @@ -56,9 +53,10 @@
> >  
> >  struct intel_scu_ipc_dev {
> >  	struct device *dev;
> > +	struct resource mem;
> > +	int irq;
> >  	void __iomem *ipc_base;
> >  	struct completion cmd_complete;
> > -	u8 irq_mode;
> >  };
> >  
> >  static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
> > @@ -166,7 +164,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
> >  
> >  static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
> >  {
> > -	return scu->irq_mode ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
> > +	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
> >  }
> >  
> >  /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
> > @@ -402,60 +400,60 @@ static irqreturn_t ioc(int irq, void *dev_id)
> >  }
> >  
> >  /**
> > - *	ipc_probe	-	probe an Intel SCU IPC
> > - *	@pdev: the PCI device matching
> > - *	@id: entry in the match table
> > + * intel_scu_ipc_register() - Register SCU IPC mechanism
> > + * @dev: SCU device
> > + * @pdata: Platform specific data
> >   *
> > - *	Enable and install an intel SCU IPC. This appears in the PCI space
> > - *	but uses some hard coded addresses as well.
> > + * Call this function to initialize SCU IPC mechanism for @dev.
> >   */
> > -static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +int intel_scu_ipc_register(struct device *dev,
> > +			   const struct intel_scu_ipc_pdata *pdata)
> >  {
> 
> How do you "know" that dev really is a SCU device?

Well this expects the caller to know that.

> If you are "registering" something, shouldn't you have set it up
> properly?  You are saying that any random struct device has these
> attributes.  Now that's fine as you "know" this, but usually you would
> create a child device that really is a SCU functionality, i.e. a class
> device.
> 
> So how about making the SCU stuff a class as that is what is then made a
> child of the struct device as it is how it talks to this class of
> devices, right?

That's a good idea. I'll look into this.

> As it is, this "register" really feels odd to me in the scheme of how
> the whole driver model works.
> 
> Not to mention I didn't see any reference counting increment happening
> here, as you are passing a pointer that is then saved off, right?

Right.

> >  	int err;
> >  	struct intel_scu_ipc_dev *scu = &ipcdev;
> >  
> > -	if (scu->dev)		/* We support only one SCU */
> > -		return -EBUSY;
> > +	mutex_lock(&ipclock);
> > +	/* We support only one IPC */
> > +	if (scu->dev) {
> > +		err = -EBUSY;
> > +		goto err_unlock;
> > +	}
> >  
> > -	err = pcim_enable_device(pdev);
> > -	if (err)
> > -		return err;
> > +	if (!request_mem_region(pdata->mem.start, resource_size(&pdata->mem),
> > +				"intel_scu_ipc")) {
> > +		err = -EBUSY;
> > +		goto err_unlock;
> > +	}
> >  
> > -	err = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> > -	if (err)
> > -		return err;
> > +	scu->ipc_base = ioremap(pdata->mem.start, resource_size(&pdata->mem));
> > +	if (!scu->ipc_base) {
> > +		err = -ENOMEM;
> > +		goto err_release;
> > +	}
> >  
> > +	scu->mem = pdata->mem;
> > +	scu->irq = pdata->irq;
> >  	init_completion(&scu->cmd_complete);
> >  
> > -	scu->ipc_base = pcim_iomap_table(pdev)[0];
> > -
> > -	err = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_scu_ipc",
> > -			       scu);
> > -	if (err)
> > -		return err;
> > +	if (scu->irq > 0) {
> > +		err = request_irq(scu->irq, ioc, 0, "intel_scu_ipc", scu);
> > +		if (err)
> > +			goto err_unmap;
> > +	}
> >  
> >  	/* Assign device at last */
> > -	scu->dev = &pdev->dev;
> > -
> > -	intel_scu_devices_create();
> > +	scu->dev = dev;
> 
> Look ma, a reference count mess!
> 
> Ick.
> 
> Please make this a class.

I will, thanks!
