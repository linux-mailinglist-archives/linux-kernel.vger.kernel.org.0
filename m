Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73371124BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLRPkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 10:40:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39214 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLRPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:40:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBIFdlqg019044;
        Wed, 18 Dec 2019 09:39:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576683588;
        bh=isrbKoX0G9x5SGR0XS8wE9i8c+JE3gadbxb2pKknm08=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jqWjyfLGeRvQwwgyrIyyIvTziBUpN2dqqj6Bi1/V1jtOCGUovSziMNs1rjtKnYANl
         6tp84BGjaIAUgO4cdONFX9lAJPIOErBgldm5agnsqfH4gED+dWDnaVXO+VvYBQGFd/
         W1AAVeyJHO2FbWB09mgavO/6WOHXq+9d/kUL9aUM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBIFdldB099895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Dec 2019 09:39:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Dec 2019 09:39:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Dec 2019 09:39:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBIFdl01079424;
        Wed, 18 Dec 2019 09:39:47 -0600
Date:   Wed, 18 Dec 2019 09:39:05 -0600
From:   Bin Liu <b-liu@ti.com>
To:     <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>
Subject: Re: [PATCH v9 2/6] arm: dts: mt2701: Add usb2 device nodes
Message-ID: <20191218153905.GN16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
References: <20191211015446.11477-1-min.guo@mediatek.com>
 <20191211015446.11477-3-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191211015446.11477-3-min.guo@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Dec 11, 2019 at 09:54:42AM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> Add musb nodes and usb2 phy nodes for MT2701
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v9:
> 1. Add usb-role-switch
> 2. Remove label of usb connector child node
> 3. Change usb connector child node compatible as "gpio-usb-b-connector", "usb-b-connector";
> 
> changes in v8:
> 1. no changes
> 
> changes in v7:
> 1. Change usb connector child node compatible as "gpio-usb-b-connector" 
> 
> changes in v6:
> 1. Modify usb connector child node
> 
> changes in v5:
> 1. Add usb connector child node
> 
> changes in v4:
> 1. no changes
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> 1. Remove phy-names
> ---
>  arch/arm/boot/dts/mt2701-evb.dts | 21 ++++++++++++++++++++
>  arch/arm/boot/dts/mt2701.dtsi    | 33 ++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

Can I have your ACK so I can queue this? or please let me know if you
want to take it in your tree. Thanks.

-Bin.
