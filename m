Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0B10359A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 08:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKTHvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 02:51:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38374 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfKTHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:51:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 4C0C72813B8
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-rockchip@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v3 3/4] drm: imx: Add i.MX 6 MIPI DSI host driver
In-Reply-To: <CAOMZO5C5gpW6KF9d-79wd=-7ZGAbXQLAXw3kLi+_5DBW_DYrTw@mail.gmail.com>
References: <20191118152518.3374263-1-adrian.ratiu@collabora.com>
 <20191118152518.3374263-4-adrian.ratiu@collabora.com>
 <CAOMZO5C5gpW6KF9d-79wd=-7ZGAbXQLAXw3kLi+_5DBW_DYrTw@mail.gmail.com>
Date:   Wed, 20 Nov 2019 09:51:56 +0200
Message-ID: <87o8x7dlyb.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Adrian, 

Hi Fabio,

> 
> On Mon, Nov 18, 2019 at 12:25 PM Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
> 
> Some nitpicks: 
> 
>> + +config DRM_IMX_MIPI_DSI +       tristate "Freescale i.MX DRM 
>> MIPI DSI" 
> 
> This text seems too generic as there are i.MX SoCs that use 
> different MIPI DSI IP. 
> 
> Maybe "Freescale i.MX6 DRM MIPI DSI" instead? 

Yes, this is a good idea, will update in a newer version to make 
it more specific. I'll let this version sit a little more on 
review so others also have time to review.

Thank you!

> 
>> +module_platform_driver(imx_mipi_dsi_driver); + 
>> +MODULE_DESCRIPTION("i.MX MIPI DSI host controller driver"); 
> 
> i.MX6 MIPI DSI, please.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
