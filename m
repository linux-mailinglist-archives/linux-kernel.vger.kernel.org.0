Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36616A3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 11:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBXKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 05:34:49 -0500
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com ([40.107.237.56]:6165
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgBXKet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:34:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDXAj1ayl1yVdzgxKcHeumVdXA7aIwAo2W6so+MJ1nOcQ2/M6EfqAheTF/Utpa+mkhbB0KOzdsRwoo/dj0cJCbIGP+5PVttWx0D0m8hrfcqGW10LvOhQrpeJEuGFggwKMm5AI7ZFje7NQiz0/g/4XMxKYdfYtZ7gnBAyFjykc8/4MzErhWdg/yPtohdASJcWmxnQHEbBDweCva415irZHWPjHyURT0YbNYYzh4NsZsZoEGnHLAjFQp7fQVHdEcUXbUOuC476nJbnHwjiATGin+4bktDTeJxkGuRWVMh38PZMh4iPpSDV3YVX08g2/40Fe0+GFdRrzwMPCUbXMABY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WFU7M0A2+uNnZ2gPnPRgJp6Oy+CNHRMaTFIUg3N8lc=;
 b=kA7rfWfoNC93G8XFazyHKOhogvDwSrJ0j8zZE8nAnaKaK2KVfMUZCCxTsXkNMOicZxbd3wXHNXyg1ovEK7oxuCAXXh6VvhjqSNk9gSPs614DnuVOSO0TvppdabwJnF8mTuhVsh0+3ZjBWxwvV1ntr+BQfFYFpsPRvzR3b9bOU+hcXVA7Z5p5p0j/iEm058fXIELsY/pbEcRPWhF+5SouOGY45KJ5cFqZzy+YhTV9vwH6vU55DvlndjWX1Cp+a+YQrv0Z5rrphOPJsIP4b6M8h9dJsU5TL4E1reNCTGrdUDe7m6aoDcZgYykJKZKI0eQYv22XiyUSqHtD/atK+4zNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WFU7M0A2+uNnZ2gPnPRgJp6Oy+CNHRMaTFIUg3N8lc=;
 b=ct9p3iJ3v67pkcJ+R7gX1wjKZhjVGxEGk+xwX8wbNjdSIjkUlUVcvhjIaVMaRRC6yHdoFi3HNlNSEu5vmM59KxfSHPOrppVcM67QfW/7cJAxENr/NzIVDjjx7NZxZCiqVSAqRc1MY+vDca5jEPGKJhhQ7rYanpqBJ983VfZGOQg=
Received: from DM6PR02CA0056.namprd02.prod.outlook.com (2603:10b6:5:177::33)
 by SN6PR02MB4286.namprd02.prod.outlook.com (2603:10b6:805:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 10:34:10 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by DM6PR02CA0056.outlook.office365.com
 (2603:10b6:5:177::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 10:34:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 10:34:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j6B3x-0004Gn-3O; Mon, 24 Feb 2020 02:34:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j6B3s-0006b8-06; Mon, 24 Feb 2020 02:34:04 -0800
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j6B3k-0006VH-Ug; Mon, 24 Feb 2020 02:33:57 -0800
Subject: Re: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
 optional
To:     Rajan Vaja <RAJANV@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Edgar Iglesias <edgari@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
 <20200110115415.GC39451@bogus>
 <BYAPR02MB4055B8A5ED27C2F23A28D8D0B7350@BYAPR02MB4055.namprd02.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <577cdec9-9f51-a8d3-7422-7c7ac85891d4@xilinx.com>
Date:   Mon, 24 Feb 2020 11:33:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4055B8A5ED27C2F23A28D8D0B7350@BYAPR02MB4055.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(426003)(5660300002)(336012)(9786002)(54906003)(31686004)(107886003)(2616005)(4326008)(44832011)(6666004)(110136005)(26005)(8676002)(6636002)(356004)(81156014)(81166006)(7416002)(2906002)(478600001)(53546011)(31696002)(316002)(36756003)(8936002)(186003)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4286;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8914e31-33f3-4280-e6a6-08d7b915152e
X-MS-TrafficTypeDiagnostic: SN6PR02MB4286:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4286F0DF0EEBBDECBFE497EDC6EC0@SN6PR02MB4286.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmWow8Qc1iciA35maanmu0xbnsAyzyi3PvPJ95T23A3nyvkByrHKj8sOV+pwGgIoOyq0xCq3k83ETctnIfT9X4SmO+U0Wgl9fWbGsNTDdg254nkZMatbUy9od5KxP/UCAfSGd1sFACx103xWP8pehNhzwDReBkvAILtR7+y5nOrokE9xPXP0mTl2uuTvt3vjSPvKzx8i+A40sWaTkqBIFdTBvPTfe2qfp1Y7+touH06PutiHyt35rshKRIg4mvEmCvNIU4Yg0eWqWBjfsRjM0veGZdIPF3sriz7gZsuNguVGcoGec/XPV8TqQLaYBFVGjZ022p4k+lQwV1m47oHKCOV/A0gVuWMRmjwgVA7FUrZGQ2+DPofgWVNjlLPpzFTjVSCOu1BXdXYhWduVa1B1P6aymElJT22uxGMAHk6LZDA7UWCQg3nYTg3DaTv474is
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 10:34:09.5770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8914e31-33f3-4280-e6a6-08d7b915152e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 20 7:46, Rajan Vaja wrote:
> Hi Sudeep,
> 
> Thanks for the reviewing patch.
> 
>> -----Original Message-----
>> From: Sudeep Holla <sudeep.holla@arm.com>
>> Sent: 10 January 2020 05:24 PM
>> To: Jolly Shah <JOLLYS@xilinx.com>
>> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; gregkh@linuxfoundation.org;
>> matt@codeblueprint.co.uk; hkallweit1@gmail.com; keescook@chromium.org;
>> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
>> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; Sudeep Holla <sudeep.holla@arm.com>; Tejas Patel
>> <TEJASP@xilinx.com>
>> Subject: Re: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
>> optional
>>
>> EXTERNAL EMAIL
>>
>> On Thu, Jan 09, 2020 at 11:06:02AM -0800, Jolly Shah wrote:
>>> From: Tejas Patel <tejas.patel@xilinx.com>
>>>
>>> Zynqmp firmware driver requires firmware to be present in system.
>>> Zynqmp firmware driver will crash if firmware is not present in system.
>>> For example single arch QEMU, may not have firmware, with such setup
>>> Linux booting fails.
>>>
>>> So make zynqmp_firmware driver as optional to disable it if user don't
>>> have firmware in system.
>>>
>>
>> Why can't it be detected runtime ? How do you handle single binary if you
>> make this compile time option ?
> [Rajan] There is PMU register which indicates if firmware is present or not, but in case of single arch QEMU that register will not be available so  there is no way to detect if firmware is present or not from Linux.
> Linux firmware crashes while arm_smccc_smc() call for firmware, but before this call there is no way  to identify if firmware is present or not. So we are just giving user an option if they want to use it on single arch
> Platform they can disable firmware driver.

If this is just for qemu case why not just add this register for single
instance solution.

Edgar: Can we map this register when there is no second instance to PMU MB?

Thanks,
Michal

