Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9802143975
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAUJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:27:22 -0500
Received: from mxs2.seznam.cz ([77.75.76.125]:24819 "EHLO mxs2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJ1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:27:21 -0500
Received: from email.seznam.cz
        by email-smtpc12a.ng.seznam.cz (email-smtpc12a.ng.seznam.cz [10.23.11.105])
        id 0f08187eba53796c0f01fdad;
        Tue, 21 Jan 2020 10:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1579598839; bh=GT7+gl4c0TeM5pTzk/REs4sDvk4PNXoqBw8XxuVPfb4=;
        h=Received:Reply-To:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=M199+iBKAXe/IGDdQzS4Iep+ZcsYkeJZxlWeSDakPmh/HB8GraXBRB01WeoBWTShm
         xE6LMMVQgGl9uEwAYIreizOSflHoSKqyr6WwGoJSqKSQxThpCjHAhjlGvGTzn6GErC
         TSJH8BojtlAcRB8Disw/qdXNqfCVZA4BTJ/wpoM8=
Received: from [77.75.76.48] (unknown-62-130.xilinx.com [149.199.62.130])
        by email-relay16.ng.seznam.cz (Seznam SMTPD 1.3.108) with ESMTP;
        Tue, 21 Jan 2020 10:13:16 +0100 (CET)  
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH V4 2/4] ARM64: zynqmp: Add Xilinix AES node.
To:     Kalyani Akula <kalyani.akula@xilinx.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     git <git@xilinx.com>, Harsh Jain <harshj@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Mohan <mohand@xilinx.com>, Kalyani Akul <kalyania@xilinx.com>
References: <1574235842-7930-1-git-send-email-kalyani.akula@xilinx.com>
 <1574235842-7930-3-git-send-email-kalyani.akula@xilinx.com>
From:   Michal Simek <monstr@seznam.cz>
Message-ID: <bb4c0092-8240-d5df-eebe-2ff2490dbbf1@seznam.cz>
Date:   Tue, 21 Jan 2020 10:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1574235842-7930-3-git-send-email-kalyani.akula@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 11. 19 8:44, Kalyani Akula wrote:
> This patch adds a AES DT node for Xilinx ZynqMP SoC.
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 9aa6734..9a0b7f4 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -626,4 +626,9 @@
>  			timeout-sec = <10>;
>  		};
>  	};
> +
> +	xlnx_aes: zynqmp_aes {

Should zynqmp-aes based on spec.

> +		compatible = "xlnx,zynqmp-aes";
> +	};
> +
>  };
> 

as 1/4. Incorrect location. And I would send it as the last patch in
this series.

Thanks,
Michal
