Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BCF165FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 15:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgBTOlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 09:41:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42757 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBTOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:41:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so4461086ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WHlji+P21Kboo5TQBiiWNfvaJqWviYfKbr+yK7daGI=;
        b=nfg9Y6Ya/mjmEh/GzbxiwCKmaI718Lx4GQTRMhezN/qmHQnRJW5dmO5aVAgatjhxHU
         YEOjXlidfsnh9QFoG+NSiL1n1Q492pfQSLOcbFxlwj5VNOzkN1718A9Q5pNBwqFywrYB
         RTopqCqy/uVOQMnCaHvH6/uVvmnfckQSWCy2JjDIKybxlOEevBtn7dP8Ty8ql27ILKJU
         YBgUsLWtDP9I55WgtlRCXnphieUnIwGnmcZbciKmKFfaTfsecP8NhmPvU8w/ghsPRsJ2
         H2NNymtvfDY/jGYOVNz5YPJ2aGmjrg8yuqisB6v/XYSGm4BiPObsXiJMcXMBOdKPDusA
         Ud3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WHlji+P21Kboo5TQBiiWNfvaJqWviYfKbr+yK7daGI=;
        b=cigmIcecnzJoqIitzXNmVEgoy9YI/hwIG5nrOwkvwrX6LeBHZyKDtTu1ePyJZYNbM7
         1zbC4H4gI/xMCrIcDkr5mOfg5tVjk5/TOPsZEWqEMk9gFmAx8xyd1UnxQ5RteFdpZSE0
         vEmdyY9woCQzEllIDgtRg8r4frRXdIsAMflt02pBMtUqA26YwTrQ1tsGqa7IncLBguUd
         5yHW7p7LcOG0gQRX0tDWPrC3rC7l8IbdmMw/qn7er5sd06Jtx04FUlDRxR+hSlJBDTbZ
         G0E6zKsnMGCjY4TMxxB6/GXIlEcnjbM0t1sMQ/kKRan0q2aHKaBEy1/Lnbiq2VdkRd4p
         ryJg==
X-Gm-Message-State: APjAAAXvvFxtng+/Bo0Ozc5hV48pHRUKJrztsYFDJxAay4+l7ZNqxTpA
        Czrz4z933lNBfGqmSc/7AF3fyw9Id+Wy5gpmNJYREA==
X-Google-Smtp-Source: APXvYqxdFNDLDnJaghMfOLP10G1gDevKPVMi1M6I5zdGkYtLMParaXo3/Sybal+uTiumjcsJkqh9NDXzQpvCwf48k2I=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr19923920ljc.39.1582209700508;
 Thu, 20 Feb 2020 06:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20200210155059.29609-1-brgl@bgdev.pl>
In-Reply-To: <20200210155059.29609-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 15:41:29 +0100
Message-ID: <CACRpkdY5xJke=5uuB9hv36j6N=kDwpwWg-7_aYKTpCBGRjASag@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: coding-style fix
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 4:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The indentation is wrong in gpio_mockup_apply_pull(). This patch makes
> the code more readable.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> This fixes another indentation error introduced in v5.5 that I missed before.

Patch applied.

Yours,
Linus Walleij
