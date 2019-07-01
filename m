Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72429C13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbfEXQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 12:22:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56227 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389079AbfEXQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:22:02 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hUCxE-0007MK-Gl; Fri, 24 May 2019 18:22:00 +0200
Message-ID: <1558714920.2987.2.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: imx7: Fix the spelling of 'indices'
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 24 May 2019 18:22:00 +0200
In-Reply-To: <20190524110625.17407-1-festevam@gmail.com>
References: <20190524110625.17407-1-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Fri, 2019-05-24 at 08:06 -0300, Fabio Estevam wrote:
> The correct spelling is 'indices', so fix it accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> index 2ecf33815d18..13e095182db4 100644
> --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> @@ -45,6 +45,6 @@ Example:
>          };
>  
>  
> -For list of all valid reset indicies see
> +For list of all valid reset indices see
>  <dt-bindings/reset/imx7-reset.h> for i.MX7 and
>  <dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ

Thank you, applied to reset/next.

regards
Philipp
