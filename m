Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADBE185961
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCOCsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:48:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43408 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCOCsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:48:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so10715480wrj.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0AmA3SLoC8G3PF3S4PDIyW1XE0SR/fol3ZCpKKwGF4=;
        b=tuOdksXjKZZa/708qsSizgny4phoyVaGYrcVVvAfW14rNkujRB73WnTehlqDmX778M
         zxDkQ8yvneee7Qqi4pr9gJCKPQETg7uhxDHfl0CBfuNoTXWMRTF+49WYY6Vvf7lM+MPG
         fG3inXx/W9ZTmUwm3paWeze7THNdiu0wySb8PNJMagQlDl0rnuSNfYya65v73XIyzZmS
         OXIY5FirnWhg0FuTfA3a4FPDGFqAUcg61JnAEC4JICqgsjpBTfSCgrcVQTTUk8Q8hYjI
         +J/UKD6BKFIhJAyIUP5jWy2RM/LsAonhQXq+Br+fjzIYAzzKV2EIhJZRII/TKHertYsj
         41SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0AmA3SLoC8G3PF3S4PDIyW1XE0SR/fol3ZCpKKwGF4=;
        b=sC6PLj1L5FTUA/rd2+VFozq6cMVF5EEZJNGTEgBcQtzTQDKUQO5LUi59Retemcmqqb
         1jbxNGAioa9M+DJA8fOiwFzD95aypLFsDygBMBbHzetZqvuvTIGbRijvXTTGB9E4Plnp
         HzuHFWAjSJh/s2W9owbQT99xweZGa/esl61172zwT9Yxi+spU7NRk6qzozpt6MW2UyRa
         ZqbwvW1WqOgj8D7B03riHTebTapavt6z/2IGHGJxw3a0U4FedAobUbCxX+Lc+Y0bVZGt
         DHaCF7cx/scMQ3ACD4HSMyVQzOSKLd7dSsu1ga7LmXbhvlbNwLufJYR2QPtIjKsm9pZA
         lwnQ==
X-Gm-Message-State: ANhLgQ203bNTZAIOms+1gYxW/p553E3uftAppaH/B0y9neeqkAa3JpR6
        /f2ERjplPMVI9Ltt/5jh1esuhWaAAKlZMBWmI9tsasSGdlA=
X-Google-Smtp-Source: ADFU+vtD9cF248pexW4HplsKMBOQuYs7SQIgQqcJUCNcsIK+1AQEgSMvapSwYQWJnu99xSl4lE/n176hcjQijrnhhMo=
X-Received: by 2002:a05:6402:3047:: with SMTP id bu7mr16918474edb.44.1584169471767;
 Sat, 14 Mar 2020 00:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312152510.12224-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200312152510.12224-1-srinivas.kandagatla@linaro.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sat, 14 Mar 2020 00:04:20 -0700
Message-ID: <CAOCOHw5oX89s8At8sUSchHhU0BfO5LdBc95DUN-82ihVP7U5Fw@mail.gmail.com>
Subject: Re: [PATCH] slimbus: ngd: add v2.1.0 compatible
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 8:25 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds compatible for SlimBus Controller on SDM845.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> Hi Greg,
> Could you please pick this one slimbus patch for 5.7.
>
> Thanks,
> srini
>
>  drivers/slimbus/qcom-ngd-ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index e3f5ebc0c05e..fc2575fef51b 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1320,6 +1320,9 @@ static const struct of_device_id qcom_slim_ngd_dt_match[] = {
>         {
>                 .compatible = "qcom,slim-ngd-v1.5.0",
>                 .data = &ngd_v1_5_offset_info,
> +       },{
> +               .compatible = "qcom,slim-ngd-v2.1.0",
> +               .data = &ngd_v1_5_offset_info,
>         },
>         {}
>  };
> --
> 2.21.0
>
