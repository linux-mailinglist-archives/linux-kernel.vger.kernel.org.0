Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D063211BC67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfLKTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 14:02:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46061 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:02:14 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so20369808iln.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwbAYQSBDv5Za0vCTAus/0vbiDud+PECBHWsA3f5N58=;
        b=m4SCZ81T05WMOj5zXCA1EeXNaycmm/je1x3e3/n+nJ5zkdeOt6Qw6Gcr+o738uc7Yp
         tlEYg26Gcr9+R0/w7V/6/8xOU0HGKbqKEcet2aXmPN/Ijth3iXw8rgpQOjzdySdroiFt
         nCKVa3XbP17RN8brOD8jKv+becFkZyUnPd4PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwbAYQSBDv5Za0vCTAus/0vbiDud+PECBHWsA3f5N58=;
        b=iJrGRpPMnhibdsIbf7dal7Q7tb0nhbx3WGYMDurq40CPJdYH6GbyxOG7HlSUXFeef0
         8RaPhPGGc1DG5cyvXdIMfiwd7eYPZkpmRQ954vsknNc2x2bP7IruSlNC3V0fTcZyFsml
         ixVvhiv+Sj7UWjCx8Z/awSwsxrD2WnDLbxSo+iRDNL378ozdDJSjbrQTe21jN5xEWTlo
         UdNRd4OniE3ryQKfoLEWB16iC0cGk1xXntOOUeLPNs19F8nmAngRYbdF8OGtVJTpV7oB
         l4uGxjP5tsEvVORpQOQO2okGck0NTqhA1RHMvl0u0dsZdMNqSFL+R+PRSc2L1DcAt/ZM
         MH8g==
X-Gm-Message-State: APjAAAWzYXl9Qnfj3CWwTdoewjmw1OEAaoq/EsXYhRqGtUCs72wnDmAv
        a0tbPF/atbajmteLYfx6XDnateMqaBw=
X-Google-Smtp-Source: APXvYqwAz5AneEoNzhKy7mS0jUw9qskCDWLqHwNnafIAKCOFotEwJYE2R4/YsEkuHIl6aecOshFXSg==
X-Received: by 2002:a92:4694:: with SMTP id d20mr4451401ilk.149.1576090933652;
        Wed, 11 Dec 2019 11:02:13 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id u10sm952429ilb.8.2019.12.11.11.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:02:11 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id s25so9123944iob.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:02:11 -0800 (PST)
X-Received: by 2002:a6b:b941:: with SMTP id j62mr2661633iof.168.1576090931323;
 Wed, 11 Dec 2019 11:02:11 -0800 (PST)
MIME-Version: 1.0
References: <1574934847-30372-1-git-send-email-rkambl@codeaurora.org> <1574934847-30372-2-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1574934847-30372-2-git-send-email-rkambl@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 11:01:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UXC3UT78vGBr9rRuRxz=8iwH4tOkFx6NC-pSs+Z5+7Xw@mail.gmail.com>
Message-ID: <CAD=FV=UXC3UT78vGBr9rRuRxz=8iwH4tOkFx6NC-pSs+Z5+7Xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sc7180: Add device node support
 for TSENS in SC7180
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        sivaa@codeaurora.org, sanm@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 28, 2019 at 1:55 AM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Add TSENS node and user thermal zone for TSENS sensors in SC7180.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 527 +++++++++++++++++++++++++++++++++++
>  1 file changed, 527 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 666e9b9..6656ffc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -911,6 +911,26 @@
>                         status = "disabled";
>                 };
>
> +               tsens0: thermal-sensor@c263000 {
> +                       compatible = "qcom,sc7180-tsens","qcom,tsens-v2";

Can you please send a patch listing this configuration in
"Documentation/devicetree/bindings/thermal/qcom-tsens.yaml"?  You
shouldn't need to re-send the dts since it looks like it's already
landed, but it's good to get the bindings happy.

Thanks!

-Doug
