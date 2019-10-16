Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05391D91A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391615AbfJPMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 08:55:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40507 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391574AbfJPMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:55:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id m61so35883915qte.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqxICMW7ss0cJCpXCjJH78wnrlmcwqNrZ/uPiVhGkkM=;
        b=IxEjiKnpR3EAwPoByfW/OZrLpd19bspT+gTUCGnUW80EeuuPdpZRqreDbDpZch6gjh
         2UsT5c44kBgXtYD0yyrrLUBcME6KZ9UAnsIGSS63oAoCPC4JQ8YNVtxKOXCLrMCCA73/
         1uQIrb1Vu1i9W6DwGSI+b+rsQVP1DUrcyk/H0UyUx/1OpKVxCq6ozQE7t+pqdDkUL0sn
         EY3w6X34DDQGKzfHwdSWRQ71+nCXj4FycpczO6kiDghGZfj/sJ+8EwzYRxAizI958o4R
         HynQBp/BM/5tdTJgd+8CJzjA8auJ0h0fkSpoVTv7l/6JzFKR0UBivDwzUwBNh1q7l8cd
         CKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqxICMW7ss0cJCpXCjJH78wnrlmcwqNrZ/uPiVhGkkM=;
        b=a/V4MtmCiN6JcqmI4u3izLu5/LBSDvLQkiQ17BH8JahWtWDVYG1/h0HU3abqApLo+4
         VtTQSyAQnQ1j7iOcUYGylTNPmrt4CykItasUxa8/tTOYqnWJg4s7UBQNwl8iog2OdW1K
         JuEPSfDkiYOIzXY4ift5xE1qINw9WI935JqAhzCuBaCRQy36HEkI2AFBPmlW9RmAAuIB
         CPZHJnZZW/9dcmumhwGNo+ja06ogZiEVb093bzHS8wQOtTrpoeRilDywcC+DklYHuYX+
         19D6Ggz89X3pBzU24pkLFdMp6wzzMghyn/lekJRi5mi2q3wLGrnGRk/CipyIhVOItZIe
         imwQ==
X-Gm-Message-State: APjAAAWzapypABTBLF9j9unfbP0RQpfbSV40z9BKDb3QBHJ6NABSIqjQ
        x0oFpFZLT2qvQ4GE2tKr6bJdfc7Pp97zP1k8e6kv3Q==
X-Google-Smtp-Source: APXvYqwsdZLOyx+1BewFpuZzO2wCBhNDd8cI1RDl+5ftGeKkSjmdr0lrNVyGucGuzJalkmgT4E+Zi8XEFdHBdIzSqJg=
X-Received: by 2002:ac8:2f9b:: with SMTP id l27mr43783932qta.218.1571230549447;
 Wed, 16 Oct 2019 05:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571036463.git.baolin.wang@linaro.org> <45600b3601cbfe3685f4c9e088be9a30ae3eb8f2.1571036463.git.baolin.wang@linaro.org>
In-Reply-To: <45600b3601cbfe3685f4c9e088be9a30ae3eb8f2.1571036463.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:55:38 +0200
Message-ID: <CACRpkda6hT5Nma-vrtd3oxQ64QppwkmP75DJch2kMUUGpzDzZQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] hwspinlock: u8500_hsem: Remove redundant PM runtime implementation
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 9:08 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Since the hwspinlock core has changed the PM runtime to be optional, thus
> remove the redundant PM runtime implementation in the u8500 HWSEM driver.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
