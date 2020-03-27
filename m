Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE0195327
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 09:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgC0IpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 04:45:02 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:15118
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgC0IpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBNkIwdB/pd67dEhtZ+P4ys+MNhLHviuorfOznTmkSOVe7G4z6M+PeYvgtY0fmx9nYHe4o30qJimSCnQBr5/Eh4ZZmV5IJR8kRb3K1fSpOCGl4ttFSpVGI6l/E8hTdm5o3qOn78+AlfAqdTZwgZCMmmnXEkjtHOEKfPdZCVg/jeat+1Dl8qHbvoxv2iZQ5Qxw3JXgk/cjiH39oq2I+5KueetZR1BKeQBcBYUwTCUt4mK6TczmmCUDZLOqBP+9hyeHdaowq6bvNDjH2Y7fGgM5B2hPf745XXA/biNltC64CY1UNpijW8GLBwv8swmiXZINPp7UkBdJoT8J3L2JN9okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDVDUkV9KD0TsHdraLuhyqNaEgJgCKmfD3PS3xxBYLg=;
 b=maahrf4vMFsRSfyO5AdSvemmDs9lzHvbLaIOTedtKY12KjqdIxQih975uRW6T5u8mRtGKFTKtEi+ZdoikBxNzkPHJDxSDf92IywQImm3e+U3x42Ohs/XIitkhvwvFxwJSyl+xOpDJijWd1qrZEb3eFBLCOduDlpxalEwus8CZguxe3LWl8K0cspKOoHbZyzcK02iDcu9+WwE2BFgEPGjpWDUO6UN7wq+4IjphpduDZq/d2QCz/U0jjxMRl/naXVhS+DU8xt6Sy8gzIurgSlYr8FXyW4DcMAFZLeOdGVR4HZqXGlaGRfME3C/W/IYK4HkrFHiXt2EmMkHx8Rcz6iBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=itdev.co.uk; dmarc=pass action=none header.from=itdev.co.uk;
 dkim=pass header.d=itdev.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector2-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDVDUkV9KD0TsHdraLuhyqNaEgJgCKmfD3PS3xxBYLg=;
 b=vwpo0zwy46ACzbx7Ret02Lt4NuI9SSOJ4wjDT+eCmj7lKEi3lY9NRwbgcVPCEIiZuoBH5VRLRHlmjab67MJUkcwFtFWUiybhdrCdH5W7+36JYgKLxmXCmnvo1cwi+bve7a0VDIXrSfu4qvPX85bXwKKo5H/l08YQYT0TPCo+cDw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com (20.179.44.144) by
 DBBPR08MB5221.eurprd08.prod.outlook.com (20.179.46.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 27 Mar 2020 08:44:57 +0000
Received: from DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659]) by DBBPR08MB4491.eurprd08.prod.outlook.com
 ([fe80::cce9:f055:f034:3659%4]) with mapi id 15.20.2835.025; Fri, 27 Mar 2020
 08:44:57 +0000
Date:   Fri, 27 Mar 2020 08:44:54 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6656: Use DIV_ROUND_UP macro instead of
 specific code
Message-ID: <20200327084454.GA25025@jiffies>
References: <20200326175902.14467-1-oscar.carter@gmx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326175902.14467-1-oscar.carter@gmx.com>
X-ClientProxiedBy: LO2P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::14) To DBBPR08MB4491.eurprd08.prod.outlook.com
 (2603:10a6:10:d2::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jiffies (5.151.93.48) by LO2P123CA0002.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 08:44:55 +0000
X-Originating-IP: [5.151.93.48]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed257ed1-29ae-48b9-de12-08d7d22b201e
X-MS-TrafficTypeDiagnostic: DBBPR08MB5221:
X-Microsoft-Antispam-PRVS: <DBBPR08MB5221560637C5941CD2FCB407B3CC0@DBBPR08MB5221.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4491.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39830400003)(396003)(346002)(376002)(366004)(44832011)(66556008)(6496006)(4326008)(86362001)(956004)(8936002)(52116002)(8676002)(508600001)(81156014)(81166006)(316002)(66476007)(1076003)(966005)(54906003)(53546011)(55016002)(66946007)(9576002)(186003)(26005)(5660300002)(2906002)(33716001)(6916009)(16526019)(33656002)(9686003)(518174003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWInEy6VJcmPoD5whoOzlpf+vcoVNChLv7RcVN+KdnHCdO5JCLbZMTYRR0mwg0ok1mWlg4LwvFfOWNTCfudZhhW4pngK3qUwkoBLgp+p1q4kAmR5rCL0hbNb9zWYFnXxYvXDCXEIB9YQRYXSUX5xigxGGMf70VJGyKYG31EiQFIdThyn3rJgaqV7CnhaDii1BMEgas4BecA/hBw9lzxuJG3FkgvTFANeU9GnsnKkrXU0cDVZ9DhVz7CVBKReLYF9cWaV6oLddcBPBduNJLN5qeou5i0MDIl5WTYoaXKbn//96zijAEDFDm45Dpj4pRElyWeK2yAtnBf8EVy6m3FUtOVP3DFtD1Cwffnw79MqB5mYWpOEDc5+IGIk+Erv/o3CAYTkeNKOoDvBn5X2pE++csdayWrQL1JX9OADA8Im9ue7nEOH3cIHluqWcAyigZkaXgVB1aBKqnYJCfoFvfbaDYF5nnCIMKVv1yQt5Gnx6UeeDmYfu+FsNOcHak6LpjzbkfHEXw4I6prx6PezerfJ0tR9Zx5DqHGVWG4oJwF7EaYEkluPzdtzZHIZ0tX3V+pV
X-MS-Exchange-AntiSpam-MessageData: Bqldo7jV0ulnvv9y9VCO3Y7SjqA6CnH1Cw4kg+haVWcLgs6UN/hN/c4hWOYP82siGxHmeZ50ST3D9gZCclGWj65dLNPxwh8mLJN6nE1zRkSrf1D8mC+Mu8qsXn9uHDd/u4zAuMIx8TDoFKM8d6TNLQ==
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: ed257ed1-29ae-48b9-de12-08d7d22b201e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 08:44:57.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSiUisbJgUGX+yF+F9SNa5HvgXu+4IuHY/wbkfeWzPrZ6lmMECNPa2PIeCkRE7tpVruu6bs0NhnyYQAqjX6nG3sF8rSMOnJxV9sGLslwFy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/20 18:59:02, Oscar Carter wrote:
> Use DIV_ROUND_UP macro instead of specific code with the same purpose.
> Also, remove the unused variables.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
> Changelog v1 -> v2
> - Rebase the original patch [1] against the staging-next branch of the greg's
>   staging.git tree.
> 
>   [1] https://lore.kernel.org/lkml/20200322112342.9040-1-oscar.carter@gmx.com/
> 
>  drivers/staging/vt6656/baseband.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> index 0b5729abcbcd..a19a563d8bcc 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -23,6 +23,7 @@
>   */
> 
>  #include <linux/bits.h>
> +#include <linux/kernel.h>
>  #include "mac.h"
>  #include "baseband.h"
>  #include "rf.h"
> @@ -133,7 +134,6 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
>  {
>  	unsigned int frame_time;
>  	unsigned int preamble;
> -	unsigned int tmp;
>  	unsigned int rate = 0;
> 
>  	if (tx_rate > RATE_54M)
> @@ -147,20 +147,11 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
>  		else
>  			preamble = 192;
> 
> -		frame_time = (frame_length * 80) / rate;
> -		tmp = (frame_time * rate) / 80;
> -
> -		if (frame_length != tmp)
> -			frame_time++;
> -
> +		frame_time = DIV_ROUND_UP(frame_length * 80, rate);
>  		return preamble + frame_time;
>  	}
> -	frame_time = (frame_length * 8 + 22) / rate;
> -	tmp = ((frame_time * rate) - 22) / 8;
> -
> -	if (frame_length != tmp)
> -		frame_time++;
> 
> +	frame_time = DIV_ROUND_UP(frame_length * 8 + 22, rate);
>  	frame_time = frame_time * 4;
> 
>  	if (pkt_type != PK_TYPE_11A)
> @@ -214,11 +205,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
> 
>  		break;
>  	case RATE_5M:
> -		count = (bit_count * 10) / 55;
> -		tmp = (count * 55) / 10;
> -
> -		if (tmp != bit_count)
> -			count++;
> +		count = DIV_ROUND_UP(bit_count * 10, 55);
> 
>  		if (preamble_type == 1)
>  			phy->signal = 0x0a;
> --
> 2.20.1

Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>

Thanks,
Quentin
