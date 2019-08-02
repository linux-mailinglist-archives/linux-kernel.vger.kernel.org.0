Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBA7EC16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 07:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfHBFYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 01:24:09 -0400
Received: from mail-eopbgr730075.outbound.protection.outlook.com ([40.107.73.75]:44956
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbfHBFYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:24:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9yM/LOr8l5Ff6/aWWC69otqE/YszYxhkz4srd+1g/wmN4ZONymrzJzdEb55dHfD0Kl01y5q/gscfmgFeRGEB4OcF10YnGn5JfUt32dMp00T3KRskD2PAN2EjKWu8VXotTplPWqe51JgI6HfVVcL+kP0D9EJP3F8uooCuQfO5g8q9AH9AqBwouqvhJ6iyxvsg2QhsU4dFbhEnwraU3yeUaQ9q14LHMQ7l1SiT+mtpEI8inekKjOTbvHUssSpxtCee7/t2DMxHpWag45uZhGxqYX/CVbZWLxB60YjD9uMoZL9x5HxfRIj4Kzv0VrhW00hXfCwUYp6bMWGhZYS7n/2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bcvNvZjt/wRqRd0sFSG4AuQYftabFJDdpZ7Ni5xyuk=;
 b=X2jdPFKAvtviAzzBG0/e79y2ycF6gD7Up1ddFRkXXM30SJXTMb6UOvAzWY59uTYi5xxzrWvwGmvMG/eKITFiVsUunz3x3mrkMSRJPL+EVCleEhkC0iOXyPUpOlU5ICM9i+qbXUhDrBZ5QGH+TQLz3MJVhzyifRATLPZPeYfJtLi6SLwPh3oUWa407vjZ1AyKAvncuxdGlZO9VBERYJrPtJHR8difBjZVDw2BDMXgo3YafENnI3ghdlIDwQYMWhVc/SdOJHEspkZh6BsQmzFwsBsY7GORjnBJxPnwAnaK5Bgc2sCIZY5eEBi8xIvpAM/cfhgvKjtoik7wDNw2VzTkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bcvNvZjt/wRqRd0sFSG4AuQYftabFJDdpZ7Ni5xyuk=;
 b=jtm0AJnlreNMTh4mDiF7J3DJ6rAaAlx7ttgO7s6z/+H+tsCr2dp3Sy3zLiOQbbmGQanat19BWt8dAAQdGRXANLPrFv0p+sbq78gEurvf+CKiOrhyMLvFyVCFNGyySpStfei4iI6+Ot9ym9fWutbbH2iTKImWJxLC5TW1/7aWthQ=
Received: from MWHPR0201CA0028.namprd02.prod.outlook.com
 (2603:10b6:301:74::41) by DM5PR02MB3783.namprd02.prod.outlook.com
 (2603:10b6:4:b0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.16; Fri, 2 Aug
 2019 05:24:06 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0028.outlook.office365.com
 (2603:10b6:301:74::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.14 via Frontend
 Transport; Fri, 2 Aug 2019 05:24:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Fri, 2 Aug 2019 05:24:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1htQ2v-0001Ye-2q; Thu, 01 Aug 2019 22:24:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1htQ2p-0002Q0-VC; Thu, 01 Aug 2019 22:24:00 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1htQ2l-0002PL-JF; Thu, 01 Aug 2019 22:23:55 -0700
Subject: Re: [PATCH v2] arm64: zynqmp: Add ZynqMP SDHCI compatible string
To:     Manish Narani <manish.narani@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, rrichter@cavium.com,
        gregory.clement@bootlin.com, amit.kucheria@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1561959452-22915-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <51225f83-ea4e-74d7-840f-35a44659d0e2@xilinx.com>
Date:   Fri, 2 Aug 2019 07:23:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1561959452-22915-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(189003)(199004)(5660300002)(186003)(36756003)(26005)(8676002)(64126003)(63266004)(8936002)(81166006)(476003)(50466002)(2906002)(336012)(81156014)(52146003)(23676004)(4744005)(2486003)(31686004)(316002)(446003)(356004)(305945005)(426003)(106002)(31696002)(230700001)(6666004)(76176011)(70206006)(229853002)(478600001)(65826007)(58126008)(36386004)(486006)(9786002)(4326008)(65956001)(65806001)(70586007)(966005)(126002)(47776003)(44832011)(6306002)(2616005)(11346002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3783;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28cd2897-e54a-4972-880a-08d71709a355
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR02MB3783;
X-MS-TrafficTypeDiagnostic: DM5PR02MB3783:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR02MB37836C94B47C1B6FFD7F1415C6D90@DM5PR02MB3783.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6rtn4DV6Cpwk63CoH+UtbtXir30aS7y/OLEdocVtnvlQKIgLlrLyxDDBOuq9xsg+4UaQWzQ0e3mDx6vUR8NNBGgdi5nUr52scf/HgBqAouLDnjwNJXxJatmxQvwoaSU5sDCmK8f64wo9AVi3lm/nQffo+jrMdpAlEGv7t+o3//X0vn/pZFlD+NXqLxFpWnl+DA34ZL+ayXMtZvv9FqB8uy+yXLN+diqDOEWdvmtwNK3WBK2b8umv1zKTWBh/alURPr1bAXXvskotIgt6oSdCNCv46JFu6pH2l1nCZC6ccJuCV29jzcesLyeLOx/3zCaQqcCi5UvN0b+IP3pCQ4Zz49A+btaht8qO1itnrWVvGr5VXigs1oGs3PMs8S4qIsrnDka9XQ4NRUw+j+WpJt2jPubzrLuDAwigLoy3CLlex0U=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 05:24:05.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cd2897-e54a-4972-880a-08d71709a355
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 07. 19 7:37, Manish Narani wrote:
> Add the new compatible string for ZynqMP SD Host Controller for its use
> in the Arasan SDHCI driver for some of the ZynqMP specific operations.
> Add required properties for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
> This patch depends on the below series of patches:
> https://lkml.org/lkml/2019/7/1/25
> 
> Changes in v2:
> 	- Added clock-names for SD card clocks for getting clocks in the driver

Just for a record. I am waiting till binding is Acked.

M
