Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868EB10C998
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfK1NjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:39:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46750 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1NjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:39:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id a17so20054678lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D6I+KTtT5RrNfHy8HpHYMT8VJs7SJnMqAJdYid/7wUs=;
        b=S7EvmoCibbEzYx4xPT50J8NUwH/UMgvuVazKBvgS4zza0WtWGyRCvCa9WB0DDo/hEz
         G1LYwoBExE7YLI7D+UDPPe97azpnDtR7nZF+AL6ZQl9vtYN4gXE9QA07mQY1sEF0FViN
         gUoh4lR3UKPkFf2l4AZjz/U+Ym4YxfYABShVh8NHMnvdQM1yuvtz3zPQbaUypD/44PNS
         x1CJRsFsxVUNAxi6/GW2m/WLDk/SjNQVpI6qPgITf8yOxoIZLa6HQACdu731z7tKkEFf
         9xWKoMcYUmInatclY86KOmBz1ClgA0FPDWy0YPsgvEgwABbvaGQvo5iqlM0lBTts/BlG
         H2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D6I+KTtT5RrNfHy8HpHYMT8VJs7SJnMqAJdYid/7wUs=;
        b=WdHAf8HGSsk8KsftcLq6oskWNUADE7FlSkuQrvFpnnhgfgHQ/dAW7udH7M1NeZnoGU
         Chsmi7alrkCKpJ/Q5NDVQgol+w4m/n+90L3VLk+Eo0a7luWLrx8fxhxYmhl9/l4bcpc0
         /11csmIFq8SLM2v0BizgXoa/2zUcKPjZWjos6rxhz5Zgrr9NymPNYWhHMGZYEWApMGYm
         ubDmpy0fXpgWywbgdea35788lEai9zWHlGtyvLzyr8qIdHOEgGFH/S5LdDwysvjmXXXE
         WhySSjvh7NaonF1QVTnzyN+OiiAiDiYhFLCT7kyfUnKnrgrpAMq7EnveN5keL2UD954F
         C6dQ==
X-Gm-Message-State: APjAAAUBzbzMiRknKrYRAPsjW3Z1Sp4ugR8BioUyUQKUQinZYp57oaP7
        nUVBpHHBeJCPOQB6A3R9vFACdG3Ui4ov1q1sN7+r1Q==
X-Google-Smtp-Source: APXvYqxmlz69tEBni6zXCDozi9A2S9iyrzZrXFUiEi/GPCF1jeCwI9TC1gpKuquuR4/Kv2cZ5E8a8cVfVuetJqrnSG8=
X-Received: by 2002:a19:c84:: with SMTP id 126mr18591776lfm.5.1574948361862;
 Thu, 28 Nov 2019 05:39:21 -0800 (PST)
MIME-Version: 1.0
References: <HK0PR01MB3521489269F76467DFD7843FFA450@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
In-Reply-To: <HK0PR01MB3521489269F76467DFD7843FFA450@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 14:39:10 +0100
Message-ID: <CACRpkdax5H0ar3ujKDohXvDZAXPWNWFKE1_AX9tn1FEOv5Yteg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc8xxx: Add platform device to gpiochip->parent
To:     =?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zero19850401@gmail.com" <zero19850401@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johnson,

On Tue, Nov 26, 2019 at 7:51 AM Johnson CH Chen (=E9=99=B3=E6=98=AD=E5=8B=
=B3)
<JohnsonCH.Chen@moxa.com> wrote:

> In old kernels, some APIs still try to use parent->of_node from struct gp=
io_chip,
> and it could be resulted in kernel panic because parent is NULL. Adding p=
latform
> device to gpiochip->parent can fix this problem.
>
> Signed-off-by: Johnson Chen <johnsonch.chen@moxa.com>
> Link: https://patchwork.kernel.org/patch/11234609

Patch applied for fixes!

Yours,
Linus Walleij
