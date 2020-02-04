Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A25151F60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 18:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBDRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 12:25:11 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41272 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBDRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:25:10 -0500
Received: by mail-ua1-f67.google.com with SMTP id f7so7030204uaa.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQ5VpNlkKKb7XdD6t2/fjKBTlJ5xrb0+onSqPevSGn8=;
        b=jjb36hApE2rzA0PwVFrbGceWDgUFBRvIFh1O9GaHdj+09aKzb9Ac6Cy7L3R+0hMsRI
         XeqCYNXjropbpRxsmUZlOV7cfU89VXuPdhvIz1xBZk3yDCMeaUq/gyuuUTM/+NB7C7Zt
         M19FLFrg6K3918rZgxVyaRa/VOoIU/QZ6Ng7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQ5VpNlkKKb7XdD6t2/fjKBTlJ5xrb0+onSqPevSGn8=;
        b=PW5SdhB7vmYOxpLc3CRHns4Z62bsXqgoRtD43FwcJG4p5DKZl3GqqLFvdzM2Nj928G
         eFWVzfeCDWu+geK18XDihdj+cJs5ngO6dE90lQkPpw7I07Lv2dwA+NcBAr4i1o+Xf3wP
         oOwk1a1eXY+Z2yNRfssKIcoloJ1ss9v/FKdELSgFywFnGpPu5f1lPDazquC4kLBhjufG
         WqOMMFSizNURT3g1hgmNISgKNQnVW0QuNPwv8FfYA8db1WJxqFIVeo9SUQ7q5PBizVpO
         MCHxh3ECQ1pdxjKTwumhwlQp3h+3sYtlYtQ9EceS490LkIG/XPDC6h+c2NIRJucjw6Fn
         CxPw==
X-Gm-Message-State: APjAAAVo1cyqvstdto4Iw0uApghnjhRaLuYsQ5FD98xsvd7xm5eaTdFL
        PgKLzWSRTRAC90PQ5hn/hOm3kFHzgdo=
X-Google-Smtp-Source: APXvYqyW9V7jm6lDSmvawthx5G2ypDZD9GgIGA0mvffcIc1QpLeAAnQm5I1vJbVwmT8vGS1+QJu9eg==
X-Received: by 2002:ab0:64cd:: with SMTP id j13mr18781324uaq.127.1580837109305;
        Tue, 04 Feb 2020 09:25:09 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id m82sm7344161vke.30.2020.02.04.09.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 09:25:08 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id g23so11853873vsr.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:25:08 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr20331801vsd.106.1580837107900;
 Tue, 04 Feb 2020 09:25:07 -0800 (PST)
MIME-Version: 1.0
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-6-git-send-email-sanm@codeaurora.org> <5e38c036.1c69fb81.3da87.c53d@mx.google.com>
In-Reply-To: <5e38c036.1c69fb81.3da87.c53d@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 09:24:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ximzn+WwmDr62sjOsFOQRtQaB34BP7rY-y4x7Pb-zGPg@mail.gmail.com>
Message-ID: <CAD=FV=Ximzn+WwmDr62sjOsFOQRtQaB34BP7rY-y4x7Pb-zGPg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] phy: qcom-qusb2: Add support for overriding tuning
 parameters in QUSB2 V2 PHY
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 3, 2020 at 4:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Also, why not  use of_property_read_u8() and make DT writers have
>
>         /bits/ 8 <0xf0>
>
> properties so that we can keep things smaller. I don't understand why
> they're u32 in DT besides to make it simpler to specify a u32.

As per the other thread, I think it's discouraged to specify /bits/ 8
in DT unless it's really needed.
