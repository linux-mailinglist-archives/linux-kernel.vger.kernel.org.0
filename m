Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7ED11242D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 09:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLDIMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 03:12:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42821 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:12:17 -0500
Received: by mail-io1-f66.google.com with SMTP id f82so6988887ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I13QOM/XyZe4jexaUu6Tg14FjNQVNu2OzdTG+eKEvxs=;
        b=Urf/A79crlroamjdZ/4jO0Ea3JsVS/HR0RS6j4Scbe/uESPEuIqzn1CISgZZ4M2O5Q
         2IJ/bbCONVPXPx0UHdwldQBbY+glrYv9E+RAOFyiQlZhteyXjKfPhHoaC0lmBx818SVx
         zrOFUawhELjFTUzvBv6ySv1v7pSJqYo2WdgONHIEbMLzMRuo7ZshWOT2URSNCCVm0tFs
         dME9t6qUHmmDkcJ78hRUgtnH7QGqkW7K6X4NttTr2wqeRCOPQMcv/FfDYNUVmkpEpxui
         EHybpT0WbT4GlKWVIlTpGBZ+k3S90J77Jjt72aKwVx2gqSklHM8p5i9ZFJGkKUFnam/Z
         +fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I13QOM/XyZe4jexaUu6Tg14FjNQVNu2OzdTG+eKEvxs=;
        b=hZRUD9UCOI0g2UUQ16QZ1gb8IWPScnQ+gR/WFkDlmJsFgeiPCuyuShdEP8tv4MVzlL
         0HCTcuEVtT5752OtIVGCLelh+LL084NTAhyE+7c02G61WuLXBMHcJrJ8WQG3akiHVElI
         BcI8z5ynGBAOEj1EoIrdySt3z66HY3B8XByK6kNq6LR5EiSHng8+xwpM4Ww8r8d1ueL0
         m8bkzvCH6SwZNE+s+mjBSk1rEnKETLxnxa5IWsGi0081YHO+4K6OQsqm2bI5mgb8xmAo
         5mTLU2MT5q0UVXAB2fflADAKQbQLVzU0VaJjcfi1bom41ZbZTWj747Nt2RweXpbtPS5/
         2FQA==
X-Gm-Message-State: APjAAAWwZOqxXSAQSTRXc9+hi3egmvAGIQPq1jUZj+1GGHwjL5NuW5cf
        vh0vSSwB7W8EQ8TXiS8WZz82WqCkAZlvPTkNhs5QgA==
X-Google-Smtp-Source: APXvYqwt6fIkH5aRFph0l1Lb7nTwjasXYcWkPzvXCdXqxUsHWhUIa0fRQNvSZ2zcwf47+j1kV/aNS9rzQoInjIAmU2g=
X-Received: by 2002:a6b:c7c7:: with SMTP id x190mr1124939iof.123.1575447135988;
 Wed, 04 Dec 2019 00:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20191204071958.18553-1-chaotian.jing@mediatek.com>
In-Reply-To: <20191204071958.18553-1-chaotian.jing@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@google.com>
Date:   Wed, 4 Dec 2019 16:11:50 +0800
Message-ID: <CACb=7PWeW+aYx3Dah0CFj3cyG+Wr=gOe7pfo9a_jmfjvjJeFDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 3:20 PM Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> there is a chance that always get response CRC error after HS200 tuning,
> the reason is that need set CMD_TA to 2. this modification is only for
> MT8173.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
