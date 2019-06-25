Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD852811
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfFYJ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:29:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36502 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfFYJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:29:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so15530162ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr4BbnUnDdRpb27xjTEqnGYw6rCO5zWnBaHQ20uJ7BU=;
        b=KXHl8FC/0veHBSg/ULgTCwAprsrhNoPV8NhifJf2qTxk5mFMgWPX1nqLoyRsZPpvKo
         pFNeuWvTRzzWkCu7VDOLOQTmwjWurCgAG9CHNm0paqQ0oMu5cXKRHnkBONPQtx9LQARc
         iHvn/kqHRl7E/R9tN6rcqqlfRHw1fg2t9zCkzCMwbKViqQpaoPMrZBJfzx2zSCcFd94z
         IB3VDOxshdO4/wOCf0o6YVtNMGq9o799OlkamQcw4zyY5Ja95PPdydyyGhy9OeJcbF5A
         23mBAAUHxxh7n2g9nlhmWmgL/WADGjFCGEA9by1HpPG+CKCTPmTsxbr0g6WPLBhh+EwF
         Vyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr4BbnUnDdRpb27xjTEqnGYw6rCO5zWnBaHQ20uJ7BU=;
        b=IbGURsxKkNszkUIk2aqKAo4fD9ztvBQQIqZseEHSDl69K88XaByXT80xFX1ubJwbyl
         doG6jaypk8HHSslcPXKzqMsYuxXyevVnjn1MCfnHgfHkHVsrZdx5HoAJacjsU+z2u3eg
         Q9y0b2W6Oybt4CZQ5iuy7ZihvcBSWrNLkiDgwMhrzS/vamKL8VdDlQZcmAnay8JuNTLJ
         SjJUzp8cq4xI2cY4d0Hh0aRLrjgHJ3ktHgNOMV39nCtyevk0z50bdoeet0a4LibmyImb
         503DP7/dyWk/w6gUOOGxbBYb1ZlEsM4J38XxXBZsmlEjYWGw92x5xzdwL1jRJHEj5Eq5
         UqUw==
X-Gm-Message-State: APjAAAUaId3kWBBqtOfh+btIrlx554/IswSOoOM5cthsBy/nvr7NZOWP
        VIYdsgWdv7DuDmHvAkYRFt9TXCH/RY3K0iT5PdluuQ==
X-Google-Smtp-Source: APXvYqyq/VXlss4wucidr7AAtR022RhlcgqfGNaAxL8EywC9WN9LasEYhqnj3xLZO+qCDN0AUTVroAL+awthaj5oNs8=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr8538623ljm.180.1561454952662;
 Tue, 25 Jun 2019 02:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <1561354834-22617-1-git-send-email-info@metux.net> <1561354834-22617-3-git-send-email-info@metux.net>
In-Reply-To: <1561354834-22617-3-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:29:01 +0200
Message-ID: <CACRpkdYzpYbkMstj2nqv5ygvYipqFfhJ5GrMnRjQstu7op6rXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: gpio: siox: use module_siox_driver()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        t.scherer@eckelmann.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 7:40 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> Reduce driver init boilerplate by using the new
> module_siox_driver() macro.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Patch applied.

Yours,
Linus Walleij
