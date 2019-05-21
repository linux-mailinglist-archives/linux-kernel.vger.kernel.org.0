Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8A256A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfEUR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 13:26:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40822 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:26:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id r136so13426979oie.7;
        Tue, 21 May 2019 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJOLO6+fT4P+SCiRyBPi4+7nDWuVS/cC7SMFnlO8FSc=;
        b=n8lCd1SP0iIV23NZM5l7ia3aHOMNEtqfLvquCPcDPsnqwrEWFZ6vl9vMTQd1JRdQeW
         UXnFXy2vE1aEiifYnBqCVNna1rQH8K42SPgJjgyioDfJUNT92VDuAJx4Cr+reAYATiDn
         UOuJaaZ4PYi0cMSNKj5rrruCriHDjB/stgLnUu1+LH4TivLCmw89/aIaQ9nmfOekILtW
         wDNFBJWclJkOjPCeBpIj6bCh4YxXb5j7KtRis7iP3uU8QnIYH+JMtCgbPO15VZR60Tc2
         iHq6G+NRKM4NCrdZtpcARpKhCG9mABICAJd3F/9bTuTDbBcQd/cCUzhKfrtYVrHLU6jx
         S+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJOLO6+fT4P+SCiRyBPi4+7nDWuVS/cC7SMFnlO8FSc=;
        b=G55Z6/kHkUsEDzWZyMKi3w/rmRYXTVpfVI/jiWY4DQb9OyOPBmcckzuHVNn8YluDZj
         rqKkKBh+i+AKljCWDRUTIehHtIzguwjQdYVJ1hTd7BsvQiSacLaWNjAaz5zVgUF+8O+F
         vNzkeQIGNlFTz8T5ZsiM+0DkP+bAn/64OK4AHhkiFbBpL11EKnIJOKs8yMunM3adXPBH
         sxJ2PeOODDTfr4+Tv+r6HrX0lJIT9DdPlUjNOnTJiBVZixM6WslIS/7Z5ZNDN9hrqk7y
         j3ewRG3N42eXjvQSfhyen/aN1Feo+AqEIh2AIvHAivdYxS/ykv/cBr02xijAIjAwDdbJ
         +yeQ==
X-Gm-Message-State: APjAAAUsSxAKNpebtKNJIKhRUkvCK0Igd3uCXKhP8AqigwfC6xfFWVKU
        /nqzwUKHpCgBdChL0fhD2CkeBFiuwD5kziAynoM=
X-Google-Smtp-Source: APXvYqyxdi56Ueg7EALlUk1Ep4gxIoClF1dtxww572zKOE3qzb9zruGzNqp+lYbXuSuglCifRABlgvwxXURBaXVflsA=
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr4436854oih.39.1558459608028;
 Tue, 21 May 2019 10:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190521151952.2779-1-narmstrong@baylibre.com> <20190521151952.2779-3-narmstrong@baylibre.com>
In-Reply-To: <20190521151952.2779-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 May 2019 19:26:37 +0200
Message-ID: <CAFBinCCvoq0xkoCCiOqh7YHegZB4SJBjDMJTxEknDXogWiXUxw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Odroid-N2 binding
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 5:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
> from HardKernel.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Rob, Martin,
>
> I converted the patch you acked in yaml, I kept the Reviewed-by,
> is it ok for you ?
yes, looks fine to me as well
