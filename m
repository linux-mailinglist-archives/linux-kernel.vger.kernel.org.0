Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0147314A8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgA0RIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:08:04 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37548 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0RIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:08:04 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so3718232uah.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOiV8nj2HZ+JtKcIVA5xQdznkVK/jM8PnqE9J+mRXqQ=;
        b=YrB//b92fTsHkMw3bXM25KI/RYWOU7ymbAeVsjo+vGfk3HbEiKFvFYtASMzcTT0lUM
         dyv2seW78v0VKay+qVrhTS3Jpn7Y7unPJ29rR2HvbrOOrPCQzDq7qdIqyFckjEDe7+Ap
         aFRB4NmCvhUk0h4tMLr2fD0rmlmi8+LY4yxVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOiV8nj2HZ+JtKcIVA5xQdznkVK/jM8PnqE9J+mRXqQ=;
        b=PE2WevuOSSoo8Dp7SB/eX83rHaUg7SgwWllLI3egBV4GGXJxxQHGbqoPj+pm5GDJWx
         OGt8SW8AYlRTl2bVQ62WcKihUa7s+JNgFhWQ/XoXFdnGV8Qf2DrX97uoLCA+FcVvjLpC
         BFJ/pgNyM5gCWYJqNd2kjQqNCTcf3tO+xLVAMO+n16igqynfSXDhdbgV0FvAX40bEigv
         gUDovByK7aswg7ZLM4SUJJ+UvkVwtCL4kC88e0PvHRN0ZxO+mBTExaTppfa9JKqRDv/t
         RChFMaraYJ+9/7HMt1KcSVX6D9vvWL5FrKdbyS+Lx33amlEVeHrAIbhKCu21JYWK6UqQ
         n7NA==
X-Gm-Message-State: APjAAAW+asWrjZZmJozqi3t1LqvO6+I2Gs1Ur3xZrZQwf/uWlmD4Jt2Q
        oN+ti4MVfD/B8bs9z7z2NyhtOTz6K4I=
X-Google-Smtp-Source: APXvYqzJ31qmrxLu31kjsWps9lm2BUxcgJvdvyovqEV7Sn8c9+J1cy8HfhqRdn+FZvSJU0PE+pFhNw==
X-Received: by 2002:ab0:e16:: with SMTP id g22mr9927051uak.129.1580144883063;
        Mon, 27 Jan 2020 09:08:03 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id w28sm4758064vkm.36.2020.01.27.09.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 09:08:02 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id f26so6116989vsk.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:08:02 -0800 (PST)
X-Received: by 2002:a67:1ec5:: with SMTP id e188mr4925367vse.169.1580144881597;
 Mon, 27 Jan 2020 09:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20200127082331.1.I402470e4a162d69fde47ee2ea708b15bde9751f9@changeid>
 <20200127170457.GK2841@vkoul-mobl>
In-Reply-To: <20200127170457.GK2841@vkoul-mobl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jan 2020 09:07:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XKHy6FmkeyCNB+vb7Ws=uZWOQ-QpYOKPJZg9PhFcJf5A@mail.gmail.com>
Message-ID: <CAD=FV=XKHy6FmkeyCNB+vb7Ws=uZWOQ-QpYOKPJZg9PhFcJf5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Fix sdhci compat string
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 27, 2020 at 9:05 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 27-01-20, 08:23, Douglas Anderson wrote:
> > As per the bindings, the SDHCI controller should have a SoC-specific
> > compatible string in addition to the generic version-based one.  Add
> > it.
>
> Thanks for spotting it Doug, Btw did some script catch it or manual
> inspection?
>
>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

It probably would have been spotted by "make dtbs_check", but I wasn't
running that in this case.  I just happened to notice it while
chatting with someone at Qualcomm about whether
<https://crrev.com/c/2022985> was correct (still waiting for a
response on that).

-Doug
