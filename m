Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9121312C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAFN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 08:27:02 -0500
Received: from foss.arm.com ([217.140.110.172]:44002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgAFN1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:27:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B110328;
        Mon,  6 Jan 2020 05:27:00 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB993F534;
        Mon,  6 Jan 2020 05:26:59 -0800 (PST)
Subject: Re: [PATCH v2] iommu/qcom: fix NULL pointer dereference during probe
 deferral
To:     Brian Masney <masneyb@onstation.org>, robdclark@gmail.com,
        bjorn.andersson@linaro.org, joro@8bytes.org
Cc:     stephan@gerhold.net, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, j.neuschaefer@gmx.net,
        iommu@lists.linux-foundation.org, agross@kernel.org
References: <20200104002024.37335-1-masneyb@onstation.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fc055443-8716-4a0e-b4d5-311517d71ea0@arm.com>
Date:   Mon, 6 Jan 2020 13:26:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200104002024.37335-1-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2020 12:20 am, Brian Masney wrote:
> When attempting to load the qcom-iommu driver, and an -EPROBE_DEFER
> error occurs, the following attempted NULL pointer deference occurs:
> 
>      Unable to handle kernel NULL pointer dereference at virtual address 00000014
>      pgd = (ptrval)
>      [00000014] *pgd=00000000
>      Internal error: Oops: 5 [#1] PREEMPT SMP ARM
>      Modules linked in:
>      CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc2-next-20191220-00010-gfb6b8e8bced6-dirty #3
>      Hardware name: Generic DT based system
>      PC is at qcom_iommu_domain_free (include/linux/pm_runtime.h:226
>        drivers/iommu/qcom_iommu.c:358)
>      LR is at release_iommu_mapping (arch/arm/mm/dma-mapping.c:2141)
>      pc : lr : psr: 60000013
>      sp : ee89dc48  ip : 00000000  fp : c13a6684
>      r10: c13a661c  r9 : 00000000  r8 : c13a1240
>      r7 : fffffdfb  r6 : 00000000  r5 : edc32f00  r4 : edc32f1c
>      r3 : 00000000  r2 : 00000001  r1 : 00000004  r0 : edc32f1c
>      Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>      Control: 10c5787d  Table: 0020406a  DAC: 00000051
>      Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
>      Stack: (0xee89dc48 to 0xee89e000)
>      dc40:                   edc3d010 edc37020 00000000 c0316af8 edc3d010 edc37000
>      dc60: 00000000 c0319684 c14341ac edc3d010 00000000 c083bd88 edc3d010 c13a1240
>      dc80: c083c2e8 c13a6684 c13a661c c13a6508 c13a661c c083c134 c13a1240 ee89dcec
>      dca0: edc3d010 00000000 ee89dcec c083c2e8 c13a6684 c13a661c c13a6508 c13a661c
>      dcc0: c13a6684 c083a31c c13a6684 ee82a86c edc327b8 c1304e48 edc3d010 00000001
>      dce0: edc3d054 c083bc08 ee82a880 edc3d010 00000001 c1304e48 edc3d010 edc3d010
>      dd00: c13a69e8 c083b010 edc3d010 00000000 eea1fc10 c0837aac 00000200 00000000
>      dd20: 00000000 00000000 00000000 c1304e48 00000000 edc3d000 eea1fc10 00000000
>      dd40: 00000000 eeff42f4 00000000 00000001 00000000 c09e96e0 eeff42a4 00000000
>      dd60: 00000000 00000000 eea1fc10 c09e98bc 00000001 eea1fc10 00000000 eea1fc10
>      dd80: edc32c00 c1391580 eea1fc10 00000001 eea1fc10 c0850f90 c2706dec c14368c0
>      dda0: 60000013 c1304e48 00000106 eeff42a4 eeff3fa0 00000000 00000000 eea1fc10
>      ddc0: 00000001 c1248900 00000106 c09e9bd0 00000001 c0c2ee64 eea1fc00 eea1fc10
>      dde0: eea1fc10 00000000 c13a5b70 00000000 c1248900 c081496c c1023d84 00000000
>      de00: eeff3fa0 c2706e48 c2706e48 c1304e48 00000001 00000000 eea1fc10 c13a5b70
>      de20: 00000000 c13a5b70 00000000 c1248900 00000106 c083dfb8 c14341ac eea1fc10
>      de40: 00000000 c083be58 eea1fc10 c13a5b70 c13a5b70 c13a69e8 c12003ec c123a854
>      de60: c1248900 c083c134 c1248900 c09e6f3c c0d8d514 eea1fc10 00000000 c13a5b70
>      de80: c13a69e8 c12003ec c123a854 c1248900 00000106 c083c3e0 00000000 c13a5b70
>      dea0: eea1fc10 c083c440 00000000 c13a5b70 c083c3e8 c083a23c 00000106 ee82a858
>      dec0: eea052b4 c1304e48 c13a5b70 edc32b80 00000000 c083b270 c1043084 c121d1d8
>      dee0: ffffe000 c13a5b70 c121d1d8 ffffe000 00000000 c083cfcc c13ece60 c121d1d8
>      df00: ffffe000 c0302f90 00000106 c034407c 00000000 c10e3a00 c1044dd0 c12003ec
>      df20: 00000000 00000006 00000006 c0fbecac c0fada88 c0fada3c 00000000 efffcbf8
>      df40: efffcc0d c1304e48 00000000 00000006 c13f9500 c1304e48 c123a830 00000007
>      df60: c13f9500 c13f9500 c123a834 c1200f64 00000006 00000006 00000000 c12003ec
>      df80: c0c28194 00000000 c0c28194 00000000 00000000 00000000 00000000 00000000
>      dfa0: 00000000 c0c2819c 00000000 c03010e8 00000000 00000000 00000000 00000000
>      dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>      dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
>      (qcom_iommu_domain_free) from release_iommu_mapping
>        (arch/arm/mm/dma-mapping.c:2141)
>      (release_iommu_mapping) from arch_teardown_dma_ops
>        (include/linux/dma-mapping.h:271 arch/arm/mm/dma-mapping.c:2335)
>      (arch_teardown_dma_ops) from really_probe (drivers/base/dd.c:607)
>      (really_probe) from driver_probe_device (drivers/base/dd.c:721)
>      (driver_probe_device) from bus_for_each_drv (drivers/base/bus.c:431)
>      (bus_for_each_drv) from __device_attach (drivers/base/dd.c:896)
>      (__device_attach) from bus_probe_device (drivers/base/bus.c:491)
>      (bus_probe_device) from device_add (drivers/base/core.c:2488)
>      (device_add) from of_platform_device_create_pdata
>        (drivers/of/platform.c:189)
>      (of_platform_device_create_pdata) from of_platform_bus_create
>        (drivers/of/platform.c:393 drivers/of/platform.c:346)
>      (of_platform_bus_create) from of_platform_populate
>        (drivers/of/platform.c:486)
>      (of_platform_populate) from msm_pdev_probe
>        (drivers/gpu/drm/msm/msm_drv.c:1197 drivers/gpu/drm/msm/msm_drv.c:1281)
>      (msm_pdev_probe) from platform_drv_probe (drivers/base/platform.c:726)
>      (platform_drv_probe) from really_probe (drivers/base/dd.c:553)
>      (really_probe) from driver_probe_device (drivers/base/dd.c:721)
>      (driver_probe_device) from device_driver_attach (drivers/base/dd.c:995)
>      (device_driver_attach) from __driver_attach (drivers/base/dd.c:1074)
>      (__driver_attach) from bus_for_each_dev (drivers/base/bus.c:304)
>      (bus_for_each_dev) from bus_add_driver (drivers/base/bus.c:623)
>      (bus_add_driver) from driver_register (drivers/base/driver.c:172)
>      (driver_register) from do_one_initcall (include/linux/compiler.h:232
>        include/linux/jump_label.h:254 include/linux/jump_label.h:264
>        include/trace/events/initcall.h:48 init/main.c:941)
>      (do_one_initcall) from kernel_init_freeable (init/main.c:1013
>        init/main.c:1022 init/main.c:1039 init/main.c:1231)
>      (kernel_init_freeable) from kernel_init (init/main.c:1127)
>      (kernel_init) from ret_from_fork (arch/arm/kernel/entry-common.S:156)
> 
> qcom_iommu_domain_free() has a WARN_ON() that checks to see if the value
> of iommu is NULL and returns early, so iommu->dev will always be NULL.
> qcom_iommu_detach_dev() is called prior to freeing the IOMMU domain and
> is what sets the iommu member to NULL.
> 
> Let's fix this by adding the 'struct dev' pointer to the
> qcom_iommu_domain struct.

Actually, it looks like the qcom_domain->iommu logic is fundamentally 
broken anyway - this sequence of calls is perfectly valid, but AFAICS 
will make qcom-iommu go horribly wrong:

	dom = iommu_domain_alloc(...);
	iommu_attach_device(dom, dev1);
	iommu_attach_device(dom, dev2);
	iommu_detach_device(dom, dev2);
	// dev1 still attached but dom->iommu now NULL

Furthermore, even this should technically be valid:

	dom = iommu_domain_alloc(...);
	iommu_attach_device(dom, dev);
	iommu_map(dom, addr, ...);
	iommu_detach_device(dom, dev);
	iommu_unmap(dom, addr, ...); // oops, dereferences NULL again

Does something like the diff below work?

Robin.

----->8-----
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c31e7bc4ccbe..af6ee4bf1712 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -345,21 +345,20 @@ static void qcom_iommu_domain_free(struct 
iommu_domain *domain)
  {
  	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);

-	if (WARN_ON(qcom_domain->iommu))    /* forgot to detach? */
-		return;
-
  	iommu_put_dma_cookie(domain);

-	/* NOTE: unmap can be called after client device is powered off,
-	 * for example, with GPUs or anything involving dma-buf.  So we
-	 * cannot rely on the device_link.  Make sure the IOMMU is on to
-	 * avoid unclocked accesses in the TLB inv path:
-	 */
-	pm_runtime_get_sync(qcom_domain->iommu->dev);
+	if (qcom_domain->iommu) {
+		/* NOTE: unmap can be called after client device is powered off,
+		 * for example, with GPUs or anything involving dma-buf.  So we
+		 * cannot rely on the device_link.  Make sure the IOMMU is on to
+		 * avoid unclocked accesses in the TLB inv path:
+		 */
+		pm_runtime_get_sync(qcom_domain->iommu->dev);

-	free_io_pgtable_ops(qcom_domain->pgtbl_ops);
+		free_io_pgtable_ops(qcom_domain->pgtbl_ops);

-	pm_runtime_put_sync(qcom_domain->iommu->dev);
+		pm_runtime_put_sync(qcom_domain->iommu->dev);
+	}

  	kfree(qcom_domain);
  }
@@ -405,7 +404,7 @@ static void qcom_iommu_detach_dev(struct 
iommu_domain *domain, struct device *de
  	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
  	unsigned i;

-	if (!qcom_domain->iommu)
+	if (WARN_ON(!qcom_domain->iommu))
  		return;

  	pm_runtime_get_sync(qcom_iommu->dev);
@@ -418,8 +417,6 @@ static void qcom_iommu_detach_dev(struct 
iommu_domain *domain, struct device *de
  		ctx->domain = NULL;
  	}
  	pm_runtime_put_sync(qcom_iommu->dev);
-
-	qcom_domain->iommu = NULL;
  }

  static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
