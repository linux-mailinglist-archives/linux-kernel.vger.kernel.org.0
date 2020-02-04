Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A708151FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 18:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBDRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 12:41:16 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38558 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBDRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:41:16 -0500
Received: by mail-ua1-f67.google.com with SMTP id c7so7052364uaf.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtZzN8vcOcMPvNvqvRcWKk5U95hQVMr3boYd7IrlDrY=;
        b=CFu0cZpe3C4v90cEH3brWH9RBZtbMCvv87Hp8m8LxZvjSzaP1oI5PiQDko9Q3u3Nla
         qp8ZOZUYKDhQAsXxwy0U59Ya2N4eQuhNncoPY0EVDh7RlLprTJNdDfmooEQI7oSj9WuQ
         JCO7V2PxVzQgg1CY3YvL1RuWl44dRoyiRibazjslnRvAL6Vq1eJrwfAi0S31AUrHMb81
         GTZvXC+k/1+vTHJb9VrijEBJAplPs0bYkzgjAqZOuSarQhpWw4FX7QA3r0hd2lFWDwxZ
         dLXWSo+CnGlxn1LuH28qxWJNQHjq8gBMjBcUXSdGNoaoZ7ln3lxVaQI7KmrQS7O+B2AO
         aCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtZzN8vcOcMPvNvqvRcWKk5U95hQVMr3boYd7IrlDrY=;
        b=exzJhaPKlgqESC6cljK3a8DFXPlZCap68klxqKCoXNtgFyigIQhg4lz6rmiKjC0mah
         NyOT+2xbkabPhNv9AqQSQoeOVEYcfOAEEpEnjS3Hxez/C9NaoRZmeoCmHonxnBJMden0
         EbMK0aIcfEhOOHD4e37su8GkFJIp7lVESL2O/TeB4yh3G1PgEgst/wVPxp7L74DEa8dK
         jXz6oI93zwNiFqvJD0Eqo/zOfsB31CE27Ggnvx8ofVpzd8gfgu9VSmBDGMxIMQFBfERL
         FyljGqAFYxYIQwZIq1BXoAZYPYWxgev2VgvDMYy5nH86ebT+ifH029wsz9qliEeUj4mD
         p1XA==
X-Gm-Message-State: APjAAAULFXGnzX/RHX4GaW2YSrDtFhzdkPckpG3g0kCIVnP93dnCZyOu
        Vn+os4dCwfJCjpLPmPlk5H+ZmUje85MfMSeOKHjW7A==
X-Google-Smtp-Source: APXvYqw6qGPNw10G3tsi0hqyqX4GroK9qi863aHaak5Mc0Sb8sOVpn/K2Ca35mj+Hcb9Ls8zP92QGhu4mCP5pdaUmD4=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr13726087uaq.100.1580838073804;
 Tue, 04 Feb 2020 09:41:13 -0800 (PST)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org> <1574254593-16078-8-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1574254593-16078-8-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 18:40:37 +0100
Message-ID: <CAPDyKFrRJ35hjpQfuup5Up1P433efusCgiKtza1A3o0ajsXkfg@mail.gmail.com>
Subject: Re: [Patch v4 7/7] arm64: dts: qcom: Indicate rpmhpd hosts a power
 domain that can be used as a warming device.
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 13:57, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> RPMh hosts mx power domain that can be used to warm up the SoC.  Indicate
> this by using #cooling-cells property.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
> v3->v4:
>         - Removed subnode to indicate that mx power domain is a warming
>           device. Instead #cooling-cells is used as a power domain
>           provider property to indicate if the provider hosts a power
>           domain that can be used as a warming device.
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 23260a0..71d6f91 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3118,6 +3118,7 @@
>                         rpmhpd: power-controller {
>                                 compatible = "qcom,sdm845-rpmhpd";
>                                 #power-domain-cells = <1>;
> +                               #cooling-cells = <2>;
>                                 operating-points-v2 = <&rpmhpd_opp_table>;
>
>                                 rpmhpd_opp_table: opp-table {
> --
> 2.1.4
>
