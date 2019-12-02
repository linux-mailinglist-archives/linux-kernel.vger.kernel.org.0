Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA10710F280
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 22:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLBV6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 16:58:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33214 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBV6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:58:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so1504200qto.0;
        Mon, 02 Dec 2019 13:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVaXi6VJTkbrgkla/zwTZyQ8K5/Xxz313P0oOuR5JLg=;
        b=XWw2EpfR9RQ5mqYx+5gAbzvTMmVCWjIReY5TUkcIZu0YmHa4ZB0fXyRpQt2prd/Jt9
         zB2H7XHyKxEelGbm1Zqadp6pIw230RhAiwSmkhq9kTLZZ1T1oTCTXScsMfTiO9GzVYgi
         Yhq8U0O6rEwP0mAEFu8/zQqPp/Jyi3YRBrHvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVaXi6VJTkbrgkla/zwTZyQ8K5/Xxz313P0oOuR5JLg=;
        b=BkCdUSXTvPBxh2mZRqvvICHe5pgF4+h8jlCPwAPAaeev9MNmxG0E7FWaQ3ebzcjlxu
         M26i5MM9hKHQD7RSufkv/JAYbMXwV/BIB3dGaagaQn3dCfl26ePjYqsIxWBBvRx49QK0
         8ysTPFF5onKq5Dv5HH/T3/f9rWgsVmG9kmv+cxAn0pBrOVeu1yfYuNTCrQ8oFkKrEXz6
         TK3IB3WxqRkmcwMldX6IUmqKBXbJ2xc89gpgY9nlI3o2fpc5hqxWdiqCWBfbmwlWpRyP
         VktyB2D077I+DpOkvHd+f+yLR5mD5AUl++pwnSZbJeXRB+SqVzlwUxlCQalG5jnjjtv+
         NPNw==
X-Gm-Message-State: APjAAAW65AGxvTUaz3AoyHPQtMn/dF/oMpCIoqWIp7n6VtgcKcSdr6Dr
        2iIdVnGUMwI+r+TYwTkpp7olo3wqsm7X+nOXcX+Vopx9
X-Google-Smtp-Source: APXvYqwn8km6OVIYCMYJKryuP0QuX/13ylrQEYjCB7m9ABt4yTHTTD4AFAZOfzcAiG0hyJq8vCjs4fCaeUqpwTnDWRE=
X-Received: by 2002:ac8:4244:: with SMTP id r4mr1769497qtm.169.1575323891858;
 Mon, 02 Dec 2019 13:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20191118104646.3838-1-i.mikhaylov@yadro.com> <20191118104646.3838-4-i.mikhaylov@yadro.com>
 <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
In-Reply-To: <CAPDyKFrshWd1P9dZGTSuU=5P0L6LSPz=v2nn+0SWi3ZZazKrRw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 2 Dec 2019 21:57:59 +0000
Message-ID: <CACPK8XeOgNviNY6gBw74Kvmf=a6d8t4PRbZk1YevxUG035QxUQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 12:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 18 Nov 2019 at 11:47, Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> >
> > Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
> > bit in case of inverted card detection signal.
> >
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
>
> Applied for next, thanks!
>
> For clarity, I am leaving patch 1 for arm-soc.

Thanks. I'd already sent the aspeed pull request for 5.5, so I'll send
the device tree patch next merge window.

Cheers,

Joel
