Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5FB23FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfETR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 13:56:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36242 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfETR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so13837695otr.3;
        Mon, 20 May 2019 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXOvDra3GYVXRTYzoLbL0Bskxi3eAOjAFxHF07MZQNM=;
        b=EUpH/eB1pYTfMfO+mY3w9LF/pI07gQS2S/BwAzn8jJhZYYkufQNJFmSeUUPOcHATOk
         ANW3tVACzDfeQc89sQYGoypgC2L+lEihzU0OdL1r1pBM126FwHLKanSghrMpHidOWHes
         a3QJPM2tSV7el0FLS73YBDRERJCs1tsy/oUz8YLjVvvEczyxmk1hBRwdSov2YjNGBYT4
         zpWGAWlI1vX9fG+jqA5ce4HC++cv0au/u+7WJgiK257qURuPbMwzTdll02qcfjtiz8Tz
         jvn3ydM+QNL6+DvDyXA+trchDxPTkXdx23lV2UJS1tU61E1SVVbCE9VOBola40zsiOkM
         q18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXOvDra3GYVXRTYzoLbL0Bskxi3eAOjAFxHF07MZQNM=;
        b=WBf6j49n5uIDGKWDI0To/fq04273o1oo2/w9MDvuYr81sUw13es3ayBIo8ZPQ4jdHg
         5R1DQu5C33VawKYIDfPSTik1pfea2Nr8/LDIaazwxR/VJgzIYeiFDJQ5nfcrw+Od8OI7
         tCdozmnUg290HMHMyM4Ae4gCJnoO9VMXBitd/eM5ss3gLnfl9R1zHbsJigmvfXnZQn1j
         QB3cLVVdDtdy22//mpchkAdLreFgNijoC4iAldm5XwaBEHyoPu7MBXc+3tV4w/+59H23
         uhLkZo2T7WsxG9ySOiE4fbeq4e9OdjIuPrLwNecgnB16t3wnrFkNz29dOqvt5qBwIquO
         bP+A==
X-Gm-Message-State: APjAAAXIFtv94sK4xRuUzI2dhJlaBurzCJPXUxlvCexYyAABnjRZpUOQ
        dKwiyUg8W1W84D1ZbY+zZe7u5+G8gN733O3tAec=
X-Google-Smtp-Source: APXvYqy2RzawdpIc1HHiAmR3XwyoAucu/u340Q0tybzzu1jn/P0w89t3q3knDtRkvNk0w7rRp7KRKkrHEE4DJMJ7UyA=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr45241893otb.42.1558374998281;
 Mon, 20 May 2019 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143647.2503-1-narmstrong@baylibre.com> <20190520143647.2503-3-narmstrong@baylibre.com>
In-Reply-To: <20190520143647.2503-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:56:27 +0200
Message-ID: <CAFBinCDy9rOgk7pHSfyam1YUog8PFJiqyDNhqPC_ayY+6tWrZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: meson-mx-sdio: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     ulf.hansson@linaro.org, linux-amlogic@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:37 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
