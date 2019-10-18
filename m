Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14951DC768
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410481AbfJROcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 10:32:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41756 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410471AbfJROcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:32:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so2932563plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=S0AYDcjrJsy+oBnQC4y0TZHY+QVM0zdCxFU4HdWdpYs=;
        b=FqWqAl185EdhvFZoMXJBoeliiGjHn6Nm+ykS8unq4pSsETB92rPiVQ4GrFPVdBctdP
         kszpm7fCmksTRC6OkMz0kHnCQWQwgGU0r5fcMWDifNovNClV28cDIAvcsZG4KJ+sQFrf
         05e7NSlM/fK43ijItKnSk2GJCNf4iLmnVVHno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=S0AYDcjrJsy+oBnQC4y0TZHY+QVM0zdCxFU4HdWdpYs=;
        b=bFKuLKbf43TPzmCYxNW3lfe72uhwg1njrUB4J6buK6cIkoh8U2scK/3+5gCnPb+WVZ
         CP+w8lE1v1keTq5p6tBfUKZ5QTdq6OEz7c82Ce3ptlqiMBku/iFB+IFpQHGDcW1ktxft
         bLxiQaiaEQg1CoIMAwIzMqMa8NXD0KNS9IanbLYFmrhnNporhN/yfst0QRuBBZlA7lVx
         IfBMWZobY1W/by9oI1H+DILeG14jlblb1U8+zLCmm7f/uaxz5ppK9+PIj3lp0+guBdl5
         32g98VHg/OyxRAz6uSQ7d66uV1Il3bW84ZZkuXPnXgE3kAYKo2TMHJaqhVSAXd5cAUjZ
         6p7w==
X-Gm-Message-State: APjAAAXFKxGEF2ErxqW8E1Q3HN/LgivLhPRvIqBY6IzGEfLvvBEDMXYU
        M3s617utSHR+WWiguwhW7aC2vw==
X-Google-Smtp-Source: APXvYqyBsAB4co/sMqBO/Ihqv1CyC8RUWMY5tCwyuef3uxHYeNsv4k67Aa5a7acEuX1sBePI0ltN4g==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr9883498pll.317.1571409127260;
        Fri, 18 Oct 2019 07:32:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q30sm6755037pja.18.2019.10.18.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:32:06 -0700 (PDT)
Message-ID: <5da9cce6.1c69fb81.d3cb2.07d1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <30f419d1612a3912e323287a96daa2b4fbe3dacd.1571406041.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1571406041.git.saiprakash.ranjan@codeaurora.org> <30f419d1612a3912e323287a96daa2b4fbe3dacd.1571406041.git.saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 2/2] dt-bindings: msm: Add LLCC for SC7180
User-Agent: alot/0.8.1
Date:   Fri, 18 Oct 2019 07:32:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-10-18 06:57:09)
> Add LLCC compatible for SC7180 SoC.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Can you convert this binding to YAML? Would be useful to make sure it's
used properly.

>=20
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Do=
cumentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> index eaee06b2d8f2..f263aa539d47 100644
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -11,7 +11,9 @@ Properties:
>  - compatible:
>         Usage: required
>         Value type: <string>
> -       Definition: must be "qcom,sdm845-llcc"
> +       Definition: must be one of:
> +                   "qcom,sc7180-llcc",
> +                   "qcom,sdm845-llcc"
> =20
