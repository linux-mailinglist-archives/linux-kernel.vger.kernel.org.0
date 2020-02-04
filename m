Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADA151DEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 17:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBDQLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 11:11:31 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41159 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgBDQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:11:30 -0500
Received: by mail-ua1-f66.google.com with SMTP id f7so6922854uaa.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Wna36vo5UJeWT90pPlyYZdqk7kd5cJ0fLDcJ01xAb0=;
        b=A21gEwgiD1x55Cgg9LjGfwbgFr/pS5Aa5glZkaPN7ewWZr/AH0Ut8TFTqMXagzixII
         y8sWSkkrWyr8VTB+HQi587L2bzikWmqncXEqczU4GRd//Y2QP4QzAqDdpemle9Gx7TmS
         ZqhPoj2VUI2qjwzncsxNVVYt7jOZQPsWfcsuHdfqNnAylB0pHJwSk9FNSlSYg8DDtG9E
         YbxGiVEcPl2GkyvB4xTgsGSkrhVY1V5NiWFIFA7qflV7rgMwWepSjz71KmQFVPppN+Ea
         FXtbPXPIhygSTNxHKTu2nZ/U1sjRvLcmKrstFw5MmhQbKI+Vh7JXa5PgOzWZ3VVtVcMX
         79Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Wna36vo5UJeWT90pPlyYZdqk7kd5cJ0fLDcJ01xAb0=;
        b=f7VMSxO77wZRWaz2jzMd+sHTLAq0VkP0nRyg79IIbSCgxpVZ2laNKPqsGGETOZXLgk
         PvnwU2qJfZLHdBE7zS24S/4Ly6n3HCzKoUwGVsDc9OeNMitC7pF8HDdK6VbhO5CcgO/i
         S/2bHIYTogar/Ap/hvqZGLIqO3i/Mhu9mGNNm4PkvMLbJu+hCwPDbX5mvLEaCsz3B4lM
         gMzP91y4/0T2rsIA7tNoPtYuMhzwnGfMouD99HfrvkdrTXiQwACO/CcN6+HOIAcHzzfu
         zp0S5+8st/g0bffyP7bZjV5uc0g22s/uj2eQsHgtKewngAxJH2WbpAzarcFqXU6UsOz1
         JUuQ==
X-Gm-Message-State: APjAAAWvJ9911zz8FIYcNrrC0omB+Mmn6s3bfFR7YK1go+/EtArItrK/
        YmF5TEAcRQFJZChbyvTtuN3lBQ9nx95oUCbiA32UKQ==
X-Google-Smtp-Source: APXvYqxOPdcglcZaUAT0pZaljv73i4NlWwFKpThbuWemE8YWkXfRhT7zfpj0xd/OaNAUkecAe3IzrKUUtxl5vdmvEEc=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr17400525uak.129.1580832689305;
 Tue, 04 Feb 2020 08:11:29 -0800 (PST)
MIME-Version: 1.0
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org> <1574254593-16078-3-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1574254593-16078-3-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 17:10:53 +0100
Message-ID: <CAPDyKFqdyvvFCQ-vJU=0xBV0OKik3pBvX33H-mb=i9_TSU8QLw@mail.gmail.com>
Subject: Re: [Patch v4 2/7] soc: qcom: rpmhpd: Introduce function to retrieve
 power domain performance state count
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

On Wed, 20 Nov 2019 at 13:56, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Populate .get_performace_state_count in genpd ops to retrieve the count of
> performance states supported by a rpmh power domain.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Apologize for the delays! Re-kicking reviews now, I will provide
further comments later today or tomorrow.

For this one:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/soc/qcom/rpmhpd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 5741ec3..9d37534 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -285,6 +285,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
>         return dev_pm_opp_get_level(opp);
>  }
>
> +static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
> +{
> +       struct rpmhpd *pd = domain_to_rpmhpd(domain);
> +
> +       return pd->level_count;
> +}
> +
>  static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>  {
>         int i;
> @@ -373,6 +380,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
>                 rpmhpds[i]->pd.power_on = rpmhpd_power_on;
>                 rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
>                 rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
> +               rpmhpds[i]->pd.get_performance_state_count =
> +                                       rpmhpd_performance_states_count;
>                 pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>
>                 data->domains[i] = &rpmhpds[i]->pd;
> --
> 2.1.4
>
