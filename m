Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7955AFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF3LJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 07:09:18 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46684 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3LJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 07:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561892954; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VKx1wk+WzUoklxrAuKWgU2OQk4oJuRQqz3GgyjEXAY=;
        b=CrXPn/sYqzf1H1ODHym18aKQJeF/xMPQZ28pa7eIooieBYCSB2sBik0mJSykhwEDFTzdhj
        PxBiKXVGVIigKUq9U1EYzNU1bChseQe9AinV+wvnsgxd2sxIUTZnyjHKDBCJyPRhOR0P2T
        8Ixi7Ch5feBvSoUR/QTLgF8PJ210aq8=
Date:   Sun, 30 Jun 2019 13:09:09 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] DRM: ingenic: Use devm_platform_ioremap_resource
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-Id: <1561892949.1773.0@crapouillou.net>
In-Reply-To: <20190630081833.GC5081@ravnborg.org>
References: <20190627182114.27299-1-paul@crapouillou.net>
        <20190630081833.GC5081@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 30 juin 2019 =E0 10:18, Sam Ravnborg <sam@ravnborg.org> a =E9crit=20
:
> Hi Paul.
>=20
> On Thu, Jun 27, 2019 at 08:21:12PM +0200, Paul Cercueil wrote:
>>  Simplify a bit the probe function by using the newly introduced
>>  devm_platform_ioremap_resource(), instead of having to call
>>  platform_get_resource() followed by devm_ioremap_resource().
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  index a069579ca749..02c4788ef1c7 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
>>  @@ -580,7 +580,6 @@ static int ingenic_drm_probe(struct=20
>> platform_device *pdev)
>>   	struct drm_bridge *bridge;
>>   	struct drm_panel *panel;
>>   	struct drm_device *drm;
>>  -	struct resource *mem;
>>   	void __iomem *base;
>>   	long parent_rate;
>>   	int ret, irq;
>>  @@ -614,8 +613,7 @@ static int ingenic_drm_probe(struct=20
>> platform_device *pdev)
>>   	drm->mode_config.max_height =3D 600;
>>   	drm->mode_config.funcs =3D &ingenic_drm_mode_config_funcs;
>>=20
>>  -	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  -	base =3D devm_ioremap_resource(dev, mem);
>>  +	base =3D devm_platform_ioremap_resource(pdev, 0);
>>   	if (IS_ERR(base)) {
>>   		dev_err(dev, "Failed to get memory resource");
> Consider to include the error code in the error message here.

I don't think it's needed; a non-zero error code in the probe function=20
will
have the drivers core automatically print a message with the name of the
failing driver and the return code.


>>   		return PTR_ERR(base);
>=20
> With the above fixed/considered:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

=

