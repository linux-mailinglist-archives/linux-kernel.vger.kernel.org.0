Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D3E14EE88
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAaOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 09:36:10 -0500
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:55649
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728825AbgAaOgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJEUFdx4rcBJlo9IN5UoQym6Z/gc3Tro62yapN2uhinxsozeRQvD+5zcxC1MWcUkq8uEeoOqEtRHHMZjXXZeI8fqgEu9q+FNJXq8tgOcjHy7OB+9WlKb/q0vK7UFGni+leJvU2s8KCJYGZp/U9OFl4i7WHMu8/EHzmtDELPy9mOFxSBPDRiCdBNN4kqijZZuFyO95SOeOm7M2kj8Q3gR5NOGAnYiG84NHxQpMrxa00ZYkyCbweeaUKK/KOFmlVE9IWiS+SDvZo6+0q+/O4QJQIyd+JS2Dcl+pgSuBIUuFxgeGX/xlgCYxpUyIYg1IghwpKfpmETvWcRa+dw5T0FuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14MHgfb1vEhSWkbE9zVAkTW0kPj/qA9iv9fcXPLQ4rU=;
 b=oYxtkQu5XIzCvvB0HmcDmwlSWUnf/zyv/hA5GE/vaQMSGHj+PxBArW4u5nB6ENMO/+diZAZOjeEXlMcshmHk35Abv1RVwbwWnEiFmJ4veifzvypztq9mEb9XOWHaO3npYzJ2aOhP2WAmkQMFjhZXwvb4UfXSyrY/U58PAKZsaSaHfdqA0VJobGgyMcfcaqnyRpYhgIdKfPIoALugPLlF5Z9QbrNSbjQYW74rPVjPJOSwP3/Z6MrmMGlq67xMajPnJkz5+ROL/8AlSHlRnC9W1l64kE2fOqFEMFMo3T6QK0ulP60vkJZNsiyApCW8Ntx/qCPgt+HuwDyHIjZS+2hatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linutronix.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14MHgfb1vEhSWkbE9zVAkTW0kPj/qA9iv9fcXPLQ4rU=;
 b=j7n/y0mIerB7NnQwQL2USGI87IlzlSQNNKHO1tBVEcLOGGZVvimJ/3GnceA0uh24Qnyh3omcAOr4Vks97Cu3e4BU8LH9VSNm3wBL7alMw/oKQFQaOsm/yCBJw+2OFYeidJeo56ZKskIGQaiDUESG+XMxQ0tSsWEQogS8kb77gS0=
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by DM5PR02MB3242.namprd02.prod.outlook.com (2603:10b6:4:6c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 14:36:06 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 14:36:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Fri, 31 Jan 2020 14:36:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ixXOv-0005Gf-CN; Fri, 31 Jan 2020 06:36:05 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ixXOq-0001wz-1w; Fri, 31 Jan 2020 06:36:00 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00VEZxXB026624;
        Fri, 31 Jan 2020 06:35:59 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ixXOo-0001wY-JS; Fri, 31 Jan 2020 06:35:58 -0800
Subject: Re: [PATCH] irqchip: xilinx: Add support for multiple instances
To:     Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com>,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, siva.durga.paladugu@xilinx.com,
        anirudha.sarangi@xilinx.com
References: <1580480338-3361-1-git-send-email-mubin.usman.sayyed@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <28c517f7-9cff-f897-c5a9-2216dd769c64@xilinx.com>
Date:   Fri, 31 Jan 2020 15:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580480338-3361-1-git-send-email-mubin.usman.sayyed@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(478600001)(336012)(356004)(31686004)(31696002)(2906002)(70206006)(36756003)(70586007)(5660300002)(4326008)(44832011)(107886003)(426003)(81156014)(81166006)(2616005)(8936002)(8676002)(316002)(26005)(186003)(9786002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3242;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a44e596c-e818-4d13-b7ab-08d7a65ae79b
X-MS-TrafficTypeDiagnostic: DM5PR02MB3242:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3242B6F6DED6F735C7B64F11C6070@DM5PR02MB3242.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivrwIlTmDdD8a9IVaTFa14kK8x/KEkAsbuuzWio+PAVfR+DUR4Es+zFvJtlLx6t/oHbAJ9ejjB23zK8F6vJgkhrdcL2ShwvLD+CjDp7i8REsibOlnwfSR3c6e/lQnkdWKWuLTB7SWfAq9WU1bwWqFn3TAncBe1A9JfedyBxqgZLNkxofFSov6sHWcWqTWxP6cWSC9UDF7zGOe4D69gUGTVYTqRIrSAxr22oLT72wygW1t7vb611TmsFt7nRfUSi0E045mgL3A60IZecxAA/ToZR829pEbvmciV8H40VW/N86KcOnLpIt88Ha5LNwIQQPpUNiqTRLkj9ZHl5vxa59nq5qX7sbcFrDwcQmxbvnF/Zh4CdTOaMXRZcxiuZVPAeEKRdW5w4p+7zbhu0CwMNjfyWajfiSfiKsLBNdq7IIwZpgrC1CWpaGLWVyVWBevNUY
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 14:36:05.7942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44e596c-e818-4d13-b7ab-08d7a65ae79b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 01. 20 15:18, Mubin Usman Sayyed wrote:
> From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> 
> This patch adds support for multiple instances of
> xilinx interrupt controller. Below configurations are
> supported by driver,
> 
> - peripheral->xilinx-intc->xilinx-intc->gic
> - peripheral->xilinx-intc->xilinx-intc
> 
> Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> ---
>  drivers/irqchip/irq-xilinx-intc.c | 143 +++++++++++++++++++++++---------------
>  1 file changed, 87 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index e3043de..43d6e4e 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -15,10 +15,11 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/io.h>
> -#include <linux/jump_label.h>
>  #include <linux/bug.h>
>  #include <linux/of_irq.h>
>  
> +static struct xintc_irq_chip *primary_intc;

nit: please place it below xintc_irq_chip.

> +
>  /* No one else should require these constants, so define them locally here. */
>  #define ISR 0x00			/* Interrupt Status Register */
>  #define IPR 0x04			/* Interrupt Pending Register */
> @@ -32,35 +33,40 @@
>  #define MER_ME (1<<0)
>  #define MER_HIE (1<<1)
>  
> -static DEFINE_STATIC_KEY_FALSE(xintc_is_be);

I am playing with this driver a little bit now and I pretty much dislike
remove this. I haven't see any configuration which mixes little and big
endian together. That's why I prefer not to create read_fn/write_fn hooks.

Thanks,
Michal
