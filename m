Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8894E1485D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbgAXNUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 08:20:18 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41454 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387897AbgAXNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:20:18 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so1161596vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t65RoraJ97XSNifH3nJWhcpZY1lN6qjNaU0+rNtB6VA=;
        b=gins8z7JzejJQal9gDEbPpdg5XvecgftPkBOzZDn61Udldh3usgTviD1RSeTs/khVg
         P6QL2wdgjepWpZPu2K07a0Gi2j30WxCH8luSM9XeXKn2a0tOlWNsCiBvesNyFuoRTa2l
         l+vIULJyGGwlTBlM48w/mQcMBP9WP2/M/8BvfKaietFwyHD4quO4EfSzZuZDebmtJUKO
         N78p+V3i2PTQYXQaBm9DxrHQdcBOrL5nyx5ZvfkLk7TND7MMNM/kXvpRBQCuqtQn+Mxh
         S+P6c2mXdalbk8iIrd+uIIUDrn+lJsAfuy8AVqcNxmXZb29qZ7+MytSuK9cABHt20/c6
         vbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t65RoraJ97XSNifH3nJWhcpZY1lN6qjNaU0+rNtB6VA=;
        b=O5syL5fhov0OmTX1DCUapUoxlYe7Gaa7DJFoNt7RSApU9DSQi168T943cskmPT3bZ1
         /tUl+WvKjdYH5D3h1MmiUSlGNnE830aZRz4RwlC2qx0bEcTtOPCSfF9kqL28McFHq+yF
         IdhMHUzRUhx+UiIOe4UknsB+ezDZ4RrXH93HJJGf62MHQeMjd2YTXNdcx7n8E+YCD4QD
         WkYfb+vKPLurxqojNwYQYzX2IWpcv6J4hqX4QDEVt4+z0NKtksO5DhwfY3MqFnus8dwG
         LaV9OP+b8bOpuS4NUOKE78BUoskajC4rg9y4+ZZ4Cn67D/l4GQAhUqj5VWySACVyfb/x
         /wOw==
X-Gm-Message-State: APjAAAWQoFUFaRk8OJta+uTGG2JKZYjNbJa7V/OKnVKZhnx9eTTT4EMj
        MOz1nem+urjWU4CEIjppJTu/BrqeMWpYDAVqK+D/sIaM
X-Google-Smtp-Source: APXvYqwPiZbZvXR+rHIvNUYilWv/U2EOOXMt8apmM26fWaq/fAZpxuaFlhAeSj98ruAwNOVdB6HsKU61mDEy2b2ThPA=
X-Received: by 2002:a67:cc3:: with SMTP id 186mr2203033vsm.200.1579872016966;
 Fri, 24 Jan 2020 05:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20200110134823.14882-1-ludovic.barre@st.com> <6d859def-351e-abd7-0d5f-962ad935dff2@st.com>
In-Reply-To: <6d859def-351e-abd7-0d5f-962ad935dff2@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jan 2020 14:19:40 +0100
Message-ID: <CAPDyKFo+4qTZbE=4Zgj3VN9BPYUHGskPSnYEJRo1TpARzg5zJg@mail.gmail.com>
Subject: Re: [PATCH 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 at 13:55, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" on this series
> https://lkml.org/lkml/2020/1/10/392

I was just reviewing :-) Thanks for pinging!

One overall comment is that I think you can try to work a bit on the
changelogs. In some cases you described what the patch does, which is
good, but it may lack information about *why* the change is wanted.

Overall, the series looks nice.

Kind regards
Uffe
