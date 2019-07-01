Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0D5C322
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGASjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 14:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726658AbfGASjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:39:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61IbarG004313
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 14:39:05 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfnn3dm5w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:39:05 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 1 Jul 2019 19:39:04 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 19:39:00 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61IcxDG20644208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 18:38:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41FBE78060;
        Mon,  1 Jul 2019 18:38:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C802C7805E;
        Mon,  1 Jul 2019 18:38:57 +0000 (GMT)
Received: from [9.85.191.166] (unknown [9.85.191.166])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 18:38:57 +0000 (GMT)
Subject: Re: [PATCH v3 5/8] drivers/soc: xdma: Add PCI device configuration
 sysfs
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, joel@jms.id.au, andrew@aj.id.au
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
 <1559153408-31190-6-git-send-email-eajames@linux.ibm.com>
 <20190531034502.GH17772@u40b0340c692b58f6553c.ant.amazon.com>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Mon, 1 Jul 2019 13:38:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531034502.GH17772@u40b0340c692b58f6553c.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19070118-8235-0000-0000-00000EB115B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011361; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226012; UDB=6.00645408; IPR=6.01007225;
 MB=3.00027540; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 18:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070118-8236-0000-0000-0000463BB197
Message-Id: <358d0c5b-1473-bb6a-810d-45230b890a55@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/19 10:45 PM, Eduardo Valentin wrote:
> On Wed, May 29, 2019 at 01:10:05PM -0500, Eddie James wrote:
>> The AST2500 has two PCI devices embedded. The XDMA engine can use either
>> device to perform DMA transfers. Users need the capability to choose
>> which device to use. This commit therefore adds two sysfs files that
>> toggle the AST2500 and XDMA engine between the two PCI devices.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/soc/aspeed/aspeed-xdma.c | 103 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 100 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
>> index 39f6545..ddd5e1e 100644
>> --- a/drivers/soc/aspeed/aspeed-xdma.c
>> +++ b/drivers/soc/aspeed/aspeed-xdma.c
>> @@ -143,6 +143,7 @@ struct aspeed_xdma {
>>   	void *cmdq_vga_virt;
>>   	struct gen_pool *vga_pool;
>>   
>> +	char pcidev[4];
>>   	struct miscdevice misc;
>>   };
>>   
>> @@ -165,6 +166,10 @@ struct aspeed_xdma_client {
>>   	SCU_PCIE_CONF_VGA_EN_IRQ | SCU_PCIE_CONF_VGA_EN_DMA |
>>   	SCU_PCIE_CONF_RSVD;
>>   
>> +static char *_pcidev = "vga";
>> +module_param_named(pcidev, _pcidev, charp, 0600);
>> +MODULE_PARM_DESC(pcidev, "Default PCI device used by XDMA engine for DMA ops");
>> +
>>   static void aspeed_scu_pcie_write(struct aspeed_xdma *ctx, u32 conf)
>>   {
>>   	u32 v = 0;
>> @@ -512,7 +517,7 @@ static int aspeed_xdma_release(struct inode *inode, struct file *file)
>>   	.release		= aspeed_xdma_release,
>>   };
>>   
>> -static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>> +static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
>>   {
>>   	int rc;
>>   	u32 scu_conf = 0;
>> @@ -522,7 +527,7 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>>   	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
>>   	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
>>   
>> -	aspeed_scu_pcie_write(ctx, aspeed_xdma_vga_pcie_conf);
>> +	aspeed_scu_pcie_write(ctx, conf);
>>   
>>   	regmap_read(ctx->scu, SCU_STRAP, &scu_conf);
>>   	ctx->vga_size = vga_sizes[FIELD_GET(SCU_STRAP_VGA_MEM, scu_conf)];
>> @@ -598,10 +603,91 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>>   	return rc;
>>   }
>>   
>> +static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 conf)
>> +{
>> +	int rc;
>> +
>> +	mutex_lock(&ctx->start_lock);
>> +	rc = wait_event_interruptible_timeout(ctx->wait,
>> +					      !test_bit(XDMA_IN_PRG,
>> +							&ctx->flags),
>> +					      msecs_to_jiffies(1000));
>> +	if (rc < 0) {
>> +		mutex_unlock(&ctx->start_lock);
>> +		return -EINTR;
>> +	}
>> +
>> +	/* previous op didn't complete, wake up waiters anyway */
>> +	if (!rc)
>> +		wake_up_interruptible_all(&ctx->wait);
>> +
>> +	reset_control_assert(ctx->reset);
>> +	msleep(10);
>> +
>> +	aspeed_scu_pcie_write(ctx, conf);
>> +	msleep(10);
>> +
>> +	reset_control_deassert(ctx->reset);
>> +	msleep(10);
>> +
>> +	aspeed_xdma_init_eng(ctx);
>> +
>> +	mutex_unlock(&ctx->start_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_xdma_pcidev_to_conf(struct aspeed_xdma *ctx,
>> +				      const char *pcidev, u32 *conf)
>> +{
>> +	if (!strcasecmp(pcidev, "vga")) {
>> +		*conf = aspeed_xdma_vga_pcie_conf;
>> +		return 0;
>> +	}
>> +
>> +	if (!strcasecmp(pcidev, "bmc")) {
>> +		*conf = aspeed_xdma_bmc_pcie_conf;
>> +		return 0;
>> +	}
> strncasecmp()?


Yes, will change, and below.


>
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t aspeed_xdma_show_pcidev(struct device *dev,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
>> +
>> +	return snprintf(buf, PAGE_SIZE - 1, "%s", ctx->pcidev);
>> +}
>> +
>> +static ssize_t aspeed_xdma_store_pcidev(struct device *dev,
>> +					struct device_attribute *attr,
>> +					const char *buf, size_t count)
>> +{
>> +	u32 conf;
>> +	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
>> +	int rc = aspeed_xdma_pcidev_to_conf(ctx, buf, &conf);
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = aspeed_xdma_change_pcie_conf(ctx, conf);
>> +	if (rc)
>> +		return rc;
>> +
>> +	strcpy(ctx->pcidev, buf);
> should we use strncpy() instead?
>
>> +	return count;
>> +}
>> +static DEVICE_ATTR(pcidev, 0644, aspeed_xdma_show_pcidev,
>> +		   aspeed_xdma_store_pcidev);
>> +
>>   static int aspeed_xdma_probe(struct platform_device *pdev)
>>   {
>>   	int irq;
>>   	int rc;
>> +	u32 conf;
>>   	struct resource *res;
>>   	struct device *dev = &pdev->dev;
>>   	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> @@ -657,7 +743,14 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>>   
>>   	msleep(10);
>>   
>> -	rc = aspeed_xdma_init_mem(ctx);
>> +	if (aspeed_xdma_pcidev_to_conf(ctx, _pcidev, &conf)) {
>> +		conf = aspeed_xdma_vga_pcie_conf;
>> +		strcpy(ctx->pcidev, "vga");
>> +	} else {
>> +		strcpy(ctx->pcidev, _pcidev);
>> +	}
> same...
>
>> +
>> +	rc = aspeed_xdma_init_mem(ctx, conf);
>>   	if (rc) {
>>   		reset_control_assert(ctx->reset);
>>   		return rc;
>> @@ -682,6 +775,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>>   		return rc;
>>   	}
>>   
>> +	device_create_file(dev, &dev_attr_pcidev);
> Should we consider using one of the default attributes here instead of device_create_file()?
> http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/


Doesn't seem to be any way to create attributes per device with that 
method. Setting the device->groups in probe() doesn't do it.


>
> BTW, was this ABI documented? Is this the same file documented in patch 2?


Patch 4, but yes.


>
>> +
>>   	return 0;
>>   }
>>   
>> @@ -689,6 +784,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
>>   {
>>   	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
>>   
>> +	device_remove_file(ctx->dev, &dev_attr_pcidev);
>> +
>>   	misc_deregister(&ctx->misc);
>>   	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
>>   		      XDMA_CMDQ_SIZE);
>> -- 
>> 1.8.3.1
>>

