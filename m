Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE818F4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgCWMsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:48:50 -0400
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:6117
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728265AbgCWMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4oeyhSlV0B/z+xBLaQ8/PurlTywRGR4ijM4oaPm8iruuFQlXNo1ojkgxPWC3IUAJodxEubClLG74jZ5p9IkThf4rxsUxhkM4fERqOHwjgQNSIoJNEB4WMOuR9r8380V5YYA3oWgCrrC0QwWQOBYJzh+H/VQ3U926X2OYaQ0ZLnAllJoBa685GCJcLzG7vd0AvsPqcVWGT0WMnDqTMC2r2mn00ez8c/IyZFR0CDUnpDfCAfEiF67kHNHZg6PxM2iKcyJPjz/9w4jZLt84GufTZgMhxEFIvN8LwWWhD6SjRjl/WPIa9K1dzaHgy+93vx+5wBOyd4qo54guRX6bS7kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ESEo1P6mOjsUssu8jocwbgmI5YrdBNL9pw5mjUayc8=;
 b=oIoYpHfeZAFsTrXupDKzjePEt57QUlX6QYaHdHKn3nUGK8e3pV3nwJD/qgPj0d9kYQvIPFPiJSrxLvObBnzEHHXZ/EoRB/EQJSSLYy8gJrOLToIgqL1JZMhhoQgAx5ICNg+0oIlOMVjS6/iV8Xy9+0bQO4pKhke2qm6cgbb+olM7NqQ2cCX8XDYV6RYSqFc8Mu/HcOwpJb/bDrE57vbrxLDX68JBLjhe2WzeRt27JSo2m9jyue0h30MWMNjY1yrICAobgEfC5FHr2e+wwIx9FJ57E0vLS3Ma26eYg8BTQb5KD0eZi8uTUoLzwQwKErkKlztVSYmfixEBnHu5rhJjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ESEo1P6mOjsUssu8jocwbgmI5YrdBNL9pw5mjUayc8=;
 b=R0YZHztpexKowEDmCF6xv0JHogFTlacYj6YQ1k+q2LgPgO07rdDvHrXxZRNch2TYvJuJ8OyowyQ6kHIXZrewEazAqi3Js5QBu3QKREqwk/iMXkuL0u4XPK3WqUJoDzjencAY0Ex5SqLQ/93rV0oP5SA/p0LiIqvUyFyllilhMD8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB6536.eurprd04.prod.outlook.com (20.179.246.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 12:48:46 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:48:46 +0000
Subject: Re: [PATCH 07/10] bus/fsl-mc: Export a dprc scan function to be used
 by multiple entities
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        linux-kernel@vger.kernel.org, stuyoder@gmail.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        bharatb.yadav@gmail.com
References: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
 <20200319154051.30609-8-diana.craciun@oss.nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <493be973-9b6b-2c24-ca38-00c17721ebb8@nxp.com>
Date:   Mon, 23 Mar 2020 14:48:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200319154051.30609-8-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::37) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.213.175.155] (192.88.158.246) by BYAPR07CA0024.namprd07.prod.outlook.com (2603:10b6:a02:bc::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Mon, 23 Mar 2020 12:48:43 +0000
X-Originating-IP: [192.88.158.246]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c946201-ecf4-4a8b-b151-08d7cf2886c6
X-MS-TrafficTypeDiagnostic: AM6PR04MB6536:|AM6PR04MB6536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6536F48465309A470EA38639ECF00@AM6PR04MB6536.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(86362001)(31696002)(26005)(186003)(478600001)(53546011)(52116002)(31686004)(6486002)(36756003)(16526019)(8936002)(8676002)(81156014)(81166006)(66476007)(44832011)(2906002)(316002)(66556008)(16576012)(6666004)(2616005)(956004)(5660300002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6536;H:AM6PR04MB5925.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYw3+nAPDCKkQg+79yWVMoPjVYNpolT1SikT2LKDcXK5O9EpL3DW35CfLxBSXl1xku+V4LXmkckzNu49rdTUhRs60+SE9DWbUDReRTOrgVS/s41UJMxhfAQZaNbdw7QTxG4v9ce1MIg0Txnxos5UacqbHC8Tqs/XkhjIdZRtOSSsgr0Lm1HSupd87/TzM8dw9Y4qcojvhKgvne5sl9V+6fJLmWmTdVBL5kViNlAap5B0rBnZCrEOFIfEUTQviXq3e7JyBZQT8klD9t9PJhclyP1TTln/gx87RsNU8bQMBTHqQcCF9Tg1pfLNf3TAb4IaXA2R6dl76lfkwZUzfxq/kTKGy1c5FHHwXlAX/fGpziu4C+iJTjJ5YWTCTZY9lltj3Uy6lo7DLSfkayaIvVcUb+s4ztt9wwVcFT8E5PwoqizLi2wQpuVP+oenz+0uD1wk
X-MS-Exchange-AntiSpam-MessageData: G+micOx25ElV0VxHdytwEzxBJARrAY0zUejN+JEqw2o3l5GhRkx7WC4Gyz6sWm8NlgAqBX2O1gCB6QFaSTJ4RBzAjgmjd6sAbfSlFhVGSIm1iJQ/OfEGQ/TiPHEjbbREKnDO/tTL8SQayBr3jZghZg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c946201-ecf4-4a8b-b151-08d7cf2886c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:48:46.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGqRo3ITyI1Q0i9yv63ag2JFy4MfSPtJqw1ZdFd2o/7MPEUKC5XUtlfeIkx20oS2b44bnbInt8EliICm22LCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2020 5:40 PM, Diana Craciun wrote:
> Currently the DPRC scan function is used only by the bus driver.
> But the same functionality will be needed by the VFIO driver.
> To support this, the dprc scan function was exported and a little
> bit adjusted to fit both scenarios.
> 
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc-driver.c | 15 ++++++---------
>  drivers/bus/fsl-mc/fsl-mc-bus.c  |  2 ++
>  include/linux/fsl/mc.h           |  4 ++++
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
> index 7eaf78900dfc..789220f0372a 100644
> --- a/drivers/bus/fsl-mc/dprc-driver.c
> +++ b/drivers/bus/fsl-mc/dprc-driver.c
> @@ -335,7 +335,9 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
>   * bus driver with the actual state of the MC by adding and removing
>   * devices as appropriate.
>   */
> -static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
> +int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
> +		   const char *driver_override,
> +		   bool alloc_interrupts)
>  {
>  	int error;
>  	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
> @@ -346,15 +348,12 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
>  	 * Discover objects in the DPRC:
>  	 */
>  	mutex_lock(&mc_bus->scan_mutex);
> -	error = dprc_scan_objects(mc_bus_dev, NULL, true);
> +	error = dprc_scan_objects(mc_bus_dev, driver_override, alloc_interrupts);
>  	mutex_unlock(&mc_bus->scan_mutex);
> -	if (error < 0) {
> -		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
> -		return error;
> -	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dprc_scan_container);
>  
>  /**
>   * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
> @@ -679,12 +678,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
>  		goto error_cleanup_open;
>  	}
>  
> -	mutex_init(&mc_bus->scan_mutex);
> -

It's not obvious that this is related, maybe it should be mentioned in
the commit message.

>  	/*
>  	 * Discover MC objects in DPRC object:
>  	 */
> -	error = dprc_scan_container(mc_dev);
> +	error = dprc_scan_container(mc_dev, NULL, true);
>  	if (error < 0)
>  		goto error_cleanup_open;
>  
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index a99a0edef252..1865221bb12d 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -635,7 +635,9 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  		if (!mc_bus)
>  			return -ENOMEM;
>  
> +		mutex_init(&mc_bus->scan_mutex);
>  		mc_dev = &mc_bus->mc_dev;
> +

nit: extra white space.

---
Best Regards, Laurentiu

>  	} else {
>  		/*
>  		 * Allocate a regular fsl_mc_device object:
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index b9d5e5955adb..2bdd96a482fb 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -476,6 +476,10 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
>  			 u16 token,
>  			 int child_container_id);
>  
> +int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
> +		   const char *driver_override,
> +		   bool alloc_interrupts);
> +
>  /*
>   * Data Path Buffer Pool (DPBP) API
>   * Contains initialization APIs and runtime control APIs for DPBP
> 
