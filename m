Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF311BE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 21:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfLKUjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 15:39:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbfLKUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:39:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBKGgcU068555;
        Wed, 11 Dec 2019 15:39:30 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf8jdbug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 15:39:27 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBBKZRvp001591;
        Wed, 11 Dec 2019 20:39:02 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 2wr3q6r655-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 20:39:02 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBBKd1AM35324286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 20:39:01 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 290026E050;
        Wed, 11 Dec 2019 20:39:01 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC346E056;
        Wed, 11 Dec 2019 20:39:00 +0000 (GMT)
Received: from [9.211.120.71] (unknown [9.211.120.71])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Dec 2019 20:39:00 +0000 (GMT)
Subject: Re: [PATCH v2 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
To:     Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        linux-aspeed@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        mark.rutland@arm.com, Joel Stanley <joel@jms.id.au>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-7-git-send-email-eajames@linux.ibm.com>
 <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
Date:   Wed, 11 Dec 2019 14:39:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_06:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/19 9:47 PM, Andrew Jeffery wrote:
>
> On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
>> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
>> DMA operations between the SOC (acting as a BMC) and a host processor
>> in a server.
>>
>> This commit adds a driver to control the XDMA engine and adds functions
>> to initialize the hardware and memory and start DMA operations.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>   - Add lock comments
>>   - Don't split reset into start/finish
>>   - Drop client_lock as the new reset method means client data is safe
>>   - Switch to a chip structure to control versions rather than enum/switch
>>   - Drop in_progress bool in favor or current_client being NULL or not
>>   - Get SDRAM controller from dts phandle
>>   - Configure PCI-E based on dts property
>>   - Get VGA memory space from dts property
>>   - Drop bmc_addr from aspeed_xdma_op as mmap can do all that
>>
>>   MAINTAINERS                      |   2 +
>>   drivers/soc/aspeed/Kconfig       |   8 +
>>   drivers/soc/aspeed/Makefile      |   1 +
>>   drivers/soc/aspeed/aspeed-xdma.c | 783 +++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/aspeed-xdma.h |  41 ++
>>   5 files changed, 835 insertions(+)
>>   create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
>>   create mode 100644 include/uapi/linux/aspeed-xdma.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 528a142..617c03d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2712,6 +2712,8 @@ M:	Eddie James <eajames@linux.ibm.com>
>>   L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
>> +F:	drivers/soc/aspeed/aspeed-xdma.c
>> +F:	include/uapi/linux/aspeed-xdma.h
>>   
>>   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>   M:	Corentin Chary <corentin.chary@gmail.com>
>> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
>> index 323e177..2a6c16f 100644
>> --- a/drivers/soc/aspeed/Kconfig
>> +++ b/drivers/soc/aspeed/Kconfig
>> @@ -29,4 +29,12 @@ config ASPEED_P2A_CTRL
>>   	  ioctl()s, the driver also provides an interface for userspace mappings to
>>   	  a pre-defined region.
>>   
>> +config ASPEED_XDMA
>> +	tristate "Aspeed XDMA Engine Driver"
>> +	depends on SOC_ASPEED && REGMAP && MFD_SYSCON && HAS_DMA
>> +	help
>> +	  Enable support for the Aspeed XDMA Engine found on the Aspeed AST2XXX
>> +	  SOCs. The XDMA engine can perform automatic PCI DMA operations
>> +	  between the AST2XXX (acting as a BMC) and a host processor.
>> +
>>   endmenu
>> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
>> index b64be47..977b046 100644
>> --- a/drivers/soc/aspeed/Makefile
>> +++ b/drivers/soc/aspeed/Makefile
>> @@ -2,3 +2,4 @@
>>   obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
>>   obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>>   obj-$(CONFIG_ASPEED_P2A_CTRL)	+= aspeed-p2a-ctrl.o
>> +obj-$(CONFIG_ASPEED_XDMA)	+= aspeed-xdma.o
>> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
>> new file mode 100644
>> index 0000000..a9b3eeb
>> --- /dev/null
>> +++ b/drivers/soc/aspeed/aspeed-xdma.c
>> @@ -0,0 +1,783 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright IBM Corp 2019
>> +
>> +#include <linux/aspeed-xdma.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/fs.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/poll.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/string.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/wait.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define DEVICE_NAME				"aspeed-xdma"
>> +
>> +#define SCU_AST2500_PCIE_CONF			0x180
>> +#define SCU_AST2600_PCIE_CONF			0xc20
>> +#define  SCU_PCIE_CONF_VGA_EN			 BIT(0)
>> +#define  SCU_PCIE_CONF_VGA_EN_MMIO		 BIT(1)
>> +#define  SCU_PCIE_CONF_VGA_EN_LPC		 BIT(2)
>> +#define  SCU_PCIE_CONF_VGA_EN_MSI		 BIT(3)
>> +#define  SCU_PCIE_CONF_VGA_EN_MCTP		 BIT(4)
>> +#define  SCU_PCIE_CONF_VGA_EN_IRQ		 BIT(5)
>> +#define  SCU_PCIE_CONF_VGA_EN_DMA		 BIT(6)
>> +#define  SCU_PCIE_CONF_BMC_EN			 BIT(8)
>> +#define  SCU_PCIE_CONF_BMC_EN_MMIO		 BIT(9)
>> +#define  SCU_PCIE_CONF_BMC_EN_MSI		 BIT(11)
>> +#define  SCU_PCIE_CONF_BMC_EN_MCTP		 BIT(12)
>> +#define  SCU_PCIE_CONF_BMC_EN_IRQ		 BIT(13)
>> +#define  SCU_PCIE_CONF_BMC_EN_DMA		 BIT(14)
>> +
>> +#define SCU_AST2500_BMC_CLASS_REV		0x19c
>> +#define SCU_AST2600_BMC_CLASS_REV		0xc4c
>> +#define  SCU_BMC_CLASS_REV_XDMA			 0xff000001
>> +
>> +#define SDMC_REMAP				0x008
>> +#define  SDMC_AST2500_REMAP_PCIE		 BIT(16)
>> +#define  SDMC_AST2500_REMAP_XDMA		 BIT(17)
>> +#define  SDMC_AST2600_REMAP_XDMA		 BIT(18)
>> +
>> +#define XDMA_CMDQ_SIZE				PAGE_SIZE
>> +#define XDMA_NUM_CMDS				\
>> +	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
>> +
>> +/* Aspeed specification requires 10ms after switching the reset line */
>> +#define XDMA_RESET_TIME_MS			10
>> +
>> +#define XDMA_CMD_AST2500_PITCH_SHIFT		3
>> +#define XDMA_CMD_AST2500_PITCH_BMC		GENMASK_ULL(62, 51)
>> +#define XDMA_CMD_AST2500_PITCH_HOST		GENMASK_ULL(46, 35)
>> +#define XDMA_CMD_AST2500_PITCH_UPSTREAM		BIT_ULL(31)
>> +#define XDMA_CMD_AST2500_PITCH_ADDR		GENMASK_ULL(29, 4)
>> +#define XDMA_CMD_AST2500_PITCH_ID		BIT_ULL(0)
>> +#define XDMA_CMD_AST2500_CMD_IRQ_EN		BIT_ULL(31)
>> +#define XDMA_CMD_AST2500_CMD_LINE_NO		GENMASK_ULL(27, 16)
>> +#define XDMA_CMD_AST2500_CMD_IRQ_BMC		BIT_ULL(15)
>> +#define XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT	4
>> +#define XDMA_CMD_AST2500_CMD_LINE_SIZE		\
>> +	GENMASK_ULL(14, XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT)
>> +#define XDMA_CMD_AST2500_CMD_ID			BIT_ULL(1)
>> +
>> +#define XDMA_CMD_AST2600_PITCH_BMC		GENMASK_ULL(62, 48)
>> +#define XDMA_CMD_AST2600_PITCH_HOST		GENMASK_ULL(46, 32)
>> +#define XDMA_CMD_AST2600_PITCH_ADDR		GENMASK_ULL(30, 0)
>> +#define XDMA_CMD_AST2600_CMD_64_EN		BIT_ULL(40)
>> +#define XDMA_CMD_AST2600_CMD_IRQ_BMC		BIT_ULL(37)
>> +#define XDMA_CMD_AST2600_CMD_IRQ_HOST		BIT_ULL(36)
>> +#define XDMA_CMD_AST2600_CMD_UPSTREAM		BIT_ULL(32)
>> +#define XDMA_CMD_AST2600_CMD_LINE_NO		GENMASK_ULL(27, 16)
>> +#define XDMA_CMD_AST2600_CMD_LINE_SIZE		GENMASK_ULL(14, 0)
>> +#define XDMA_CMD_AST2600_CMD_MULTILINE_SIZE	GENMASK_ULL(14, 12)
>> +
>> +#define XDMA_AST2500_QUEUE_ENTRY_SIZE		4
>> +#define XDMA_AST2500_HOST_CMDQ_ADDR0		0x00
>> +#define XDMA_AST2500_HOST_CMDQ_ENDP		0x04
>> +#define XDMA_AST2500_HOST_CMDQ_WRITEP		0x08
>> +#define XDMA_AST2500_HOST_CMDQ_READP		0x0c
>> +#define XDMA_AST2500_BMC_CMDQ_ADDR		0x10
>> +#define XDMA_AST2500_BMC_CMDQ_ENDP		0x14
>> +#define XDMA_AST2500_BMC_CMDQ_WRITEP		0x18
>> +#define XDMA_AST2500_BMC_CMDQ_READP		0x1c
>> +#define  XDMA_BMC_CMDQ_READP_RESET		 0xee882266
>> +#define XDMA_AST2500_CTRL			0x20
>> +#define  XDMA_AST2500_CTRL_US_COMP		 BIT(4)
>> +#define  XDMA_AST2500_CTRL_DS_COMP		 BIT(5)
>> +#define  XDMA_AST2500_CTRL_DS_DIRTY		 BIT(6)
>> +#define  XDMA_AST2500_CTRL_DS_SIZE_256		 BIT(17)
>> +#define  XDMA_AST2500_CTRL_DS_TIMEOUT		 BIT(28)
>> +#define  XDMA_AST2500_CTRL_DS_CHECK_ID		 BIT(29)
>> +#define XDMA_AST2500_STATUS			0x24
>> +#define  XDMA_AST2500_STATUS_US_COMP		 BIT(4)
>> +#define  XDMA_AST2500_STATUS_DS_COMP		 BIT(5)
>> +#define  XDMA_AST2500_STATUS_DS_DIRTY		 BIT(6)
>> +#define XDMA_AST2500_INPRG_DS_CMD1		0x38
>> +#define XDMA_AST2500_INPRG_DS_CMD2		0x3c
>> +#define XDMA_AST2500_INPRG_US_CMD00		0x40
>> +#define XDMA_AST2500_INPRG_US_CMD01		0x44
>> +#define XDMA_AST2500_INPRG_US_CMD10		0x48
>> +#define XDMA_AST2500_INPRG_US_CMD11		0x4c
>> +#define XDMA_AST2500_INPRG_US_CMD20		0x50
>> +#define XDMA_AST2500_INPRG_US_CMD21		0x54
>> +#define XDMA_AST2500_HOST_CMDQ_ADDR1		0x60
>> +#define XDMA_AST2500_VGA_CMDQ_ADDR0		0x64
>> +#define XDMA_AST2500_VGA_CMDQ_ENDP		0x68
>> +#define XDMA_AST2500_VGA_CMDQ_WRITEP		0x6c
>> +#define XDMA_AST2500_VGA_CMDQ_READP		0x70
>> +#define XDMA_AST2500_VGA_CMD_STATUS		0x74
>> +#define XDMA_AST2500_VGA_CMDQ_ADDR1		0x78
>> +
>> +#define XDMA_AST2600_QUEUE_ENTRY_SIZE		2
>> +#define XDMA_AST2600_HOST_CMDQ_ADDR0		0x00
>> +#define XDMA_AST2600_HOST_CMDQ_ADDR1		0x04
>> +#define XDMA_AST2600_HOST_CMDQ_ENDP		0x08
>> +#define XDMA_AST2600_HOST_CMDQ_WRITEP		0x0c
>> +#define XDMA_AST2600_HOST_CMDQ_READP		0x10
>> +#define XDMA_AST2600_BMC_CMDQ_ADDR		0x14
>> +#define XDMA_AST2600_BMC_CMDQ_ENDP		0x18
>> +#define XDMA_AST2600_BMC_CMDQ_WRITEP		0x1c
>> +#define XDMA_AST2600_BMC_CMDQ_READP		0x20
>> +#define XDMA_AST2600_VGA_CMDQ_ADDR0		0x24
>> +#define XDMA_AST2600_VGA_CMDQ_ADDR1		0x28
>> +#define XDMA_AST2600_VGA_CMDQ_ENDP		0x2c
>> +#define XDMA_AST2600_VGA_CMDQ_WRITEP		0x30
>> +#define XDMA_AST2600_VGA_CMDQ_READP		0x34
>> +#define XDMA_AST2600_CTRL			0x38
>> +#define  XDMA_AST2600_CTRL_US_COMP		 BIT(16)
>> +#define  XDMA_AST2600_CTRL_DS_COMP		 BIT(17)
>> +#define  XDMA_AST2600_CTRL_DS_DIRTY		 BIT(18)
>> +#define  XDMA_AST2600_CTRL_DS_SIZE_256		 BIT(20)
>> +#define XDMA_AST2600_STATUS			0x3c
>> +#define  XDMA_AST2600_STATUS_US_COMP		 BIT(16)
>> +#define  XDMA_AST2600_STATUS_DS_COMP		 BIT(17)
>> +#define  XDMA_AST2600_STATUS_DS_DIRTY		 BIT(18)
>> +#define XDMA_AST2600_INPRG_DS_CMD00		0x40
>> +#define XDMA_AST2600_INPRG_DS_CMD01		0x44
>> +#define XDMA_AST2600_INPRG_DS_CMD10		0x48
>> +#define XDMA_AST2600_INPRG_DS_CMD11		0x4c
>> +#define XDMA_AST2600_INPRG_DS_CMD20		0x50
>> +#define XDMA_AST2600_INPRG_DS_CMD21		0x54
>> +#define XDMA_AST2600_INPRG_US_CMD00		0x60
>> +#define XDMA_AST2600_INPRG_US_CMD01		0x64
>> +#define XDMA_AST2600_INPRG_US_CMD10		0x68
>> +#define XDMA_AST2600_INPRG_US_CMD11		0x6c
>> +#define XDMA_AST2600_INPRG_US_CMD20		0x70
>> +#define XDMA_AST2600_INPRG_US_CMD21		0x74
>> +
>> +struct aspeed_xdma_cmd {
>> +	u64 host_addr;
>> +	u64 pitch;
>> +	u64 cmd;
>> +	u64 reserved;
>> +};
>> +
>> +struct aspeed_xdma_regs {
>> +	u8 bmc_cmdq_addr;
>> +	u8 bmc_cmdq_endp;
>> +	u8 bmc_cmdq_writep;
>> +	u8 bmc_cmdq_readp;
>> +	u8 control;
>> +	u8 status;
>> +};
>> +
>> +struct aspeed_xdma_status_bits {
>> +	u32 us_comp;
>> +	u32 ds_comp;
>> +	u32 ds_dirty;
>> +};
>> +
>> +struct aspeed_xdma;
>> +
>> +struct aspeed_xdma_chip {
>> +	u32 control;
>> +	u32 scu_bmc_class;
>> +	u32 scu_pcie_conf;
>> +	u32 sdmc_remap;
>> +	unsigned int queue_entry_size;
>> +	struct aspeed_xdma_regs regs;
>> +	struct aspeed_xdma_status_bits status_bits;
>> +	unsigned int (*set_cmd)(struct aspeed_xdma *ctx,
>> +				struct aspeed_xdma_op *op, u32 bmc_addr);
>> +};
>> +
>> +struct aspeed_xdma_client;
>> +
>> +struct aspeed_xdma {
>> +	const struct aspeed_xdma_chip *chip;
>> +
>> +	struct device *dev;
>> +	void __iomem *base;
>> +	struct clk *clock;
>> +	struct reset_control *reset;
>> +
>> +	struct aspeed_xdma_client *current_client;
>> +
>> +	/* start_lock protects cmd_idx, cmdq, and the state of the engine */
>> +	struct mutex start_lock;
>> +	void *cmdq;
> Can this not be typed as `struct aspeed_xdma_cmd *cmdq`?


Good idea.


>
>> +	bool in_reset;
> Bit of a nit, but can we move in_reset under reset_lock below?
>
>> +	bool upstream;
>> +	unsigned int cmd_idx;
>> +
>> +	/* reset_lock protects in_reset and the reset state of the engine */
>> +	spinlock_t reset_lock;
>> +
>> +	wait_queue_head_t wait;
>> +	struct work_struct reset_work;
>> +
>> +	u32 vga_phys;
>> +	u32 vga_size;
>> +	void __iomem *vga_virt;
>> +	dma_addr_t cmdq_vga_phys;
>> +	void *cmdq_vga_virt;
>> +	struct gen_pool *vga_pool;
> This shouldn't have anything to do with VGA specifically, we could
> theoretically use any other piece of reserved memory (in the right
> security context).
>
>> +};
>> +
>> +struct aspeed_xdma_client {
>> +	struct aspeed_xdma *ctx;
>> +
>> +	bool error;
>> +	bool in_progress;
>> +	void *virt;
>> +	dma_addr_t phys;
>> +	u32 size;
>> +};
>> +
>> +static u32 aspeed_xdma_readl(struct aspeed_xdma *ctx, u8 reg)
>> +{
>> +	u32 v = readl(ctx->base + reg);
>> +
>> +	dev_dbg(ctx->dev, "read %02x[%08x]\n", reg, v);
>> +	return v;
>> +}
>> +
>> +static void aspeed_xdma_writel(struct aspeed_xdma *ctx, u8 reg, u32 val)
>> +{
>> +	writel(val, ctx->base + reg);
>> +	dev_dbg(ctx->dev, "write %02x[%08x]\n", reg, val);
>> +}
>> +
>> +static void aspeed_xdma_init_eng(struct aspeed_xdma *ctx)
>> +{
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_endp,
>> +			   ctx->chip->queue_entry_size * XDMA_NUM_CMDS);
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_readp,
>> +			   XDMA_BMC_CMDQ_READP_RESET);
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_writep, 0);
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.control, ctx->chip->control);
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_addr,
>> +			   ctx->cmdq_vga_phys);
>> +
>> +	ctx->cmd_idx = 0;
>> +	ctx->current_client = NULL;
>> +}
>> +
>> +static unsigned int aspeed_xdma_ast2500_set_cmd(struct aspeed_xdma *ctx,
>> +						struct aspeed_xdma_op *op,
>> +						u32 bmc_addr)
>> +{
>> +	u64 cmd = XDMA_CMD_AST2500_CMD_IRQ_EN | XDMA_CMD_AST2500_CMD_IRQ_BMC |
>> +		XDMA_CMD_AST2500_CMD_ID;
>> +	u64 cmd_pitch = (op->direction ? XDMA_CMD_AST2500_PITCH_UPSTREAM : 0) |
>> +		XDMA_CMD_AST2500_PITCH_ID;
>> +	unsigned int line_size;
>> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
>> +	unsigned int line_no = 1;
>> +	unsigned int pitch = 1;
>> +	struct aspeed_xdma_cmd *ncmd =
>> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
> Changing ctx->cmdq away from a `void *` would help out here.
>
>> +
>> +	dev_dbg(ctx->dev, "xdma %s ast2500: bmc[%08x] len[%08x] host[%08x]\n",
>> +		op->direction ? "upstream" : "downstream", bmc_addr, op->len,
>> +		(u32)op->host_addr);
>> +
>> +	if (op->len > XDMA_CMD_AST2500_CMD_LINE_SIZE) {
>> +		unsigned int rem;
>> +		unsigned int total;
>> +
>> +		line_no = op->len / XDMA_CMD_AST2500_CMD_LINE_SIZE;
>> +		total = XDMA_CMD_AST2500_CMD_LINE_SIZE * line_no;
>> +		rem = (op->len - total) >>
>> +			XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
>> +		line_size = XDMA_CMD_AST2500_CMD_LINE_SIZE;
>> +		pitch = line_size >> XDMA_CMD_AST2500_PITCH_SHIFT;
>> +		line_size >>= XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
>> +
>> +		if (rem) {
>> +			u32 rbmc = bmc_addr + total;
>> +			struct aspeed_xdma_cmd *rcmd =
>> +				&(((struct aspeed_xdma_cmd *)ctx->cmdq)[nidx]);
>> +
>> +			rcmd->host_addr = op->host_addr + (u64)total;
>> +			rcmd->pitch = cmd_pitch |
>> +				((u64)rbmc & XDMA_CMD_AST2500_PITCH_ADDR) |
>> +				FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, 1) |
>> +				FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, 1);
>> +			rcmd->cmd = cmd |
>> +				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, 1) |
>> +				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE,
>> +					   rem);
>> +
>> +			print_hex_dump_debug("xdma rem ", DUMP_PREFIX_OFFSET,
>> +					     16, 1, rcmd, sizeof(*rcmd), true);
>> +
>> +			cmd &= ~(XDMA_CMD_AST2500_CMD_IRQ_EN |
>> +				 XDMA_CMD_AST2500_CMD_IRQ_BMC);
>> +
>> +			nidx = (nidx + 1) % XDMA_NUM_CMDS;
>> +		}
>> +	} else {
>> +		line_size = op->len >> XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
>> +	}
>> +
>> +	ncmd->host_addr = op->host_addr;
>> +	ncmd->pitch = cmd_pitch |
>> +		((u64)bmc_addr & XDMA_CMD_AST2500_PITCH_ADDR) |
>> +		FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, pitch) |
>> +		FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, pitch);
>> +	ncmd->cmd = cmd | FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, line_no) |
>> +		FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE, line_size);
>> +
>> +	print_hex_dump_debug("xdma cmd ", DUMP_PREFIX_OFFSET, 16, 1, ncmd,
>> +			     sizeof(*ncmd), true);
>> +
>> +	return nidx;
>> +}
>> +
>> +static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
>> +						struct aspeed_xdma_op *op,
>> +						u32 bmc_addr)
>> +{
>> +	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
>> +		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
>> +	unsigned int line_size;
>> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
>> +	unsigned int line_no = 1;
>> +	unsigned int pitch = 1;
>> +	struct aspeed_xdma_cmd *ncmd =
>> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
>> +
>> +	if ((op->host_addr + op->len) & 0xffffffff00000000ULL)
> Do we know that this won't wrap?


No, but I assume it would be a bad transfer anyway at that point?


>
>> +		cmd |= XDMA_CMD_AST2600_CMD_64_EN;
>> +
>> +	dev_dbg(ctx->dev, "xdma %s ast2600: bmc[%08x] len[%08x] "
>> +		"host[%016llx]\n", op->direction ? "upstream" : "downstream",
>> +		bmc_addr, op->len, op->host_addr);
>> +
>> +	if (op->len > XDMA_CMD_AST2600_CMD_LINE_SIZE) {
>> +		unsigned int rem;
>> +		unsigned int total;
>> +
>> +		line_no = op->len / XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
>> +		total = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE * line_no;
>> +		rem = op->len - total;
>> +		line_size = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
>> +		pitch = line_size;
>> +
>> +		if (rem) {
>> +			u32 rbmc = bmc_addr + total;
>> +			struct aspeed_xdma_cmd *rcmd =
>> +				&(((struct aspeed_xdma_cmd *)ctx->cmdq)[nidx]);
>> +
>> +			rcmd->host_addr = op->host_addr + (u64)total;
>> +			rcmd->pitch =
>> +				((u64)rbmc & XDMA_CMD_AST2600_PITCH_ADDR) |
>> +				FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, 1) |
>> +				FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, 1);
>> +			rcmd->cmd = cmd |
>> +				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, 1) |
>> +				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE,
>> +					   rem);
>> +
>> +			print_hex_dump_debug("xdma rem ", DUMP_PREFIX_OFFSET,
>> +					     16, 1, rcmd, sizeof(*rcmd), true);
>> +
>> +			cmd &= ~XDMA_CMD_AST2600_CMD_IRQ_BMC;
>> +
>> +			nidx = (nidx + 1) % XDMA_NUM_CMDS;
>> +		}
>> +	} else {
>> +		line_size = op->len;
>> +	}
>> +
>> +	ncmd->host_addr = op->host_addr;
>> +	ncmd->pitch = ((u64)bmc_addr & XDMA_CMD_AST2600_PITCH_ADDR) |
>> +		FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, pitch) |
>> +		FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, pitch);
>> +	ncmd->cmd = cmd | FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, line_no) |
>> +		FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE, line_size);
>> +
>> +	print_hex_dump_debug("xdma cmd ", DUMP_PREFIX_OFFSET, 16, 1, ncmd,
>> +			     sizeof(*ncmd), true);
>> +
>> +	return nidx;
>> +}
>> +
>> +static void aspeed_xdma_start(struct aspeed_xdma *ctx,
>> +			      struct aspeed_xdma_op *op, u32 bmc_addr,
>> +			      struct aspeed_xdma_client *client)
>> +{
>> +	unsigned int nidx;
>> +
>> +	mutex_lock(&ctx->start_lock);
>> +
>> +	nidx = ctx->chip->set_cmd(ctx, op, bmc_addr);
>> +	memcpy(ctx->cmdq_vga_virt, ctx->cmdq, XDMA_CMDQ_SIZE);
>> +
>> +	client->in_progress = true;
>> +	ctx->current_client = client;
>> +	ctx->upstream = op->direction ? true : false;
> Could get away without the branch, just assign directly or use the !! idiom
> (you're already turning op->direction into a boolean by using it as the
> condition).
>
>> +
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.bmc_cmdq_writep,
>> +			   nidx * ctx->chip->queue_entry_size);
>> +
>> +	ctx->cmd_idx = nidx;
>> +
>> +	mutex_unlock(&ctx->start_lock);
>> +}
>> +
>> +static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
>> +{
>> +	if (ctx->current_client) {
>> +		ctx->current_client->error = error;
>> +		ctx->current_client->in_progress = false;
>> +		ctx->current_client = NULL;
> You need to take start_lock before writing these members to ensure the
> writes are not reordered across acquisition of start_lock in
> aspeed_xdma_start() above, unless there's some other guarantee of that?


Unless we get spurious interrupts (as in, the xdma interrupt fires with 
no transfer started, and somehow the correct status bits are set), it's 
not possible to execute this at the same time as aspeed_xdma_start(). So 
I did not try and lock here. Do you think it's worth locking for that 
situation?


>
> I see that aspeed_xdma_done() is called from aspeed_xdma_irq() below,
> so maybe we need a different locking strategy or punt aspeed_xdma_done()
> to a workqueue, as start_lock is a mutex.
>
>> +	}
>> +
>> +	wake_up_interruptible_all(&ctx->wait);
>> +}
>> +
>> +static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
>> +{
>> +	struct aspeed_xdma *ctx = arg;
>> +	u32 status = aspeed_xdma_readl(ctx, ctx->chip->regs.status);
>> +
>> +	if (status & ctx->chip->status_bits.ds_dirty) {
>> +		aspeed_xdma_done(ctx, true);
>> +	} else {
>> +		if (status & ctx->chip->status_bits.us_comp) {
>> +			if (ctx->upstream)
>> +				aspeed_xdma_done(ctx, false);
>> +		}
>> +
>> +		if (status & ctx->chip->status_bits.ds_comp) {
>> +			if (!ctx->upstream)
>> +				aspeed_xdma_done(ctx, false);
>> +		}
>> +	}
>> +
>> +	aspeed_xdma_writel(ctx, ctx->chip->regs.status, status);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void aspeed_xdma_reset(struct aspeed_xdma *ctx)
>> +{
>> +	reset_control_assert(ctx->reset);
>> +	msleep(XDMA_RESET_TIME_MS);
>> +
>> +	reset_control_deassert(ctx->reset);
>> +	msleep(XDMA_RESET_TIME_MS);
>> +
>> +	aspeed_xdma_init_eng(ctx);
>> +
>> +	ctx->in_reset = false;
>> +	aspeed_xdma_done(ctx, true);
>> +}
>> +
>> +static void aspeed_xdma_reset_work(struct work_struct *work)
>> +{
>> +	struct aspeed_xdma *ctx = container_of(work, struct aspeed_xdma,
>> +					       reset_work);
>> +
>> +	/*
>> +	 * Lock to make sure operations aren't started while the engine is
>> +	 * in reset.
>> +	 */
>> +	mutex_lock(&ctx->start_lock);
>> +
>> +	aspeed_xdma_reset(ctx);
>> +
>> +	mutex_unlock(&ctx->start_lock);
>> +}
>> +
>> +static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
>> +{
>> +	unsigned long flags;
>> +	struct aspeed_xdma *ctx = arg;
>> +
>> +	dev_dbg(ctx->dev, "pcie reset\n");
>> +
>> +	spin_lock_irqsave(&ctx->reset_lock, flags);
>> +	if (ctx->in_reset) {
>> +		spin_unlock_irqrestore(&ctx->reset_lock, flags);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	ctx->in_reset = true;
>> +	spin_unlock_irqrestore(&ctx->reset_lock, flags);
>> +
>> +	schedule_work(&ctx->reset_work);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int aspeed_xdma_probe(struct platform_device *pdev)
>> +{
>> +	int irq;
>> +	int pcie_irq;
>> +	int rc;
>> +	u32 vgamem[2];
>> +	struct regmap *scu;
>> +	struct regmap *sdmc;
>> +	struct aspeed_xdma *ctx;
>> +	struct device *dev = &pdev->dev;
>> +	const void *md = of_device_get_match_data(dev);
> So close to reverse christmas tree :)


I'll be sure to fix it :)


>
>> +
>> +	if (!md)
>> +		return -ENODEV;
>> +
>> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	ctx->chip = md;
>> +	ctx->dev = dev;
>> +	platform_set_drvdata(pdev, ctx);
>> +	mutex_init(&ctx->start_lock);
>> +	INIT_WORK(&ctx->reset_work, aspeed_xdma_reset_work);
>> +	spin_lock_init(&ctx->reset_lock);
>> +	init_waitqueue_head(&ctx->wait);
>> +
>> +	ctx->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(ctx->base)) {
>> +		dev_err(dev, "Failed to map registers.\n");
>> +		return PTR_ERR(ctx->base);
>> +	}
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(dev, "Unable to find IRQ.\n");
>> +		return irq;
>> +	}
>> +
>> +	rc = devm_request_irq(dev, irq, aspeed_xdma_irq, IRQF_SHARED,
>> +			      DEVICE_NAME, ctx);
>> +	if (rc < 0) {
>> +		dev_err(dev, "Failed to request IRQ %d.\n", irq);
>> +		return rc;
>> +	}
>> +
>> +	ctx->clock = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(ctx->clock)) {
>> +		dev_err(dev, "Failed to request clock.\n");
>> +		return PTR_ERR(ctx->clock);
>> +	}
>> +
>> +	ctx->reset = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(ctx->reset)) {
>> +		dev_err(dev, "Failed to request reset control.\n");
>> +		return PTR_ERR(ctx->reset);
>> +	}
>> +
>> +	ctx->cmdq = devm_kzalloc(ctx->dev, XDMA_CMDQ_SIZE, GFP_KERNEL);
>> +	if (!ctx->cmdq) {
>> +		dev_err(dev, "Failed to allocate command queue.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ctx->vga_pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
>> +	if (!ctx->vga_pool) {
>> +		dev_err(dev, "Failed to setup genalloc pool.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	rc = of_property_read_u32_array(dev->of_node, "vga-mem", vgamem, 2);
> As mentioned, this could be any reserved memory range. Also can't we get it as
> a resource rather than parsing a u32 array? Not sure if there's an advantage
> but it feels like a better representation.


That doesn't work unfortunately because the VGA memory is not mapped and 
the reserved memory subsystem fails to find it.


>
>> +	if (rc) {
>> +		dev_err(dev, "Unable to get VGA memory space.\n");
>> +		return rc;
>> +	}
>> +
>> +	ctx->vga_phys = vgamem[0];
>> +	ctx->vga_size = vgamem[1];
>> +
>> +	ctx->vga_virt = devm_ioremap(dev, ctx->vga_phys, ctx->vga_size);
>> +	if (IS_ERR(ctx->vga_virt)) {
>> +		dev_err(dev, "Failed to map VGA memory space.\n");
>> +		return PTR_ERR(ctx->vga_virt);
>> +	}
>> +
>> +	rc = gen_pool_add_virt(ctx->vga_pool, (unsigned long)ctx->vga_virt,
>> +			       ctx->vga_phys, ctx->vga_size, -1);
>> +	if (rc) {
>> +		dev_err(ctx->dev, "Failed to add memory to genalloc pool.\n");
>> +		return rc;
>> +	}
>> +
>> +	sdmc = syscon_regmap_lookup_by_phandle(dev->of_node, "sdmc");
>> +	if (IS_ERR(sdmc)) {
>> +		dev_err(dev, "Unable to configure memory controller.\n");
>> +		return PTR_ERR(sdmc);
>> +	}
>> +
>> +	regmap_update_bits(sdmc, SDMC_REMAP, ctx->chip->sdmc_remap,
>> +			   ctx->chip->sdmc_remap);
> I disagree with doing this. As mentioned on the bindings it should be up to
> the platform integrator to ensure that this is configured appropriately.


Probably so, but then how does one actually configure that elsewhere? Do 
you mean add code to the edac driver (and add support for the ast2600) 
to read some dts properties to set it?


>
>> +
>> +	scu = syscon_regmap_lookup_by_phandle(dev->of_node, "scu");
>> +	if (!IS_ERR(scu)) {
>> +		u32 selection;
>> +		bool pcie_device_bmc = true;
>> +		const u32 bmc = SCU_PCIE_CONF_BMC_EN |
>> +			SCU_PCIE_CONF_BMC_EN_MSI | SCU_PCIE_CONF_BMC_EN_IRQ |
>> +			SCU_PCIE_CONF_BMC_EN_DMA;
>> +		const u32 vga = SCU_PCIE_CONF_VGA_EN |
>> +			SCU_PCIE_CONF_VGA_EN_MSI | SCU_PCIE_CONF_VGA_EN_IRQ |
>> +			SCU_PCIE_CONF_VGA_EN_DMA;
>> +		const char *pcie = NULL;
>> +
>> +		if (!of_property_read_string(dev->of_node, "pcie-device",
>> +					     &pcie)) {
>> +			if (!strcmp(pcie, "vga"))
>> +				pcie_device_bmc = false;
> You need to return an error here if the string is not one of "vga" or "bmc". This
> just assumes that anything that isn't "vga" is "bmc".
>
>> +		}
>> +
>> +		if (pcie_device_bmc) {
>> +			selection = bmc;
>> +			regmap_write(scu, ctx->chip->scu_bmc_class,
>> +				     SCU_BMC_CLASS_REV_XDMA);
>> +		} else {
>> +			selection = vga;
>> +		}
>> +
>> +		regmap_update_bits(scu, ctx->chip->scu_pcie_conf, bmc | vga,
>> +				   selection);
>> +	} else {
>> +		dev_warn(dev, "Unable to configure PCIe; continuing.\n");
>> +	}
>> +
>> +	rc = clk_prepare_enable(ctx->clock);
>> +	if (rc) {
>> +		dev_err(dev, "Failed to enable the clock.\n");
>> +		return rc;
>> +	}
>> +	msleep(XDMA_RESET_TIME_MS);
>> +
>> +	rc = reset_control_deassert(ctx->reset);
>> +	if (rc) {
>> +		clk_disable_unprepare(ctx->clock);
>> +
>> +		dev_err(dev, "Failed to clear the reset.\n");
>> +		return rc;
>> +	}
>> +	msleep(XDMA_RESET_TIME_MS);
>> +
>> +	ctx->cmdq_vga_virt = gen_pool_dma_alloc(ctx->vga_pool, XDMA_CMDQ_SIZE,
>> +						&ctx->cmdq_vga_phys);
>> +	if (!ctx->cmdq_vga_virt) {
>> +		dev_err(ctx->dev, "Failed to genalloc cmdq.\n");
>> +
>> +		reset_control_assert(ctx->reset);
>> +		clk_disable_unprepare(ctx->clock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	aspeed_xdma_init_eng(ctx);
>> +
>> +	/*
>> +	 * This interrupt could fire immediately so only request it once the
>> +	 * engine and driver are initialized.
>> +	 */
>> +	pcie_irq = platform_get_irq(pdev, 1);
>> +	if (pcie_irq < 0) {
>> +		dev_warn(dev, "Unable to find PCI-E IRQ.\n");
>> +	} else {
>> +		rc = devm_request_irq(dev, pcie_irq, aspeed_xdma_pcie_irq,
>> +				      IRQF_SHARED, DEVICE_NAME, ctx);
>> +		if (rc < 0)
>> +			dev_warn(dev, "Failed to request PCI-E IRQ %d.\n", rc);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_xdma_remove(struct platform_device *pdev)
>> +{
>> +	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
>> +
>> +	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
>> +		      XDMA_CMDQ_SIZE);
>> +
>> +	reset_control_assert(ctx->reset);
>> +	clk_disable_unprepare(ctx->clock);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct aspeed_xdma_chip aspeed_ast2500_xdma_chip = {
>> +	.control = XDMA_AST2500_CTRL_US_COMP | XDMA_AST2500_CTRL_DS_COMP |
>> +		XDMA_AST2500_CTRL_DS_DIRTY | XDMA_AST2500_CTRL_DS_SIZE_256 |
>> +		XDMA_AST2500_CTRL_DS_TIMEOUT | XDMA_AST2500_CTRL_DS_CHECK_ID,
>> +	.scu_bmc_class = SCU_AST2500_BMC_CLASS_REV,
>> +	.scu_pcie_conf = SCU_AST2500_PCIE_CONF,
>> +	.sdmc_remap = SDMC_AST2500_REMAP_PCIE | SDMC_AST2500_REMAP_XDMA,
>> +	.queue_entry_size = XDMA_AST2500_QUEUE_ENTRY_SIZE,
>> +	.regs = {
>> +		.bmc_cmdq_addr = XDMA_AST2500_BMC_CMDQ_ADDR,
>> +		.bmc_cmdq_endp = XDMA_AST2500_BMC_CMDQ_ENDP,
>> +		.bmc_cmdq_writep = XDMA_AST2500_BMC_CMDQ_WRITEP,
>> +		.bmc_cmdq_readp = XDMA_AST2500_BMC_CMDQ_READP,
>> +		.control = XDMA_AST2500_CTRL,
>> +		.status = XDMA_AST2500_STATUS,
>> +	},
>> +	.status_bits = {
>> +		.us_comp = XDMA_AST2500_STATUS_US_COMP,
>> +		.ds_comp = XDMA_AST2500_STATUS_DS_COMP,
>> +		.ds_dirty = XDMA_AST2500_STATUS_DS_DIRTY,
>> +	},
>> +	.set_cmd = aspeed_xdma_ast2500_set_cmd,
>> +};
>> +
>> +static const struct aspeed_xdma_chip aspeed_ast2600_xdma_chip = {
>> +	.control = XDMA_AST2600_CTRL_US_COMP | XDMA_AST2600_CTRL_DS_COMP |
>> +		XDMA_AST2600_CTRL_DS_DIRTY | XDMA_AST2600_CTRL_DS_SIZE_256,
>> +	.scu_bmc_class = SCU_AST2600_BMC_CLASS_REV,
>> +	.scu_pcie_conf = SCU_AST2600_PCIE_CONF,
>> +	.sdmc_remap = SDMC_AST2600_REMAP_XDMA,
>> +	.queue_entry_size = XDMA_AST2600_QUEUE_ENTRY_SIZE,
>> +	.regs = {
>> +		.bmc_cmdq_addr = XDMA_AST2600_BMC_CMDQ_ADDR,
>> +		.bmc_cmdq_endp = XDMA_AST2600_BMC_CMDQ_ENDP,
>> +		.bmc_cmdq_writep = XDMA_AST2600_BMC_CMDQ_WRITEP,
>> +		.bmc_cmdq_readp = XDMA_AST2600_BMC_CMDQ_READP,
>> +		.control = XDMA_AST2600_CTRL,
>> +		.status = XDMA_AST2600_STATUS,
>> +	},
>> +	.status_bits = {
>> +		.us_comp = XDMA_AST2600_STATUS_US_COMP,
>> +		.ds_comp = XDMA_AST2600_STATUS_DS_COMP,
>> +		.ds_dirty = XDMA_AST2600_STATUS_DS_DIRTY,
>> +	},
>> +	.set_cmd = aspeed_xdma_ast2600_set_cmd,
>> +};
>> +
>> +static const struct of_device_id aspeed_xdma_match[] = {
>> +	{
>> +		.compatible = "aspeed,ast2500-xdma",
>> +		.data = &aspeed_ast2500_xdma_chip,
>> +	},
>> +	{
>> +		.compatible = "aspeed,ast2600-xdma",
>> +		.data = &aspeed_ast2600_xdma_chip,
>> +	},
>> +	{ },
>> +};
> Thanks, I think this representation is a lot cleaner.
>
>> +
>> +static struct platform_driver aspeed_xdma_driver = {
>> +	.probe = aspeed_xdma_probe,
>> +	.remove = aspeed_xdma_remove,
>> +	.driver = {
>> +		.name = DEVICE_NAME,
>> +		.of_match_table = aspeed_xdma_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(aspeed_xdma_driver);
>> +
>> +MODULE_AUTHOR("Eddie James");
>> +MODULE_DESCRIPTION("Aspeed XDMA Engine Driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
>> new file mode 100644
>> index 0000000..f39f38e
>> --- /dev/null
>> +++ b/include/uapi/linux/aspeed-xdma.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>> +/* Copyright IBM Corp 2019 */
>> +
>> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
>> +#define _UAPI_LINUX_ASPEED_XDMA_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * aspeed_xdma_direction
>> + *
>> + * ASPEED_XDMA_DIRECTION_DOWNSTREAM: transfers data from the host to the BMC
>> + *
>> + * ASPEED_XDMA_DIRECTION_UPSTREAM: transfers data from the BMC to the host
>> + *
>> + * ASPEED_XDMA_DIRECTION_RESET: resets the XDMA engine
>> + */
>> +enum aspeed_xdma_direction {
>> +	ASPEED_XDMA_DIRECTION_DOWNSTREAM = 0,
>> +	ASPEED_XDMA_DIRECTION_UPSTREAM,
>> +	ASPEED_XDMA_DIRECTION_RESET,
> I still think having a reset action as part of the direction is a bit funky. Can you maybe
> put that in a separate patch so we can debate it later?


I can, but I'm fairly convinced this is the cleanest way to add the 
reset functionality.


>
>> +};
>> +
>> +/*
>> + * aspeed_xdma_op
>> + *
>> + * host_addr: the DMA address on the host side, typically configured by PCI
>> + *            subsystem
>> + *
>> + * len: the size of the transfer in bytes
>> + *
>> + * direction: an enumerator indicating the direction of the DMA operation; see
>> + *            enum aspeed_xdma_direction
>> + */
>> +struct aspeed_xdma_op {
>> +	__u64 host_addr;
>> +	__u32 len;
>> +	__u32 direction;
>> +};
>> +
>> +#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
>> -- 
>> 1.8.3.1
>>
>>
