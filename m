Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D0159F17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF1PoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:44:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfF1Pn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:43:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SFgKkM136607
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:43:56 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdk9df2jx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:43:55 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Fri, 28 Jun 2019 16:43:54 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 16:43:51 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SFhoO248431398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 15:43:50 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95385AE05C;
        Fri, 28 Jun 2019 15:43:50 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0CD4AE060;
        Fri, 28 Jun 2019 15:43:49 +0000 (GMT)
Received: from [9.85.149.21] (unknown [9.85.149.21])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 15:43:49 +0000 (GMT)
Subject: Re: [PATCH v3 2/8] drivers/soc: Add Aspeed XDMA Engine Driver
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, joel@jms.id.au, andrew@aj.id.au
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
 <1559153408-31190-3-git-send-email-eajames@linux.ibm.com>
 <20190531033117.GG17772@u40b0340c692b58f6553c.ant.amazon.com>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Fri, 28 Jun 2019 10:43:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531033117.GG17772@u40b0340c692b58f6553c.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19062815-0060-0000-0000-00000356BB18
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011347; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224535; UDB=6.00644508; IPR=6.01005727;
 MB=3.00027509; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-28 15:43:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062815-0061-0000-0000-000049F0CBDE
Message-Id: <a769e83c-782b-12e9-bef8-49f9af9b1b9e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/19 10:31 PM, Eduardo Valentin wrote:
> On Wed, May 29, 2019 at 01:10:02PM -0500, Eddie James wrote:
>> The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
>> between the SOC (acting as a BMC) and a host processor in a server.
>>
>> This commit adds a driver to control the XDMA engine and adds functions
>> to initialize the hardware and memory and start DMA operations.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   MAINTAINERS                      |  10 +
>>   drivers/soc/aspeed/Kconfig       |   8 +
>>   drivers/soc/aspeed/Makefile      |   1 +
>>   drivers/soc/aspeed/aspeed-xdma.c | 520 +++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/aspeed-xdma.h |  26 ++
>>   5 files changed, 565 insertions(+)
>>   create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
>>   create mode 100644 include/uapi/linux/aspeed-xdma.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7e09dda..84e2b62 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2584,6 +2584,16 @@ S:	Maintained
>>   F:	drivers/media/platform/aspeed-video.c
>>   F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>>   
>> +ASPEED XDMA ENGINE DRIVER
>> +M:	Eddie James <eajames@linux.ibm.com>
>> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/misc/aspeed,xdma.txt
>> +F:	Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma
>> +F:	drivers/soc/aspeed/aspeed-xdma.c
>> +F:	include/uapi/linux/aspeed-xdma.h
>> +
>>   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>   M:	Corentin Chary <corentin.chary@gmail.com>
>>   L:	acpi4asus-user@lists.sourceforge.net
>> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
>> index 323e177..8b08310 100644
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
>> +	  Enable support for the Aspeed XDMA Engine found on the Aspeed AST2500
>> +	  SOC. The XDMA engine can perform automatic PCI DMA operations between
>> +	  the AST2500 (acting as a BMC) and a host processor.
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
>> index 0000000..3dc0ce4
>> --- /dev/null
>> +++ b/drivers/soc/aspeed/aspeed-xdma.c
>> @@ -0,0 +1,520 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Copyright IBM Corp 2019
>> +
>> +#include <linux/aspeed-xdma.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/fs.h>
>> +#include <linux/genalloc.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/list.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/poll.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/string.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/wait.h>
>> +
>> +#define DEVICE_NAME			"aspeed-xdma"
>> +
>> +#define SCU_STRAP			0x070
>> +#define  SCU_STRAP_VGA_MEM		GENMASK(3, 2)
>> +
>> +#define SCU_PCIE_CONF			0x180
>> +#define  SCU_PCIE_CONF_VGA_EN		BIT(0)
>> +#define  SCU_PCIE_CONF_VGA_EN_MMIO	BIT(1)
>> +#define  SCU_PCIE_CONF_VGA_EN_LPC	BIT(2)
>> +#define  SCU_PCIE_CONF_VGA_EN_MSI	BIT(3)
>> +#define  SCU_PCIE_CONF_VGA_EN_MCTP	BIT(4)
>> +#define  SCU_PCIE_CONF_VGA_EN_IRQ	BIT(5)
>> +#define  SCU_PCIE_CONF_VGA_EN_DMA	BIT(6)
>> +#define  SCU_PCIE_CONF_BMC_EN		BIT(8)
>> +#define  SCU_PCIE_CONF_BMC_EN_MMIO	BIT(9)
>> +#define  SCU_PCIE_CONF_BMC_EN_MSI	BIT(11)
>> +#define  SCU_PCIE_CONF_BMC_EN_MCTP	BIT(12)
>> +#define  SCU_PCIE_CONF_BMC_EN_IRQ	BIT(13)
>> +#define  SCU_PCIE_CONF_BMC_EN_DMA	BIT(14)
>> +#define  SCU_PCIE_CONF_RSVD		GENMASK(19, 18)
>> +
>> +#define SDMC_CONF			0x004
>> +#define  SDMC_CONF_MEM			GENMASK(1, 0)
>> +#define SDMC_REMAP			0x008
>> +#define  SDMC_REMAP_MAGIC		GENMASK(17, 16)
>> +
>> +#define XDMA_CMD_SIZE			4
>> +#define XDMA_CMDQ_SIZE			PAGE_SIZE
>> +#define XDMA_BYTE_ALIGN			16
>> +#define XDMA_MAX_LINE_SIZE		BIT(10)
>> +#define XDMA_NUM_CMDS			\
>> +	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
>> +#define XDMA_NUM_DEBUGFS_REGS		6
>> +
>> +#define XDMA_CMD_BMC_CHECK		BIT(0)
>> +#define XDMA_CMD_BMC_ADDR		GENMASK(29, 4)
>> +#define XDMA_CMD_BMC_DIR_US		BIT(31)
>> +
>> +#define XDMA_CMD_COMM1_HI_HOST_PITCH	GENMASK(14, 3)
>> +#define XDMA_CMD_COMM1_HI_BMC_PITCH	GENMASK(30, 19)
>> +
>> +#define XDMA_CMD_CONF_CHECK		BIT(1)
>> +#define XDMA_CMD_CONF_LINE_SIZE		GENMASK(14, 4)
>> +#define XDMA_CMD_CONF_IRQ_BMC		BIT(15)
>> +#define XDMA_CMD_CONF_NUM_LINES		GENMASK(27, 16)
>> +#define XDMA_CMD_CONF_IRQ		BIT(31)
>> +
>> +#define XDMA_CMD_ID_UPDIR		GENMASK(17, 16)
>> +#define  XDMA_CMD_ID_UPDIR_BMC		0
>> +#define  XDMA_CMD_ID_UPDIR_HOST		1
>> +#define  XDMA_CMD_ID_UPDIR_VGA		2
>> +
>> +#define XDMA_DS_PCIE_REQ_SIZE_128	0
>> +#define XDMA_DS_PCIE_REQ_SIZE_256	1
>> +#define XDMA_DS_PCIE_REQ_SIZE_512	2
>> +#define XDMA_DS_PCIE_REQ_SIZE_1K	3
>> +#define XDMA_DS_PCIE_REQ_SIZE_2K	4
>> +#define XDMA_DS_PCIE_REQ_SIZE_4K	5
>> +
>> +#define XDMA_BMC_CMD_QUEUE_ADDR		0x10
>> +#define XDMA_BMC_CMD_QUEUE_ENDP		0x14
>> +#define XDMA_BMC_CMD_QUEUE_WRITEP	0x18
>> +#define XDMA_BMC_CMD_QUEUE_READP	0x1c
>> +#define  XDMA_BMC_CMD_QUEUE_READP_MAGIC	0xee882266
>> +#define XDMA_CTRL			0x20
>> +#define  XDMA_CTRL_US_COMP		BIT(4)
>> +#define  XDMA_CTRL_DS_COMP		BIT(5)
>> +#define  XDMA_CTRL_DS_DIRTY		BIT(6)
>> +#define  XDMA_CTRL_DS_PCIE_REQ_SIZE	GENMASK(19, 17)
>> +#define  XDMA_CTRL_DS_DATA_TIMEOUT	BIT(28)
>> +#define  XDMA_CTRL_DS_CHECK_ID		BIT(29)
>> +#define XDMA_STATUS			0x24
>> +#define  XDMA_STATUS_US_COMP		BIT(4)
>> +#define  XDMA_STATUS_DS_COMP		BIT(5)
>> +
>> +enum {
>> +	XDMA_IN_PRG,
>> +	XDMA_UPSTREAM,
>> +};
>> +
>> +struct aspeed_xdma_cmd {
>> +	u32 host_addr_lo;
>> +	u32 host_addr_hi;
>> +	u32 bmc_addr;
>> +	u32 comm1_hi;
>> +	u32 conf;
>> +	u32 id;
>> +	u32 resv0;
>> +	u32 resv1;
>> +};
>> +
>> +struct aspeed_xdma_client;
>> +
>> +struct aspeed_xdma {
>> +	struct device *dev;
>> +	void __iomem *base;
>> +	struct regmap *scu;
>> +	struct reset_control *reset;
>> +
>> +	unsigned long flags;
> interesting.. why do we need a long size flags field when we just toggle two bits?
>  From a quick glance, looks like we use this to check for XDMA_IN_PRG and XDMA_UPSTREAM only..


That's correct. More flags could be added in the future. Are you worried 
about memory space?


>
>> +	unsigned int cmd_idx;
>> +	wait_queue_head_t wait;
>> +	struct aspeed_xdma_client *current_client;
>> +
>> +	u32 vga_phys;
>> +	u32 vga_size;
>> +	dma_addr_t vga_dma;
>> +	void *cmdq;
>> +	void *vga_virt;
>> +	dma_addr_t cmdq_vga_phys;
>> +	void *cmdq_vga_virt;
>> +	struct gen_pool *vga_pool;
>> +};
>> +
>> +struct aspeed_xdma_client {
>> +	struct aspeed_xdma *ctx;
>> +
>> +	unsigned long flags;
> same
>
>> +	void *virt;
>> +	dma_addr_t phys;
>> +	u32 size;
>> +};
>> +
>> +static const u32 aspeed_xdma_bmc_pcie_conf = SCU_PCIE_CONF_BMC_EN |
>> +	SCU_PCIE_CONF_BMC_EN_MSI | SCU_PCIE_CONF_BMC_EN_MCTP |
>> +	SCU_PCIE_CONF_BMC_EN_IRQ | SCU_PCIE_CONF_BMC_EN_DMA |
>> +	SCU_PCIE_CONF_RSVD;
>> +
>> +static const u32 aspeed_xdma_vga_pcie_conf = SCU_PCIE_CONF_VGA_EN |
>> +	SCU_PCIE_CONF_VGA_EN_MSI | SCU_PCIE_CONF_VGA_EN_MCTP |
>> +	SCU_PCIE_CONF_VGA_EN_IRQ | SCU_PCIE_CONF_VGA_EN_DMA |
>> +	SCU_PCIE_CONF_RSVD;
>> +
>> +static void aspeed_scu_pcie_write(struct aspeed_xdma *ctx, u32 conf)
>> +{
>> +	u32 v = 0;
>> +
>> +	regmap_write(ctx->scu, SCU_PCIE_CONF, conf);
>> +	regmap_read(ctx->scu, SCU_PCIE_CONF, &v);
>> +
>> +	dev_dbg(ctx->dev, "write scu pcie_conf[%08x]\n", v);
>> +}
>> +
>> +static u32 aspeed_xdma_reg_read(struct aspeed_xdma *ctx, u32 reg)
>> +{
>> +	u32 v = readl(ctx->base + reg);
>> +
>> +	dev_dbg(ctx->dev, "read %02x[%08x]\n", reg, v);
>> +	return v;
>> +}
>> +
>> +static void aspeed_xdma_reg_write(struct aspeed_xdma *ctx, u32 reg, u32 val)
>> +{
>> +	writel(val, ctx->base + reg);
>> +	dev_dbg(ctx->dev, "write %02x[%08x]\n", reg, readl(ctx->base + reg));
>> +}
>> +
>> +static void aspeed_xdma_init_eng(struct aspeed_xdma *ctx)
>> +{
>> +	const u32 ctrl = XDMA_CTRL_US_COMP | XDMA_CTRL_DS_COMP |
>> +		XDMA_CTRL_DS_DIRTY | FIELD_PREP(XDMA_CTRL_DS_PCIE_REQ_SIZE,
>> +						XDMA_DS_PCIE_REQ_SIZE_256) |
>> +		XDMA_CTRL_DS_DATA_TIMEOUT | XDMA_CTRL_DS_CHECK_ID;
>> +
>> +	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_ENDP,
>> +			      XDMA_CMD_SIZE * XDMA_NUM_CMDS);
>> +	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_READP,
>> +			      XDMA_BMC_CMD_QUEUE_READP_MAGIC);
>> +	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_WRITEP, 0);
>> +	aspeed_xdma_reg_write(ctx, XDMA_CTRL, ctrl);
>> +
>> +	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_ADDR,
>> +			      ctx->cmdq_vga_phys);
>> +
>> +	ctx->cmd_idx = 0;
>> +	ctx->flags = 0;
>> +}
>> +
>> +static void aspeed_xdma_reset(struct aspeed_xdma *ctx)
>> +{
>> +	reset_control_assert(ctx->reset);
>> +
>> +	msleep(10);
>> +
>> +	reset_control_deassert(ctx->reset);
>> +
>> +	msleep(10);
> Why 10ms?


I will add a comment. It's from the specification.


>
>> +
>> +	aspeed_xdma_init_eng(ctx);
>> +}
>> +
>> +static void aspeed_xdma_start(struct aspeed_xdma *ctx,
>> +			      struct aspeed_xdma_op *op, u32 bmc_addr)
>> +{
>> +	u32 conf = XDMA_CMD_CONF_CHECK | XDMA_CMD_CONF_IRQ_BMC |
>> +		XDMA_CMD_CONF_IRQ;
>> +	unsigned int line_size = op->len / XDMA_BYTE_ALIGN;
>> +	unsigned int num_lines = 1;
>> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
>> +	unsigned int pitch = 1;
>> +	struct aspeed_xdma_cmd *cmd =
>> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
>> +
>> +	if (line_size > XDMA_MAX_LINE_SIZE) {
>> +		unsigned int rem;
>> +		unsigned int total;
>> +
>> +		num_lines = line_size / XDMA_MAX_LINE_SIZE;
>> +		total = XDMA_MAX_LINE_SIZE * num_lines;
>> +		rem = line_size - total;
>> +		line_size = XDMA_MAX_LINE_SIZE;
>> +		pitch = line_size;
>> +
>> +		if (rem) {
>> +			unsigned int offs = total * XDMA_BYTE_ALIGN;
>> +			u32 r_bmc_addr = bmc_addr + offs;
>> +			u64 r_host_addr = op->host_addr + (u64)offs;
>> +			struct aspeed_xdma_cmd *r_cmd =
>> +				&(((struct aspeed_xdma_cmd *)ctx->cmdq)[nidx]);
>> +
>> +			r_cmd->host_addr_lo =
>> +				(u32)(r_host_addr & 0xFFFFFFFFULL);
>> +			r_cmd->host_addr_hi = (u32)(r_host_addr >> 32ULL);
>> +			r_cmd->bmc_addr = (r_bmc_addr & XDMA_CMD_BMC_ADDR) |
>> +				XDMA_CMD_BMC_CHECK |
>> +				(op->upstream ? XDMA_CMD_BMC_DIR_US : 0);
>> +			r_cmd->conf = conf |
>> +				FIELD_PREP(XDMA_CMD_CONF_LINE_SIZE, rem) |
>> +				FIELD_PREP(XDMA_CMD_CONF_NUM_LINES, 1);
>> +			r_cmd->comm1_hi =
>> +				FIELD_PREP(XDMA_CMD_COMM1_HI_HOST_PITCH, 1) |
>> +				FIELD_PREP(XDMA_CMD_COMM1_HI_BMC_PITCH, 1);
>> +
>> +			/* do not trigger IRQ for first command */
>> +			conf = XDMA_CMD_CONF_CHECK;
>> +
>> +			nidx = (nidx + 1) % XDMA_NUM_CMDS;
>> +		}
>> +
>> +		/* undocumented formula to get required number of lines */
>> +		num_lines = (num_lines * 2) - 1;
>> +	}
>> +
>> +	/* ctrl == 0 indicates engine hasn't started properly; restart it */
>> +	if (!aspeed_xdma_reg_read(ctx, XDMA_CTRL))
>> +		aspeed_xdma_reset(ctx);
>> +
>> +	cmd->host_addr_lo = (u32)(op->host_addr & 0xFFFFFFFFULL);
>> +	cmd->host_addr_hi = (u32)(op->host_addr >> 32ULL);
>> +	cmd->bmc_addr = (bmc_addr & XDMA_CMD_BMC_ADDR) | XDMA_CMD_BMC_CHECK |
>> +		(op->upstream ? XDMA_CMD_BMC_DIR_US : 0);
>> +	cmd->conf = conf |
>> +		FIELD_PREP(XDMA_CMD_CONF_LINE_SIZE, line_size) |
>> +		FIELD_PREP(XDMA_CMD_CONF_NUM_LINES, num_lines);
>> +	cmd->comm1_hi = FIELD_PREP(XDMA_CMD_COMM1_HI_HOST_PITCH, pitch) |
>> +			FIELD_PREP(XDMA_CMD_COMM1_HI_BMC_PITCH, pitch);
>> +
>> +	memcpy(ctx->cmdq_vga_virt, ctx->cmdq, XDMA_CMDQ_SIZE);
>> +
>> +	if (op->upstream)
>> +		set_bit(XDMA_UPSTREAM, &ctx->flags);
>> +	else
>> +		clear_bit(XDMA_UPSTREAM, &ctx->flags);
>> +
>> +	set_bit(XDMA_IN_PRG, &ctx->flags);
>> +
>> +	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_WRITEP,
>> +			      nidx * XDMA_CMD_SIZE);
>> +	ctx->cmd_idx = nidx;
>> +}
>> +
>> +static void aspeed_xdma_done(struct aspeed_xdma *ctx)
>> +{
>> +	if (ctx->current_client) {
>> +		clear_bit(XDMA_IN_PRG, &ctx->current_client->flags);
>> +
>> +		ctx->current_client = NULL;
>> +	}
>> +
>> +	clear_bit(XDMA_IN_PRG, &ctx->flags);
>> +	wake_up_interruptible_all(&ctx->wait);
>> +}
>> +
>> +static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
>> +{
>> +	struct aspeed_xdma *ctx = arg;
>> +	u32 status = aspeed_xdma_reg_read(ctx, XDMA_STATUS);
>> +
>> +	if (status & XDMA_STATUS_US_COMP) {
>> +		if (test_bit(XDMA_UPSTREAM, &ctx->flags))
>> +			aspeed_xdma_done(ctx);
>> +	}
>> +
>> +	if (status & XDMA_STATUS_DS_COMP) {
>> +		if (!test_bit(XDMA_UPSTREAM, &ctx->flags))
>> +			aspeed_xdma_done(ctx);
>> +	}
>> +
>> +	aspeed_xdma_reg_write(ctx, XDMA_STATUS, status);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>> +{
>> +	int rc;
>> +	u32 scu_conf = 0;
>> +	u32 mem_size = 0x20000000;
>> +	const u32 mem_sizes[4] = { 0x8000000, 0x10000000, 0x20000000,
>> +				   0x40000000 };
>> +	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
>> +	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
>> +
> Should these come from fw specification? Say device tree mem reserved nodes?


I'm not sure. I quite like finding it dynamically here rather than 
having to specify a new memory node in every system that will use the 
driver. In addition it's a little bit awkward to get the physical 
address from the reserved memory subsystem; we don't actually need to 
grab the reserved memory for this device, it's already reserved by the 
CPU/VGA. What do you think?


Thanks for the review!

Eddie


>
>> +	aspeed_scu_pcie_write(ctx, aspeed_xdma_vga_pcie_conf);
>> +
>> +	regmap_read(ctx->scu, SCU_STRAP, &scu_conf);
>> +	ctx->vga_size = vga_sizes[FIELD_GET(SCU_STRAP_VGA_MEM, scu_conf)];
>> +
>> +	if (sdmc_base) {
>> +		u32 sdmc = readl(sdmc_base + SDMC_CONF);
>> +		u32 remap = readl(sdmc_base + SDMC_REMAP);
>> +
>> +		remap |= SDMC_REMAP_MAGIC;
>> +		writel(remap, sdmc_base + SDMC_REMAP);
>> +		remap = readl(sdmc_base + SDMC_REMAP);
>> +
>> +		mem_size = mem_sizes[sdmc & SDMC_CONF_MEM];
>> +		iounmap(sdmc_base);
>> +	}
>> +
>> +	ctx->vga_phys = (mem_size - ctx->vga_size) + 0x80000000;
>> +
>> +	ctx->cmdq = devm_kzalloc(ctx->dev, XDMA_CMDQ_SIZE, GFP_KERNEL);
>> +	if (!ctx->cmdq) {
>> +		dev_err(ctx->dev, "Failed to allocate command queue.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	rc = dma_set_mask_and_coherent(ctx->dev, DMA_BIT_MASK(32));
>> +	if (rc) {
>> +		dev_err(ctx->dev, "Failed to set DMA mask: %d.\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = dma_declare_coherent_memory(ctx->dev, ctx->vga_phys,
>> +					 ctx->vga_phys, ctx->vga_size);
>> +	if (rc) {
>> +		dev_err(ctx->dev, "Failed to declare coherent memory: %d.\n",
>> +			rc);
>> +		return rc;
>> +	}
>> +
>> +	ctx->vga_virt = dma_alloc_coherent(ctx->dev, ctx->vga_size,
>> +					   &ctx->vga_dma, GFP_KERNEL);
>> +	if (!ctx->vga_virt) {
>> +		dev_err(ctx->dev, "Failed to allocate DMA.\n");
>> +		rc = -ENOMEM;
>> +		goto err_dma;
>> +	}
>> +
>> +	rc = gen_pool_add_virt(ctx->vga_pool, (unsigned long)ctx->vga_virt,
>> +			       ctx->vga_phys, ctx->vga_size, -1);
>> +	if (rc) {
>> +		dev_err(ctx->dev, "Failed to add memory to genalloc pool.\n");
>> +		goto err_genalloc;
>> +	}
>> +
>> +	ctx->cmdq_vga_virt = gen_pool_dma_alloc(ctx->vga_pool, XDMA_CMDQ_SIZE,
>> +						&ctx->cmdq_vga_phys);
>> +	if (!ctx->cmdq_vga_virt) {
>> +		dev_err(ctx->dev, "Failed to genalloc cmdq.\n");
>> +		rc = -ENOMEM;
>> +		goto err_genalloc;
>> +	}
>> +
>> +	dev_dbg(ctx->dev, "VGA mapped at phys[%08x], size[%08x].\n",
>> +		ctx->vga_phys, ctx->vga_size);
>> +
>> +	return 0;
>> +
>> +err_dma:
>> +	dma_release_declared_memory(ctx->dev);
>> +
>> +err_genalloc:
>> +	dma_free_coherent(ctx->dev, ctx->vga_size, ctx->vga_virt,
>> +			  ctx->vga_dma);
>> +	return rc;
>> +}
>> +
>> +static int aspeed_xdma_probe(struct platform_device *pdev)
>> +{
>> +	int irq;
>> +	int rc;
>> +	struct resource *res;
>> +	struct device *dev = &pdev->dev;
>> +	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	ctx->dev = dev;
>> +	platform_set_drvdata(pdev, ctx);
>> +	init_waitqueue_head(&ctx->wait);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	ctx->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(ctx->base)) {
>> +		dev_err(dev, "Unable to ioremap registers.\n");
>> +		return PTR_ERR(ctx->base);
>> +	}
>> +
>> +	irq = irq_of_parse_and_map(dev->of_node, 0);
>> +	if (!irq) {
>> +		dev_err(dev, "Unable to find IRQ.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = devm_request_irq(dev, irq, aspeed_xdma_irq, IRQF_SHARED,
>> +			      DEVICE_NAME, ctx);
>> +	if (rc < 0) {
>> +		dev_err(dev, "Unable to request IRQ %d.\n", irq);
>> +		return rc;
>> +	}
>> +
>> +	ctx->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");
>> +	if (IS_ERR(ctx->scu)) {
>> +		dev_err(ctx->dev, "Unable to grab SCU regs.\n");
>> +		return PTR_ERR(ctx->scu);
>> +	}
>> +
>> +	ctx->reset = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(ctx->reset)) {
>> +		dev_err(dev, "Unable to request reset control.\n");
>> +		return PTR_ERR(ctx->reset);
>> +	}
>> +
>> +	ctx->vga_pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
>> +	if (!ctx->vga_pool) {
>> +		dev_err(dev, "Unable to setup genalloc pool.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	reset_control_deassert(ctx->reset);
>> +
>> +	msleep(10);
> Why 10ms again? :-)
>
>> +
>> +	rc = aspeed_xdma_init_mem(ctx);
>> +	if (rc) {
>> +		reset_control_assert(ctx->reset);
>> +		return rc;
>> +	}
>> +
>> +	aspeed_xdma_init_eng(ctx);
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
>> +	dma_free_coherent(ctx->dev, ctx->vga_size, ctx->vga_virt,
>> +			  ctx->vga_dma);
>> +	dma_release_declared_memory(ctx->dev);
>> +	reset_control_assert(ctx->reset);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id aspeed_xdma_match[] = {
>> +	{ .compatible = "aspeed,ast2500-xdma" },
>> +	{ },
>> +};
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
>> index 0000000..998459e
>> --- /dev/null
>> +++ b/include/uapi/linux/aspeed-xdma.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright IBM Corp 2019 */
>> +
>> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
>> +#define _UAPI_LINUX_ASPEED_XDMA_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * aspeed_xdma_op
>> + *
>> + * host_addr: the DMA address on the host side, typically configured by PCI
>> + *            subsystem
>> + *
>> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
>> + *
>> + * upstream: boolean indicating the direction of the DMA operation; upstream
>> + *           means a transfer from the BMC to the host
>> + */
>> +struct aspeed_xdma_op {
>> +	__u64 host_addr;
>> +	__u32 len;
>> +	__u32 upstream;
>> +};
>> +
>> +#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
>> -- 
>> 1.8.3.1
>>

