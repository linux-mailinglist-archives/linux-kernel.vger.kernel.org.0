Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35095940E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF1GNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 02:13:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51668 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF1GM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:12:59 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E5D9285324;
        Fri, 28 Jun 2019 07:12:58 +0100 (BST)
Date:   Fri, 28 Jun 2019 08:12:56 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] MAINTAINERS: add Sam Ravnborg for drm/atmel_hlcdc
Message-ID: <20190628081256.230165ae@collabora.com>
In-Reply-To: <20190627211643.GA19853@ravnborg.org>
References: <20190627211643.GA19853@ravnborg.org>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 23:16:43 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> I have agreed with Boris Brezillon that we will share the
> maintainer role for the drm/atmel_hlcdc driver.
> Nicolas Ferre from Microchip has donated a few boards that
> allows me to test things - thanks!
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Boris Brezillon <bbrezillon@kernel.org>

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Peter Rosin <peda@axentia.se>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 515a81fdb7d6..0a76716874bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5251,6 +5251,7 @@ F:	Documentation/gpu/meson.rst
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  DRM DRIVERS FOR ATMEL HLCDC
> +M:	Sam Ravnborg <sam@ravnborg.org>
>  M:	Boris Brezillon <bbrezillon@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported

