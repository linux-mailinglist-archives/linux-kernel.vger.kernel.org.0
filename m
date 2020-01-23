Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66D146CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 16:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 10:32:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35808 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAWPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:32:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so3959473lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MGL3YN/a1QsM44T67BF5Mn1OkqchZqZP31dkXZT/mP4=;
        b=lIKFPf6Tl7jsOH19oq+NvqozpJv0bmxaxFy03dsv384STiTxLZaIwZ9MCDD7TcSjms
         dc8JovvWYpFCYORRrN51ypwtNPSfLrB0Px+23/ngRuFdumCWWMBAP5Q0xwjoSyBanLNM
         6Wzd6N0l98oyvojo0gcEkxFyMvq+IKKFKUUHN2fjJsxj5npR8+gukIGMRoCsfOINd4BT
         KHeeJ6qe7CvuaCU30ALw8FTOXGU6r+pslAjDp8JWFjEXCEqbvkjwwK/yJiHqs0x8KaUA
         N/FXUvlQBOPOC4hKjXNY730maf+dFo/6/9u9bs1A7JEc8HJ0krZ6IlnrZ3g7Rjj+QV9Q
         Rd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGL3YN/a1QsM44T67BF5Mn1OkqchZqZP31dkXZT/mP4=;
        b=Iw/3jtzzHjrPEFddUf4xx9RLtcIlXi8y1A2eWFswjPQbOtJwH8xtPOr/p1MlAw4RYd
         QCEm5HIiiU9AKwkEEkOxe9AxUoO3CS/3sDksyE6Hp2jwU8Zgkj4RGx6aInc4K67kZ8Kc
         XkMAAw1MbL5dvk11XGB/u792JMtlnH8LalKpFJ2EbZXFr7+j+TfjyduB9KgN27ws5LWz
         /jXlgjrymFk+rNt67CA4dK0V43PiN690I/A5F01NVuxfn0BUyGEpLJWz2v3sCtlN8ZFn
         4Dnxo2R6AES6Ta+BKMyaiSTL8mYtBvr1/9iyVnb31LRpVb9vCUezVKwYv7BnpdXrPJsk
         4kWw==
X-Gm-Message-State: APjAAAV1pQ8nJaGNYO7dtBuAtSuHlt6pidDq8hRSe0Ak92eM2U/Uiblr
        kJ2HIHbsrote3wGX+dzMwlAyLkqepIhRJ8/BHA006Q==
X-Google-Smtp-Source: APXvYqyy4QdMOJF7UAAF01QSHT1XerQGGdG1nEX/vAiaB1NLenghVituIA83K61RYohyedHfHXdT7JHf57/asDdf5zM=
X-Received: by 2002:a2e:3609:: with SMTP id d9mr22299304lja.188.1579793530470;
 Thu, 23 Jan 2020 07:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20200121180950.36959-1-swboyd@chromium.org>
In-Reply-To: <20200121180950.36959-1-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:31:59 +0100
Message-ID: <CACRpkdbPv_u_vMK_LjPc+p-hGoufx2KotcL=+Qp8_G=tXfaDOg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Don't lock around irq_set_irq_wake()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 7:09 PM Stephen Boyd <swboyd@chromium.org> wrote:

> We don't need to hold the local pinctrl lock here to set irq wake on the
> summary irq line. Doing so only leads to lockdep warnings instead of
> protecting us from anything. Remove the locking.
(...)
> Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Fixed the Fixes: tag, added Bj=C3=B6rn's ACK and applied!

Yours,
Linus Walleij
