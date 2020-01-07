Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC481322A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 10:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgAGJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 04:39:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47079 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgAGJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:39:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so51529194ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3cS/9vMqkCo81SU7Th62UWfgu4oOT1UjxMMEZTVDxA=;
        b=rA1Ka7KALGpQxmvVbPE60iglLaoeccZWqncEs7Bjwh+b61n6MsWy280UTIFBwLJEby
         xmwoXqiZflpYJ0e7Fe10bmEBtJckNsAzc53GPaTZrU93LxftedP8Fqu+J1gCF+pgpyBT
         I9Yhb6JkWbMsamoOwevMg2+pvk9H+va78YEYNy6ByEVnqtGA/OPU5+5Xe1CgGC7Kg6D1
         kaNsCYi42q9w8cd9mX+QTtVzgeIUiMR4hua4DrzagL6RSOGuEOMmZU+xvQHRhRbBHG3U
         /Py9pQygYD8j3siHFuy5/Rr80Ubukx9DIIW+CO6S7W9ftoGjyOV8dE/qUJ44skLXIf5r
         4bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3cS/9vMqkCo81SU7Th62UWfgu4oOT1UjxMMEZTVDxA=;
        b=bl4F1SIGTJwfqru8eXnfG1M/w/Pg+9dBM6E0xEtJRcS1rU8+BDfUf9rmBqcdSkhZ+I
         eE/evi+DUDv97Huc429o3o71vMzsDu17cO7ImNQpuXeRebdymFP/zTulLlD7imv9d/Xd
         vpbAsjsrjrjIeVUN60yMQY18A7BHMNEUz14ii2hzEX/U/AbQaVxgLeP3LXvNfqkLB6KG
         mOKVBxDksHN1RnNrXdevQfF3sv2J8q67gmu0mpBVx1ZkJkNZyYeHyyv8def26pZela/X
         QsS0txY3xfv9rR9/I8caJR77UU8dh1QAnXV3AiG6FdgYWbyORvJk43Zyed/XmXT+7+ze
         WeKw==
X-Gm-Message-State: APjAAAXrtEa93Xz3/ZhWazJr4Go5i3hzQ5xV/XOzQbpX6FN1TOfFWxOl
        RXGSBJQB6fWHAFVzC271tbPPRScdpOBL+6lAZXGGAA==
X-Google-Smtp-Source: APXvYqxY6HGvUSX2SGuDJvW9mvHmyqwooWDMMNv+qXRlUg9DlXeEWdh1EBMi8VP9eCgXqAhVRVXwW6n8fn5Y7fYIRQo=
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr25811363ljm.251.1578389985321;
 Tue, 07 Jan 2020 01:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20191218101602.2442868-1-ben.dooks@codethink.co.uk>
 <20191218162616.qsxsltfsrxotzqhb@axis.com> <048c9653-114b-f726-44b2-9eb1d460b5b5@codethink.co.uk>
In-Reply-To: <048c9653-114b-f726-44b2-9eb1d460b5b5@codethink.co.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 10:39:34 +0100
Message-ID: <CACRpkdYFzHCMLj5oU5JMCkQkMZyOvM5351tpO6iEsE8e5nBZWQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: artpec6: fix __iomem on reg in set
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 6:32 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 18/12/2019 16:26, Jesper Nilsson wrote:
> > On Wed, Dec 18, 2019 at 11:16:02AM +0100, Ben Dooks (Codethink) wrote:

> >> -    unsigned int *reg;
> >> +    unsigned int __iomem *reg;
> >
> >       void __iomem *reg;
> >
> > We're using as an argument to readl()?
>
> yes, readl() shoud take an __iomem attributed pointer.

Shall I change it to void as well when applying?

Yours,
Linus Walleij
