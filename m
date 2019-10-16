Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346A8D8EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbfJPK4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 06:56:51 -0400
Received: from mail-eopbgr740041.outbound.protection.outlook.com ([40.107.74.41]:38112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfJPK4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwWXQAcfD2/YoGE/wAbAFa8+UvYPR+3E/zXjVXhuXe4zo+iJR7e13TCihwEnSuJXbFBisFIzlTgF3QlW0Qaj01Sh4PP5sC/JI8i9+vEn7V8Hr2vZ/O8V6mVLoZEHvHz4veh+Tr1i2lTzp7bqESdbLjP0UY7K7/fUuJnkuTh6l9KFxrWpdpRsoNHg2YLKyQ5uxEoHxPEBYFtijj5tJPpBMkHq2rL2aHMGaPsC/gi96AoJKlSB4Qh4ifuDU1Ij6HCWR4Ip1iQPdJsUmo7Z6GiM4OnPBdbw9PFRCd4ojjx4rya/LvhucRVUDX0Nu/kw9wPZSG2ar1DQ8k8I23OWWc4hZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++B+ydka1g41fIu7Ox/Ms6mOQ5TA5T48D86VqWS/dOA=;
 b=m9gjC6dl150aW+33AqgMSaW/bI7XzUcRcu6dVXI+X7NF1SMoJ+LeM+TMTW7UE7rNGoNB8d7x1fkBU6JW9XQKvgxsTkoIX6Xw+uTxIfU48Aj6t7C6gOp8Zy9SFMfAePloI5vsu12NznMLAmelWKVOqLeaF48AJ9W1dLruZOzdzi9gW4q9+FE2y39k8kMNawhGwplLj8kK24jVVxFbHwu2sJKDke5IBDY8cY+L4KHrLW4Te0VVs6HEtEUMKPyllbOgEhF5pzPNvE/MW2nR09Xi8rgqJvWa3eXPYhn8z/NPrJOCFXZTyaD4GJ+XfRfoiTW+/OaXfQ5OoTSEeTs6Jtft6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++B+ydka1g41fIu7Ox/Ms6mOQ5TA5T48D86VqWS/dOA=;
 b=qAfErY00l/+l12nBM1ZreTv2w4mn0lEE4uhcpCrBCK6BcsR/WbE9VTIeaerKJMEBpwhP9EfcHsknBjZ9gGkBg7esvn//3M0qzxplkt9t+XaB9L9pnd2e/g/H/O6w73Ww+z6HTXBiT7BEorhe4WMWUtli6sORlGp2LJYXhSjH93o=
Received: from MWHPR0201CA0102.namprd02.prod.outlook.com
 (2603:10b6:301:75::43) by BL0PR02MB4803.namprd02.prod.outlook.com
 (2603:10b6:208:5d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Wed, 16 Oct
 2019 10:56:48 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0102.outlook.office365.com
 (2603:10b6:301:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 10:56:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Wed, 16 Oct 2019 10:56:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iKgz0-0006CF-NR; Wed, 16 Oct 2019 03:56:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iKgyv-0002aI-K4; Wed, 16 Oct 2019 03:56:41 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9GAuUEf027448;
        Wed, 16 Oct 2019 03:56:30 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iKgyk-0002Ya-Ho; Wed, 16 Oct 2019 03:56:30 -0700
Subject: Re: [PATCH v2 0/2] drivers: firmware: xilinx: Add support for versal
 soc
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1570474343-21524-1-git-send-email-jolly.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7d1939c2-ad64-87d0-3ad7-b7de2400065d@xilinx.com>
Date:   Wed, 16 Oct 2019 12:56:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570474343-21524-1-git-send-email-jolly.shah@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(65956001)(70206006)(70586007)(4326008)(230700001)(6246003)(65806001)(2486003)(23676004)(7416002)(47776003)(36386004)(76176011)(50466002)(478600001)(426003)(305945005)(126002)(476003)(106002)(11346002)(2616005)(446003)(9786002)(316002)(31686004)(31696002)(486006)(44832011)(336012)(8676002)(58126008)(26005)(8936002)(186003)(5660300002)(36756003)(81156014)(4744005)(2906002)(229853002)(6666004)(356004)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4803;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf4ebe50-c1fc-45a2-db1a-08d752278a3b
X-MS-TrafficTypeDiagnostic: BL0PR02MB4803:
X-Microsoft-Antispam-PRVS: <BL0PR02MB480344F7A5A67F09E7A046DCC6920@BL0PR02MB4803.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0192E812EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaJw5ZJd9eUkskWw45tmr/jNw8/1GFTtg95vzO/FfWUyf4cm7NfBF7YxACUHBqsxx0cohgaqlPuGyug/cRK/T13aZELEVEHMGH8RElSh/T06dRAzr62Rz7UwZ+PKO9BBdHI/3RSeKQbhMfWXZYPLk/z5GR28XkrMtunMp7g/oUsN1IH76f+tG0Fa1L0Wti+AIhPwZX1Qk3m21djXafZGZpinl3An5AOJMkjqTkmxp1q2yD51ONxgYvwk3xHucK9QkbLbXGLMbPAKU+diPvOsZjsxA7WkO5I1PYEDx/Ob6TgaA74AnLuZtlV5TbqAIEHtmduwU//MJU4Dd26b5OwWawADDXsky6LeOQx8OjhryFCKOJ64kRx0QN/a2dCLinp1/GmjYkYj03blOfhz5Dh6kv5o+v7wXtzz/vBJlgszVg4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:56:47.1464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4ebe50-c1fc-45a2-db1a-08d752278a3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 10. 19 20:52, Jolly Shah wrote:
> Versal is xilinx's next generation soc. This patch adds
> driver support required to be compatible with versal device
> 
> v2:
>   No changes. Resending to include DT maintaners
> 
> Jolly Shah (2):
>   dt-bindings: firmware: Add bindings for Versal firmware
>   drivers: firmware: xilinx: Add support for versal soc
> 
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 +++++++++++++++-
>  drivers/firmware/xilinx/zynqmp.c                         |  8 ++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 

Applied both.
I just removed drivers from subject of 2/2.

Thanks,
Michal
