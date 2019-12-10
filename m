Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0231186B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLJLmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:42:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56514 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLJLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:42:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 92096291A06
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Philippe CORNU <philippe.cornu@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Cc:     "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [Linux-stm32] [PATCH v4 0/4] Genericize DW MIPI DSI bridge and
 add i.MX 6 driver
In-Reply-To: <a356df00-e321-ab8c-61e9-f179cb1f8e12@st.com>
References: <20191202193359.703709-1-adrian.ratiu@collabora.com>
 <a356df00-e321-ab8c-61e9-f179cb1f8e12@st.com>
Date:   Tue, 10 Dec 2019 13:43:03 +0200
Message-ID: <87y2vk1k54.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Dec 2019, Philippe CORNU <philippe.cornu@st.com> wrote:
> Hi Adrian, 
> 
> And sorry for this late reply.  Your patches look good and we 
> ("stm guys") understand that v1.01 is very  different to 
> v1.30/31. 
> 
> We are doing our best to review & test your patches and we will 
> go back  to you asap.  Many thanks, Philippe :-) 

Hi Philippe,

Thank you for taking the time to test this, I really appreciate 
it.

Adrian

>
>
> On 12/2/19 8:33 PM, Adrian Ratiu wrote:
>> Having a generic Synopsis DesignWare MIPI-DSI host controller bridge
>> driver is a very good idea, however the current implementation has
>> hardcoded quite a lot of the register layouts used by the two supported
>> SoC vendors, STM and Rockchip, which use IP cores v1.30 and v1.31.
>> 
>> This makes it hard to support other SoC vendors like the FSL/NXP i.MX 6
>> which use older v1.01 cores or future versions because, based on history,
>> layout changes should also be expected in new DSI versions / SoCs.
>> 
>> This patch series converts the bridge and platform drivers to access
>> registers via generic regmap APIs and allows each platform driver to
>> configure its register layout via struct reg_fields, then adds support
>> for the host controller found on i.MX 6.
>> 
>> I only have i.MX hardware with MIPI-DSI panel and relevant documentation
>> available for testing so I'll really appreciate it if someone could test
>> the series on Rockchip and STM... eyeballing register fields could only
>> get me so far, so sorry in advance for any breakage!
>> 
>> Many thanks to Boris Brezillon <boris.brezillon@collabora.com> for
>> suggesting the regmap solution and to Liu Ying <Ying.Liu@freescale.com>
>> for doing the initial i.MX platform driver implementation.
>> 
>> This series applies on top of latest linux-next tree, next-20191202.
>> 
>> v3 -> v4:
>>    * Added commmit message to dt-binding patch (Neil)
>>    * Converted the dt-binding to yaml dt-schema format (Neil)
>>    * Small DT node + driver fixes (Rob)
>>    * Renamed platform driver to reflect it's only for i.MX v6 (Fabio)
>>    * Added small panel example to the host controller DT binding
>> 
>> v2 -> v3:
>>    * Added const declarations to dw-mipi-dsi.c structs (Emil)
>>    * Fixed Reviewed-by tags and cc'd some more relevant ML (Emil)
>> 
>> v1 -> v2:
>>    * Moved register definitions & regmap initialization into bridge
>>    module. Platform drivers get the regmap via plat_data after calling
>>    the bridge probe (Emil).
>> 
>> Adrian Ratiu (4):
>>    drm: bridge: dw_mipi_dsi: access registers via a regmap
>>    drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
>>    drm: imx: Add i.MX 6 MIPI DSI host driver
>>    dt-bindings: display: add i.MX6 MIPI DSI host controller doc
>> 
>>   .../display/imx/fsl,mipi-dsi-imx6.yaml        | 136 ++++
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 699 +++++++++++++-----
>>   drivers/gpu/drm/imx/Kconfig                   |   7 +
>>   drivers/gpu/drm/imx/Makefile                  |   1 +
>>   drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 378 ++++++++++
>>   .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  17 +-
>>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |  34 +-
>>   include/drm/bridge/dw_mipi_dsi.h              |   2 +-
>>   8 files changed, 1067 insertions(+), 207 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
>>   create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
>> 
