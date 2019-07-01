Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF92B2B704
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfE0Nwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 09:52:43 -0400
Received: from casper.infradead.org ([85.118.1.10]:49696 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfE0Nwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CxZUZvklOy8kGT0VQtbJNrmx3JMHiXG681xB01ACpdM=; b=JTGN+4aMhXvGVTU07miAtAI5jx
        bh/tv/vMKWM2GedMiCYGu6ff1mmwGxOP3jUphIULFE+oNEw2g7p85UisDxGlJ3w6U9L1dttr6zdui
        qsZja21N1AfJDxT+OoYY45tIxRKs1AQAEOt2yCJM4Z2IRo25aQkQAKxdrquhu62nQh5QJ3j/fJlon
        Blp0Cg+63HTkQ9wHYBdyIHbJ9HLOdmUGk/ppgFJTWHHrM8zaXzWGSMGpGf8oKrxHttPuYewecdUcv
        i/tdZLWA2cKm7ILrlJuQ6zclYXdk6tCaSARF5X01UqyCLA8i71EOYuVKdFxvi9CUKgSx82/zfsesu
        Z1WDoVcQ==;
Received: from [177.159.249.4] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVG3K-0000X9-NI; Mon, 27 May 2019 13:52:39 +0000
Date:   Mon, 27 May 2019 10:52:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     <lee.jones@linaro.org>, <arnd@arndb.de>,
        <natechancellor@gmail.com>, <ottosabart@seberm.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/4 RESEND] mfd: madera: Fix bad reference to
 pinctrl.txt file
Message-ID: <20190527105233.77bacd8b@coco.lan>
In-Reply-To: <20190520090628.29061-2-ckeepax@opensource.cirrus.com>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
        <20190520090628.29061-2-ckeepax@opensource.cirrus.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 20 May 2019 10:06:26 +0100
Charles Keepax <ckeepax@opensource.cirrus.com> escreveu:

> From: Otto Sabart <ottosabart@seberm.com>
> 
> The pinctrl.txt file was converted into reStructuredText and moved into
> driver-api folder. This patch updates the broken reference.
> 
> Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  include/linux/mfd/madera/pdata.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> index 8dc852402dbb1..dd00ab824e5be 100644
> --- a/include/linux/mfd/madera/pdata.h
> +++ b/include/linux/mfd/madera/pdata.h
> @@ -34,7 +34,8 @@ struct madera_codec_pdata;
>   * @micvdd:	    Substruct of pdata for the MICVDD regulator
>   * @irq_flags:	    Mode for primary IRQ (defaults to active low)
>   * @gpio_base:	    Base GPIO number
> - * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
> + * @gpio_configs:   Array of GPIO configurations (See
> + *		    Documentation/driver-api/pinctl.rst)
>   * @n_gpio_configs: Number of entries in gpio_configs
>   * @gpsw:	    General purpose switch mode setting. Depends on the external
>   *		    hardware connected to the switch. (See the SW1_MODE field



Thanks,
Mauro
