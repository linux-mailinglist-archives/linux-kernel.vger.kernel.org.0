Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C482F264CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfEVNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 09:34:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51576 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfEVNer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:34:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 758A580D;
        Wed, 22 May 2019 06:34:46 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE16F3F575;
        Wed, 22 May 2019 06:34:44 -0700 (PDT)
Date:   Wed, 22 May 2019 14:34:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for
 Mellanox BlueField Soc
Message-ID: <20190522133438.GA23592@lakrids.cambridge.arm.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-1-git-send-email-lsun@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558115345-32476-1-git-send-email-lsun@mellanox.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liming,

On Fri, May 17, 2019 at 01:49:04PM -0400, Liming Sun wrote:
> This commit adds the bootctl platform driver for Mellanox BlueField
> Soc, which controls the eMMC boot partition swapping and sends SMC
> calls to ATF running at exception level EL3 to program some system
> register. This register is persistent during warm reset and is only
> accessible in secure code which is used to enable the watchdog after
> reboot.

I'm concerned by this. AFAICT this part must boot using EFI (in order
for the ACPI bits to work), and these interfaces significantly overlap
with or contradict the UEFI specification w.r.t. boot management.

How exactly does this SoC boot?

How do these interfaces interact with the regular UEFI bootflow?

Thanks,
Mark.

> 
> Below are the sequences of typical use case.
> 
>   1. User-space tool upgrades one eMMC boot partition and requests
>      the boot partition swapping;
> 
>   2. The bootctl driver handles this request and sends SMC call
>      to ATF. ATF programs register BREADCRUMB0 which has value
>      preserved during warm reset. It also programs eMMC to swap
>      the boot partition;
> 
>   3. After software reset (rebooting), ATF BL1 (BootRom) checks
>      register BREADCRUMB0 to enable watchdog if configured;
> 
>   4. If booting fails, the watchdog timer will trigger rebooting.
>      In such case, ATF Boot ROM will switch the boot partition
>      back to the previous one.
> 
> Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
> v4->v5:
>     Fixes for comments from Andy:
>     - Added ABI documentation;
>     - Remove the extra 'const' in mlxbf_bootctl_svc_uuid_str definition;
>     - Remove the mlxbf_bootctl_smc_call0() MACRO to use function
>       call directly;
>     - Return more descriptive string ('invalid action') in
>       mlxbf_bootctl_reset_action_to_string();
>     - Check return value of the mlxbf_bootctl_smc() in function
>       post_reset_wdog_show() and reset_action_show();
>     - Revise the sprintf() line in reset_action_show() into one line;
>     - Move the 'action = ' assignment out of the declarations
>       in reset_action_store() and check return value of
>       mlxbf_bootctl_reset_action_to_val() in this function;
>     - Removed Redundant parens in reset_action_store();
>     - Check return code of the smc_call in second_reset_action_show(),
>       merge the 'name = ' assignment into the sprintf() directly;
>     - Move the 'action = ' assignment out of the declaration block
>       in second_reset_action_store();
>     - Remove redundant blank line and parents in lifecycle_state_show();
>     - Split declaration and assignment in secure_boot_fuse_state_show();
>     - use BIT() in secure_boot_fuse_state_show() and simplify code in
>       this function to split the logic of message choice and flag flip;
>       Also removed the 'key !=0 ' check since it's not needed;
>     - Added comma in mlxbf_bootctl_attr_group definition.
>     - Removed un-needed '& 0xFF' logic in mlxbf_bootctl_guid_match();
>     - Use temp variable for the result of the smc call in
>       mlxbf_bootctl_probe();
>     - Use dev_warn() instead of dev_err() in mlxbf_bootctl_probe();
>     - Removed the ACPI_PTR usage in the mlxbf_bootctl_driver definition;
>     Fixes for comments from Vadim:
>     - Move mlxbf-bootctl.o to the top of the Makefile;
>     - Fix to use the 'ret' value instead of another mlxbf_bootctl_smc() call;
>     - Fix the 'declaration inside the block' in secure_boot_fuse_state_show();
>     - Use ATTRIBUTE_GROUPS() for the attribute definition;
>     - Use single line for a comment in mlxbf-bootctl.h
>     - Use KernelVersion 5.3 instead of 5.2.2 in the ABI doc;
>     - Use common utility function for the show and store of reset_action
>       and second_reset_action.
>     New changes:
>     - Rename mlxbf_bootctl_smc_call1() to mlxbf_bootctl_smc() to
>       shorten the name so some statement could be make into one line;
>     - Fixed the MODULE_LICENSE();
>     - Added more comments in secure_boot_fuse_state_show();
> v4: Update Kconfig for the dependency on ACPI.
>     Fixed a typo which caused build error for kernel module.
> v2->v3:
>     Fixes for comments from Andy:
>     - More coding style fixes;
>     - Revised the uuid matching code.
> v2: Fix the Kconfig and coding styles, propagate errors to caller.
> v1: Initial version.
> ---
>  drivers/platform/mellanox/Kconfig         |  12 ++
>  drivers/platform/mellanox/Makefile        |   1 +
>  drivers/platform/mellanox/mlxbf-bootctl.c | 311 ++++++++++++++++++++++++++++++
>  drivers/platform/mellanox/mlxbf-bootctl.h | 103 ++++++++++
>  4 files changed, 427 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxbf-bootctl.c
>  create mode 100644 drivers/platform/mellanox/mlxbf-bootctl.h
> 
> diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
> index 530fe7e..386336d 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -44,4 +44,16 @@ config MLXBF_TMFIFO
>            platform driver support for the TmFifo which supports console
>            and networking based on the virtio framework.
>  
> +config MLXBF_BOOTCTL
> +	tristate "Mellanox BlueField Firmware Boot Control driver"
> +	depends on ARM64
> +	depends on ACPI
> +	help
> +          The Mellanox BlueField firmware implements functionality to
> +          request swapping the primary and alternate eMMC boot partition,
> +          and to set up a watchdog that can undo that swap if the system
> +          does not boot up correctly. This driver provides sysfs access
> +          to the userspace tools, to be used in conjunction with the eMMC
> +          device driver to do necessary initial swap of the boot partition.
> +
>  endif # MELLANOX_PLATFORM
> diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
> index a229bda1..499623c 100644
> --- a/drivers/platform/mellanox/Makefile
> +++ b/drivers/platform/mellanox/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for linux/drivers/platform/mellanox
>  # Mellanox Platform-Specific Drivers
>  #
> +obj-$(CONFIG_MLXBF_BOOTCTL)	+= mlxbf-bootctl.o
>  obj-$(CONFIG_MLXBF_TMFIFO)	+= mlxbf-tmfifo.o
>  obj-$(CONFIG_MLXREG_HOTPLUG)	+= mlxreg-hotplug.o
>  obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
> new file mode 100644
> index 0000000..842b991
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Mellanox boot control driver
> + *
> + * This driver provides a sysfs interface for systems management
> + * software to manage reset-time actions.
> + *
> + * Copyright (C) 2019 Mellanox Technologies
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "mlxbf-bootctl.h"
> +
> +#define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
> +#define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
> +
> +#define MLXBF_SB_KEY_NUM			4
> +
> +/* UUID used to probe ATF service. */
> +static const char *mlxbf_bootctl_svc_uuid_str =
> +	"89c036b4-e7d7-11e6-8797-001aca00bfc4";
> +
> +struct mlxbf_bootctl_name {
> +	u32 value;
> +	const char *name;
> +};
> +
> +static struct mlxbf_bootctl_name boot_names[] = {
> +	{ MLXBF_BOOTCTL_EXTERNAL, "external" },
> +	{ MLXBF_BOOTCTL_EMMC, "emmc" },
> +	{ MLNX_BOOTCTL_SWAP_EMMC, "swap_emmc" },
> +	{ MLXBF_BOOTCTL_EMMC_LEGACY, "emmc_legacy" },
> +	{ MLXBF_BOOTCTL_NONE, "none" },
> +};
> +
> +static const char * const mlxbf_bootctl_lifecycle_states[] = {
> +	[0] = "Production",
> +	[1] = "GA Secured",
> +	[2] = "GA Non-Secured",
> +	[3] = "RMA",
> +};
> +
> +/* ARM SMC call which is atomic and no need for lock. */
> +static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +/* Return the action in integer or an error code. */
> +static int mlxbf_bootctl_reset_action_to_val(const char *action)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(boot_names); i++)
> +		if (sysfs_streq(boot_names[i].name, action))
> +			return boot_names[i].value;
> +
> +	return -EINVAL;
> +}
> +
> +/* Return the action in string. */
> +static const char *mlxbf_bootctl_action_to_string(int action)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(boot_names); i++)
> +		if (boot_names[i].value == action)
> +			return boot_names[i].name;
> +
> +	return "invalid action";
> +}
> +
> +static ssize_t post_reset_wdog_show(struct device_driver *drv, char *buf)
> +{
> +	int ret;
> +
> +	ret = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_POST_RESET_WDOG, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret);
> +}
> +
> +static ssize_t post_reset_wdog_store(struct device_driver *drv,
> +				     const char *buf, size_t count)
> +{
> +	unsigned long value;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = mlxbf_bootctl_smc(MLXBF_BOOTCTL_SET_POST_RESET_WDOG, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t mlxbf_bootctl_show(int smc_op, char *buf)
> +{
> +	int action;
> +
> +	action = mlxbf_bootctl_smc(smc_op, 0);
> +	if (action < 0)
> +		return action;
> +
> +	return sprintf(buf, "%s\n", mlxbf_bootctl_action_to_string(action));
> +}
> +
> +static int mlxbf_bootctl_store(int smc_op, const char *buf, size_t count)
> +{
> +	int ret, action;
> +
> +	action = mlxbf_bootctl_reset_action_to_val(buf);
> +	if (action < 0)
> +		return action;
> +
> +	ret = mlxbf_bootctl_smc(smc_op, action);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t reset_action_show(struct device_driver *drv, char *buf)
> +{
> +	return mlxbf_bootctl_show(MLXBF_BOOTCTL_GET_RESET_ACTION, buf);
> +}
> +
> +static ssize_t reset_action_store(struct device_driver *drv,
> +				  const char *buf, size_t count)
> +{
> +	return mlxbf_bootctl_store(MLXBF_BOOTCTL_SET_RESET_ACTION, buf, count);
> +}
> +
> +static ssize_t second_reset_action_show(struct device_driver *drv, char *buf)
> +{
> +	return mlxbf_bootctl_show(MLXBF_BOOTCTL_GET_SECOND_RESET_ACTION, buf);
> +}
> +
> +static ssize_t second_reset_action_store(struct device_driver *drv,
> +					 const char *buf, size_t count)
> +{
> +	return mlxbf_bootctl_store(MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION, buf,
> +				   count);
> +}
> +
> +static ssize_t lifecycle_state_show(struct device_driver *drv, char *buf)
> +{
> +	int lc_state;
> +
> +	lc_state = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
> +				     MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
> +	if (lc_state < 0)
> +		return lc_state;
> +
> +	lc_state &=
> +		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
> +
> +	/*
> +	 * If the test bits are set, we specify that the current state may be
> +	 * due to using the test bits.
> +	 */
> +	if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
> +		lc_state &= MLXBF_BOOTCTL_SB_SECURE_MASK;
> +
> +		return sprintf(buf, "%s(test)\n",
> +			       mlxbf_bootctl_lifecycle_states[lc_state]);
> +	}
> +
> +	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
> +}
> +
> +static ssize_t secure_boot_fuse_state_show(struct device_driver *drv, char *buf)
> +{
> +	int burnt, valid, key, key_state, buf_len = 0, upper_key_used = 0;
> +	const char *status;
> +
> +	key_state = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
> +				      MLXBF_BOOTCTL_FUSE_STATUS_KEYS);
> +	if (key_state < 0)
> +		return key_state;
> +
> +	/*
> +	 * key_state contains the bits for 4 Key versions, loaded from eFuses
> +	 * after a hard reset. Lower 4 bits are a thermometer code indicating
> +	 * key programming has started for key n (0000 = none, 0001 = version 0,
> +	 * 0011 = version 1, 0111 = version 2, 1111 = version 3). Upper 4 bits
> +	 * are a thermometer code indicating key programming has completed for
> +	 * key n (same encodings as the start bits). This allows for detection
> +	 * of an interruption in the progamming process which has left the key
> +	 * partially programmed (and thus invalid). The process is to burn the
> +	 * eFuse for the new key start bit, burn the key eFuses, then burn the
> +	 * eFuse for the new key complete bit.
> +	 *
> +	 * For example 0000_0000: no key valid, 0001_0001: key version 0 valid,
> +	 * 0011_0011: key 1 version valid, 0011_0111: key version 2 started
> +	 * programming but did not complete, etc. The most recent key for which
> +	 * both start and complete bit is set is loaded. On soft reset, this
> +	 * register is not modified.
> +	 */
> +	for (key = MLXBF_SB_KEY_NUM - 1; key >= 0; key--) {
> +		burnt = key_state & BIT(key);
> +		valid = key_state & BIT(key + MLXBF_SB_KEY_NUM);
> +
> +		if (burnt && valid)
> +			upper_key_used = 1;
> +
> +		if (upper_key_used) {
> +			if (burnt)
> +				status = valid ? "Used" : "Wasted";
> +			else
> +				status = valid ? "Invalid" : "Skipped";
> +		} else {
> +			if (burnt)
> +				status = valid ? "InUse" : "Incomplete";
> +			else
> +				status = valid ? "Invalid" : "Free";
> +		}
> +		buf_len += sprintf(buf + buf_len, "%d:%s ", key, status);
> +	}
> +	buf_len += sprintf(buf + buf_len, "\n");
> +
> +	return buf_len;
> +}
> +
> +static DRIVER_ATTR_RW(post_reset_wdog);
> +static DRIVER_ATTR_RW(reset_action);
> +static DRIVER_ATTR_RW(second_reset_action);
> +static DRIVER_ATTR_RO(lifecycle_state);
> +static DRIVER_ATTR_RO(secure_boot_fuse_state);
> +
> +static struct attribute *mlxbf_bootctl_attrs[] = {
> +	&driver_attr_post_reset_wdog.attr,
> +	&driver_attr_reset_action.attr,
> +	&driver_attr_second_reset_action.attr,
> +	&driver_attr_lifecycle_state.attr,
> +	&driver_attr_secure_boot_fuse_state.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(mlxbf_bootctl);
> +
> +static const struct acpi_device_id mlxbf_bootctl_acpi_ids[] = {
> +	{"MLNXBF04", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, mlxbf_bootctl_acpi_ids);
> +
> +static bool mlxbf_bootctl_guid_match(const guid_t *guid,
> +				     const struct arm_smccc_res *res)
> +{
> +	guid_t id = GUID_INIT(res->a0, res->a1, res->a1 >> 16,
> +			      res->a2, res->a2 >> 8, res->a2 >> 16,
> +			      res->a2 >> 24, res->a3, res->a3 >> 8,
> +			      res->a3 >> 16, res->a3 >> 24);
> +
> +	return guid_equal(guid, &id);
> +}
> +
> +static int mlxbf_bootctl_probe(struct platform_device *pdev)
> +{
> +	struct arm_smccc_res res = { 0 };
> +	guid_t guid;
> +	int ret;
> +
> +	/* Ensure we have the UUID we expect for this service. */
> +	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> +	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> +	if (!mlxbf_bootctl_guid_match(&guid, &res))
> +		return -ENODEV;
> +
> +	/*
> +	 * When watchdog is used, it sets boot mode to MLXBF_BOOTCTL_SWAP_EMMC
> +	 * in case of boot failures. However it doesn't clear the state if there
> +	 * is no failure. Restore the default boot mode here to avoid any
> +	 * unnecessary boot partition swapping.
> +	 */
> +	ret = mlxbf_bootctl_smc(MLXBF_BOOTCTL_SET_RESET_ACTION,
> +				MLXBF_BOOTCTL_EMMC);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Unable to reset the EMMC boot mode\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mlxbf_bootctl_driver = {
> +	.probe = mlxbf_bootctl_probe,
> +	.driver = {
> +		.name = "mlxbf-bootctl",
> +		.groups = mlxbf_bootctl_groups,
> +		.acpi_match_table = mlxbf_bootctl_acpi_ids,
> +	}
> +};
> +
> +module_platform_driver(mlxbf_bootctl_driver);
> +
> +MODULE_DESCRIPTION("Mellanox boot control driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Mellanox Technologies");
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
> new file mode 100644
> index 0000000..148fdb4
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
> + */
> +
> +#ifndef __MLXBF_BOOTCTL_H__
> +#define __MLXBF_BOOTCTL_H__
> +
> +/*
> + * Request that the on-chip watchdog be enabled, or disabled, after
> + * the next chip soft reset. This call does not affect the current
> + * status of the on-chip watchdog. If non-zero, the argument
> + * specifies the watchdog interval in seconds. If zero, the watchdog
> + * will not be enabled after the next soft reset. Non-zero errors are
> + * returned as documented below.
> + */
> +#define MLXBF_BOOTCTL_SET_POST_RESET_WDOG	0x82000000
> +
> +/*
> + * Query the status which has been requested for the on-chip watchdog
> + * after the next chip soft reset. Returns the interval as set by
> + * MLXBF_BOOTCTL_SET_POST_RESET_WDOG.
> + */
> +#define MLXBF_BOOTCTL_GET_POST_RESET_WDOG	0x82000001
> +
> +/*
> + * Request that a specific boot action be taken at the next soft
> + * reset. By default, the boot action is set by external chip pins,
> + * which are sampled on hard reset. Note that the boot action
> + * requested by this call will persist on subsequent resets unless
> + * this service, or the MLNX_SET_SECOND_RESET_ACTION service, is
> + * invoked. See below for the available MLNX_BOOT_xxx parameter
> + * values. Non-zero errors are returned as documented below.
> + */
> +#define MLXBF_BOOTCTL_SET_RESET_ACTION		0x82000002
> +
> +/*
> + * Return the specific boot action which will be taken at the next
> + * soft reset. Returns the reset action (see below for the parameter
> + * values for MLXBF_BOOTCTL_SET_RESET_ACTION).
> + */
> +#define MLXBF_BOOTCTL_GET_RESET_ACTION		0x82000003
> +
> +/*
> + * Request that a specific boot action be taken at the soft reset
> + * after the next soft reset. For a specified valid boot mode, the
> + * effect of this call is identical to that of invoking
> + * MLXBF_BOOTCTL_SET_RESET_ACTION after the next chip soft reset; in
> + * particular, after that reset, the action for the now next reset can
> + * be queried with MLXBF_BOOTCTL_GET_RESET_ACTION and modified with
> + * MLXBF_BOOTCTL_SET_RESET_ACTION. You may also specify the parameter as
> + * MLNX_BOOT_NONE, which is equivalent to specifying that no call to
> + * MLXBF_BOOTCTL_SET_RESET_ACTION be taken after the next chip soft reset.
> + * This call does not affect the action to be taken at the next soft
> + * reset. Non-zero errors are returned as documented below.
> + */
> +#define MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION	0x82000004
> +
> +/*
> + * Return the specific boot action which will be taken at the soft
> + * reset after the next soft reset; this will be one of the valid
> + * actions for MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION.
> + */
> +#define MLXBF_BOOTCTL_GET_SECOND_RESET_ACTION	0x82000005
> +
> +/*
> + * Return the fuse status of the current chip. The caller should specify
> + * with the second argument if the state of the lifecycle fuses or the
> + * version of secure boot fuse keys left should be returned.
> + */
> +#define MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS	0x82000006
> +
> +/* Reset eMMC by programming the RST_N register. */
> +#define MLXBF_BOOTCTL_SET_EMMC_RST_N		0x82000007
> +
> +#define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
> +
> +/* SMC function IDs for SiP Service queries */
> +#define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
> +#define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
> +#define MLXBF_BOOTCTL_SIP_SVC_VERSION		0x8200ff03
> +
> +/* ARM Standard Service Calls version numbers */
> +#define MLXBF_BOOTCTL_SVC_VERSION_MAJOR		0x0
> +#define MLXBF_BOOTCTL_SVC_VERSION_MINOR		0x2
> +
> +/* Number of svc calls defined. */
> +#define MLXBF_BOOTCTL_NUM_SVC_CALLS 12
> +
> +/* Valid reset actions for MLXBF_BOOTCTL_SET_RESET_ACTION. */
> +#define MLXBF_BOOTCTL_EXTERNAL	0 /* Not boot from eMMC */
> +#define MLXBF_BOOTCTL_EMMC	1 /* From primary eMMC boot partition */
> +#define MLNX_BOOTCTL_SWAP_EMMC	2 /* Swap eMMC boot partitions and reboot */
> +#define MLXBF_BOOTCTL_EMMC_LEGACY	3 /* From primary eMMC in legacy mode */
> +
> +/* Valid arguments for requesting the fuse status. */
> +#define MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE	0 /* Return lifecycle status. */
> +#define MLXBF_BOOTCTL_FUSE_STATUS_KEYS	1 /* Return secure boot key status */
> +
> +/* Additional value to disable the MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION. */
> +#define MLXBF_BOOTCTL_NONE	0x7fffffff /* Don't change next boot action */
> +
> +#endif /* __MLXBF_BOOTCTL_H__ */
> -- 
> 1.8.3.1
> 
