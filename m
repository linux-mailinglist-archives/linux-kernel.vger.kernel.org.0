Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E714396E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAUJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:25:25 -0500
Received: from mxs2.seznam.cz ([77.75.76.125]:16145 "EHLO mxs2.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgAUJZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:24 -0500
Received: from email.seznam.cz
        by email-smtpc6a.ng.seznam.cz (email-smtpc6a.ng.seznam.cz [10.23.10.165])
        id 1147b704a41cd616114e52d7;
        Tue, 21 Jan 2020 10:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1579598722; bh=PvU0cFOvUsfloxGX8SrbXYl4hNSdH8LczMmuSRYmOzQ=;
        h=Received:Reply-To:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VTlcersm2c8UBlMiK5tTjrAuaMLmUcEKHr5i3aMOmTiWNrRy16xzU/3BVvLGZKSOG
         RSJaheeEjrls896p6N03x1U484y7Qez9B9D3VW0UrXEjJyD6rh0uR4ZuKYlF3SY7UL
         XL/H2tvcsxIC5JXKi7ekxGWb5PwVwtbDrHgwjEpc=
Received: from [77.75.76.48] (unknown-62-130.xilinx.com [149.199.62.130])
        by email-relay9.ng.seznam.cz (Seznam SMTPD 1.3.108) with ESMTP;
        Tue, 21 Jan 2020 10:11:57 +0100 (CET)  
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH V4 1/4] dt-bindings: crypto: Add bindings for ZynqMP AES
 driver
To:     Kalyani Akula <kalyani.akula@xilinx.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     git <git@xilinx.com>, Harsh Jain <harshj@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Mohan <mohand@xilinx.com>, Kalyani Akul <kalyania@xilinx.com>
References: <1574235842-7930-1-git-send-email-kalyani.akula@xilinx.com>
 <1574235842-7930-2-git-send-email-kalyani.akula@xilinx.com>
From:   Michal Simek <monstr@seznam.cz>
Message-ID: <b5696361-3b62-deb4-61d6-a9b64bb6f9c3@seznam.cz>
Date:   Tue, 21 Jan 2020 10:11:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1574235842-7930-2-git-send-email-kalyani.akula@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 11. 19 8:43, Kalyani Akula wrote:
> Add documentation to describe Xilinx ZynqMP AES driver bindings.
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
> ---
>  Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt
> new file mode 100644
> index 0000000..226bfb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.txt
> @@ -0,0 +1,12 @@
> +Xilinx ZynqMP AES hw acceleration support
> +
> +The ZynqMP PS-AES hw accelerator is used to encrypt/decrypt
> +the given user data.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-aes"
> +
> +Example:
> +	zynqmp_aes {
> +		compatible = "xlnx,zynqmp-aes";
> +	};
> 

Ok. This should be converted to yaml and it should be placed to
zynqmp_firmware node as is done for clk, pcap, nvmem, power, reset and
genpd.

Thanks,
Michal
