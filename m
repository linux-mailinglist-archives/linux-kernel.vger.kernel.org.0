Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC01B851
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfEMO3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 10:29:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37659 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEMO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:29:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so17883857edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FLaTD9htTvtftbkGxqy7UQEd+WdiGpfqFwmirkaJ5Q=;
        b=RDRBYlI9hF51P1TuruS4vslT9QoliL1XMSvm4GAbslUC0iiz+rfnep5QSzcC5QSins
         Mf5FcSIhaYbx4FN/Katdr/4mwHbM1RST11EDiA/gl5mIuq7mgAqBNTKn7SJz6j62/DBc
         fim/Nae/7qvUejgZFsQul0QaZqY0dzy65gHg+o54a6U76xv/y4wHn/EoOUfzxrBmgUYA
         1pm5BTbpyfAE2h+GsyJYQMjtlEoR4/r0NJEeVTC/cD1OJ6B3OTjpRxznRTusO76VS19j
         spFmZ9gdFYMxENsDKE9FhYe5yhCbqqAEyfIcIcuhkhkB6F7YS7M0NWT5riBO1oMbxz+D
         jADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FLaTD9htTvtftbkGxqy7UQEd+WdiGpfqFwmirkaJ5Q=;
        b=d1meFhT6eVlgJ2Xa0eGZrwCHUXsGv7ClrZr20cNW82nU3Lhd5G2MdHFCVtB7AlFD/8
         a73VDCLTPlndQBFGF9dBheG8SzbT8c46nJkR0QAhsIM/L85DKlalR1q8J1CA/edJFcqh
         //zQRZJnRE/MK8Jb8JvZ0Rrs+WptbmBI0spYVWJYDlPBtqRnWPxzxjVFuHr6cIasjgVs
         5Quh3nGkMnNxxErwuUOOqRiAwVst6m1VYdm5EJkxTd8/nmXZ/PoYC0GxZJtU448j3JxS
         /5sD6BuSNN6+KKrQmySOAmnHsP0fl99gY51ffWXDZvZOJQkYe+tVGjWEZIor5Y9duuzy
         bbdQ==
X-Gm-Message-State: APjAAAXF2RXDnFroTpZT7jwLbnwFNmIJfg8ISTE8nSTGUQ9RBfVuO/eq
        DtN62C3Z5D5hLFbnLjDkg1iEDd4Q/IAhg7LD26Q=
X-Google-Smtp-Source: APXvYqydf9/D8f+92kIqnBdrsMPORxUBEPI+xrZtlyIJ5Yjd/frhsy+NdC6EgPaDVahBS2yMg+iQVyYzrlspk8Jad5I=
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr23173207eja.58.1557757783673;
 Mon, 13 May 2019 07:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 13 May 2019 17:29:32 +0300
Message-ID: <CAEnQRZDSTuUMrc9AC1S2zfo0PdQ-v35GmNrf70Zoasid_XMJzw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] soc: imx: Add SCU SoC info driver support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> +
> +static u32 imx8qxp_soc_revision(void)
> +{
> +       struct imx_sc_msg_misc_get_soc_id msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +       u32 rev = 0;
> +       int ret;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_MISC;
> +       hdr->func = IMX_SC_MISC_FUNC_GET_CONTROL;
> +       hdr->size = 3;
> +
> +       msg.data.send.control = IMX_SC_C_ID;
> +       msg.data.send.resource = IMX_SC_R_SYSTEM;
> +
> +       ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
> +       if (ret) {
> +               dev_err(&imx_scu_soc_pdev->dev,
> +                       "get soc info failed, ret %d\n", ret);
> +               return rev;

So you return 0 (rev  = 0) here in case of error? This doesn't seem
to be right. Maybe return ret?
