Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C218F9C5F2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfHYTvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 15:51:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37838 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfHYTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:51:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id b25so10643085oib.4;
        Sun, 25 Aug 2019 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjng6vlLFgbv9Pq9MqHuljD4Do50I8hCQZSgXlEUD+s=;
        b=JrDdoARW3RK4az1cCf/czevGVpc2XlfXp8QUxGdhWyb3hVQORUWD8P3xDDMIDpy3AE
         3KAkLF5yPDxXJXfDCVqf7kuHgDdCRIqIGVn2h2f+jLlHQSQTp64ULV3JHXm5RuQhHD9B
         OCrtDQ8dqbF+NUrvZpRPclVYhN2us1pbugiPBNfbyc30P4xgzUvEY8dUsF+l4zc3tmgT
         q0UmeQYGc3WHoysYNlUofnqCWkg8/k0LPwPDN8+Qz9igplv2xKYrkqK16H+T7IiWs/qO
         zxn+EdozSlAEbQyfaux5mw/6XF2EmAqQGz+TvFuEPhDBsdbr1lJ2EgsLmr2kin//JpJL
         ZSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjng6vlLFgbv9Pq9MqHuljD4Do50I8hCQZSgXlEUD+s=;
        b=Pf/NZeIdekPcftppC1enRwlosYUNaIWhhUJON/pGgTqYMCJU07/JgFe92T4LmxGcwT
         wnCPmU9kNIgjCYlWBMPzVg4euoyr1Y4xY3h0bjSbz19hLg+8hSjso1yYxOL3CgfAN3sY
         y19BCykOUPM/8B3fT6AK4FnM7iWkxV5E5VaRQ2VucnNoCIDS0tOYBjNylN4A9Tze/h+U
         g8KAN7ooafTMl8TTeSFgVIfsXn2EK7TSEbDQgIF/JNjUH8k57+o+bSVZFokq9r+jmiC2
         QyMd77f8EfKLAYqWhRhA9PuNNETpFKF3WIUYFu/qIrP03RaPw2C88BRF3TV1+pJf6gYx
         jo/Q==
X-Gm-Message-State: APjAAAX/cNFK+7prZjc8JdU5EQur1dQpbqHluM+bktJ7drWM8NTBsT1c
        8mZCRclJK/lyZx0hm+ZAOGow8xmDf01Kg+e9QVY=
X-Google-Smtp-Source: APXvYqytfpz4w1IVT5MQr4MnHby/LbGVf5kKD4Rnq9rK/D7rVL1EJG62FQ5lDoR6ZfEKArVTzVXqRM0d613Y4v6IXcc=
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr10416816oij.140.1566762693708;
 Sun, 25 Aug 2019 12:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190823081427.17228-1-narmstrong@baylibre.com> <20190823081427.17228-3-narmstrong@baylibre.com>
In-Reply-To: <20190823081427.17228-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 21:51:22 +0200
Message-ID: <CAFBinCBLVDVWPbDZ+_cPTbJNCavvzJH4A6U8D9XWVSR-j3fzFQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] amlogic: arm: add Amlogic SM1 based Khadas VIM3
 variant bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

the subject should be: dt-bindings: arm: amlogic: ...

On Fri, Aug 23, 2019 at 10:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Khadas VIM3 is also available with the Pin-to-pin compatible
> Amlogic SM1 SoC in the S905D3 variant package.
>
> Change the description to match the S905X3/D3/Y3 variants like the G12A
> description, and add the vim3 compatible.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index b48ea1e4913a..2751dd778ce0 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -150,9 +150,10 @@ properties:
>            - const: amlogic,s922x
>            - const: amlogic,g12b
>
> -      - description: Boards with the Amlogic Meson SM1 S905X3 SoC
> +      - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
>          items:
>            - enum:
>                - seirobotics,sei610
> +              - khadas,vim3
>            - const: amlogic,sm1
on the GXL we differentiate between S905X and S905D
do we need to differentiate S905X3 from S905D3 (for example)?


Martin
