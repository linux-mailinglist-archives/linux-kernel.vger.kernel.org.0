Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5B97738
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 12:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfHUKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 06:32:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33697 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfHUKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:32:13 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i0NuP-0003ar-3l; Wed, 21 Aug 2019 12:32:05 +0200
Message-ID: <1566383523.4193.5.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-bindings: reset: aoss: Add AOSS reset binding
 for SC7180 SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Aug 2019 12:32:03 +0200
In-Reply-To: <20190821095442.24495-2-sibis@codeaurora.org>
References: <20190821095442.24495-1-sibis@codeaurora.org>
         <20190821095442.24495-2-sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
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

On Wed, 2019-08-21 at 15:24 +0530, Sibi Sankar wrote:
> Add SC7180 AOSS reset to the list of possible bindings.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> index 510c748656ec5..8f0bbdc6afd91 100644
> --- a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> @@ -8,7 +8,8 @@ Required properties:
>  - compatible:
>  	Usage: required
>  	Value type: <string>
> -	Definition: must be:
> +	Definition: must be one of:
> +		    "qcom,sc7180-aoss-cc"
>  		    "qcom,sdm845-aoss-cc"
>  
>  - reg:

Does sc7180 have exactly the same resets (mss, camss, venus, gpu,
dispss, wcss, and lpass) as sdm845? If so, it could be considered
compatible, and the driver changes wouldn't be needed at all:

-	Definition: must be:
+	Definition: must be one of:
+		    "qcom,sc7180-aoss-cc", "qcom,sdm845-aoss-cc"
 	
	    "qcom,sdm845-aoss-cc"

Is there a reason not to do this?

regards
Philipp
