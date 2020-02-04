Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC3152064
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBDSWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 13:22:24 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45843 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBDSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:22:24 -0500
Received: by mail-ua1-f67.google.com with SMTP id 59so7096992uap.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cype+1HdLaYeGzPg6QLAFeuguxQu4poaB2OEsU3y04s=;
        b=IUlAuvrBfjzl5pITuJlx+XC7sqgnBZqUwLmF9uQn/eUBKie2QtVpwI2xPwyf+a/syV
         OXaRJG/EOJB0KrDkMikM6npajjVQ8ecz9K2nJbZhUH8PLIkih+o8CsokUdnJCJGnn+ZP
         U2WqwmKL8+8A6UKrfacQQUvqu+UoXenC43pCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cype+1HdLaYeGzPg6QLAFeuguxQu4poaB2OEsU3y04s=;
        b=S9Nbl+Tn+myzvUhjx2R0kap+Qk3MXIPHAz7ROsvl/RriMDEKJpAJ6rCqvkVkmeGUI9
         GbsN1EZ09CZUyKRWtH7Fqgi/w9o38Osdfe1N/shOLczcthdoIfnl0yK5XCmyxRz6gHpK
         1vVgKzVEgOsQyjLh/11q9wRM5StAjuyoZRLgD+eCbEU2zJnXFcA0XT99r2CJrZEf5G1g
         TOxnKbGOMwXBahJ9HTKjHPr4pgBfPi65cIXrs0bzbcL5FOBC45s1dw0fI4RGsjYCvYwO
         YZ9qHrbd+tctMFyZSvuTILoolgRwMcshyzkFMwyPvjEC/MQ5Aq+zU33ZvBLVCTVKmD1S
         hFOw==
X-Gm-Message-State: APjAAAVjoe0DaYhnsYolX9guv1/e2OO15DsQWu9dDW5eKizQRlzf3HtG
        Wa3oiftkcFR6IGcV6DzLbFuxzUSmCNk=
X-Google-Smtp-Source: APXvYqwfPJvweE/Vbzh04TBn8gShta7lL7mlkjvDSMFMYq2+GwCl8s74kunrWxr+O/sLxkyW5Wwu6A==
X-Received: by 2002:ab0:69c7:: with SMTP id u7mr17541405uaq.111.1580840542590;
        Tue, 04 Feb 2020 10:22:22 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id s186sm7454579vkb.3.2020.02.04.10.22.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 10:22:21 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id b69so5188744vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 10:22:21 -0800 (PST)
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr17919151vke.40.1580840540768;
 Tue, 04 Feb 2020 10:22:20 -0800 (PST)
MIME-Version: 1.0
References: <1580825737-27189-1-git-send-email-harigovi@codeaurora.org>
In-Reply-To: <1580825737-27189-1-git-send-email-harigovi@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 10:22:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XXyYTqVV4=e8Kz0tYQ=5TWjZi2QETNL_0BaFqKi5o0Cg@mail.gmail.com>
Message-ID: <CAD=FV=XXyYTqVV4=e8Kz0tYQ=5TWjZi2QETNL_0BaFqKi5o0Cg@mail.gmail.com>
Subject: Re: [v1] dt-bindings: msm:disp: update dsi and dpu bindings
To:     Harigovindan P <harigovi@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>, nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 6:15 AM Harigovindan P <harigovi@codeaurora.org> wrote:
>
> Updating bindings of dsi and dpu by adding and removing certain
> properties.
>
> Signed-off-by: Harigovindan P <harigovi@codeaurora.org>
> ---
>
> Changes in v1:
>         - Adding "ahb" clock as a required property.
>         - Adding "bus", "rot", "lut" as optional properties for sc7180 device.
>         - Removing properties from dsi bindings that are unused.
>         - Removing power-domain property since DSI is the child node of MDSS
>           and it will inherit supply from its parent.
>
>  Documentation/devicetree/bindings/display/msm/dpu.txt | 7 +++++++
>  Documentation/devicetree/bindings/display/msm/dsi.txt | 5 -----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu.txt b/Documentation/devicetree/bindings/display/msm/dpu.txt
> index 551ae26..dd58472a 100644
> --- a/Documentation/devicetree/bindings/display/msm/dpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dpu.txt
> @@ -19,6 +19,7 @@ Required properties:
>    The following clocks are required:
>    * "iface"
>    * "bus"
> +  * "ahb"

This is only required for sc7180?  ...or old SoCs should have had it
all along too?


>    * "core"
>  - interrupts: interrupt signal from MDSS.
>  - interrupt-controller: identifies the node as an interrupt controller.
> @@ -50,6 +51,8 @@ Required properties:
>  - clock-names: device clock names, must be in same order as clocks property.
>    The following clocks are required.
>    * "bus"
> +  For the device "qcom,sc7180-dpu":
> +  * "bus" - is an optional property due to architecture change.

This is a really odd way to write it for two reasons:
* You're breaking up the flow of the list.
* This shouldn't be listed as "optional" in sc7180 but unless there is
some reason to ever provide it on sc7180.  It should simply be
disallowed.

Maybe instead just:

   The following clocks are required.
-  * "bus"
+  * "bus" (anything other than qcom,sc7180-dpu)

We really need to get this into yaml ASAP but that'd probably be OK to
tide us over.

NOTE: when converting to yaml, ideally we'll have a separate file per
SoC to avoid crazy spaghetti, see commit 2a8aa18c1131 ("dt-bindings:
clk: qcom: Fix self-validation, split, and clean cruft") in clk-next
for an example of starting the transition to one yaml per SoC (at
least for anything majorly different).


>    * "iface"
>    * "core"
>    * "vsync"
> @@ -70,6 +73,10 @@ Optional properties:
>  - assigned-clocks: list of clock specifiers for clocks needing rate assignment
>  - assigned-clock-rates: list of clock frequencies sorted in the same order as
>    the assigned-clocks property.
> +- For the device "qcom,sc7180-dpu":
> +  clock-names: optional device clocks, needed for accessing LUT blocks.
> +  * "rot"
> +  * "lut"
>
>  Example:
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> index af95586..61d659a 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> @@ -8,13 +8,10 @@ Required properties:
>  - reg-names: The names of register regions. The following regions are required:
>    * "dsi_ctrl"
>  - interrupts: The interrupt signal from the DSI block.
> -- power-domains: Should be <&mmcc MDSS_GDSC>.

Is this supposed to be removed from all SoCs using this bindings, or
just yours?

I'll also note that you left it in the "Example:" below.


>  - clocks: Phandles to device clocks.
>  - clock-names: the following clocks are required:
> -  * "mdp_core"
>    * "iface"
>    * "bus"
> -  * "core_mmss"

As Jeffrey pointed out, you shouldn't be removing these from old SoCs.
In "drivers/gpu/drm/msm/dsi/dsi_cfg.c" you can clearly see them used.
Maybe it's time for you to do the yaml conversion and handle this
correctly per-SoC.

-Doug
