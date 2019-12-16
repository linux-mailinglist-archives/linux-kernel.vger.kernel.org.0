Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6716311FF77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 09:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLPILX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 03:11:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35971 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfLPILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:11:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id m5so3581864vsj.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6tRXeWjXk4XedCBH813uitRKRnMxkJ3VN0a1mJ462I=;
        b=xJHekG2TdTb+LjYMgzpUlMBTcfPzi1OgpdZLNcJRg1av1YCSUAvk+0DxpGeRw7u7Q+
         toLenzZhgU5SPk9VLTTgb02mRNDaNb64/e/uvkDOhQ3imNCaxIktKL5hcM6FysO20noR
         8kZHiQmJFuEMKNTqR9B/Y+HzsYcqhnF3KUfP5ApIauHAQa4UGK5PZmf74KvcA70ckxSP
         DfVmHPPk8z3kKHwO5fx3HDrYK0i6NBIqqPvpBueA/xU5yLyCGTdyIaDl9KxKUMUYFxkW
         DX6kToJ6oR0mSPSSN5Zxvwd+iUtJGZIXxvyUudxjDQgPl5uj+W2SyTF4AaDiGhLHDtqu
         gZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6tRXeWjXk4XedCBH813uitRKRnMxkJ3VN0a1mJ462I=;
        b=jLQZk2b8n3bgMKH0THXm2cq3+cOWQtVO7j1VwbQ3JLv4jCAe/7gzoKVigiifsOswEd
         IkCaqIxEDoFZrwO4x3BvywKqWvopsXOiIHJ3WLUP52QpsIcZ9zsT8tWuS7FkpOjXKSzN
         HU6bibBLCL2KULZWsk9iJHknLv9TqCMCTCTBBHsJvoifp5jlLYgEfkK9ZfmSm/P22SGI
         caufc/VclljKel7bINXON3iZX3aVO7lFS0usY4+xKF3KXp2Eq93hjikoc6lphC2YIaVn
         rg5sFMsSm1SXuqKS9G6pdWWvFCfFRBkkkF5W9fvrwmsUbJD0SvW7Tlga6hkQPL2N5R61
         adtg==
X-Gm-Message-State: APjAAAWKKfy8xzKm9UC2FLEruTkxJkYVWNjoGlC5WjyhcH48BlMhzixQ
        vyR446pTQG03vJOZEJw7Ikno6NsAw1eIHuhb4x5oPSJU+Zg=
X-Google-Smtp-Source: APXvYqx8OxQ29bLWSegnLGTEgAkOiNIm/HsyXoLgK379EsycJHVuhlApMERuLDXwVmUW239wqgAmcF8kHHxlBNc9kE4=
X-Received: by 2002:a67:e00d:: with SMTP id c13mr20218532vsl.57.1576483881730;
 Mon, 16 Dec 2019 00:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-4-ktouil@baylibre.com>
In-Reply-To: <20191210154157.21930-4-ktouil@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:11:10 +0100
Message-ID: <CACRpkdZX2Q_EknW+ZJcKLfD1fstM_QOvpvc=ZAnhRvOtbJ4y-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: at24: remove the optional property write-protect-gpios
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
>
> Removing the optional property form the device tree binding document.

You're not really removing it just referencing it from elsewhere.

> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
