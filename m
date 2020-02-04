Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75401521B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 22:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBDVIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 16:08:17 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35693 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBDVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:08:16 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so12449685vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSnbwBgsFio2ehfBChAWyJkxbhcuFHyXVUzB6wC6EcE=;
        b=FjYS2MR55uToDI5C+GzDlpxU8rd/BFpp55zY9ZUHZkqHH9XTRMqccWRxImQ42ROmuA
         /DEwp9VP5G5lN6LVdd05687vXMcaxB2Pt8lvrpLz6l7VHcX1haY9aYROuZgCs/b9sGuG
         CweceSZSCraRJ1FanI0mhXLFKn3I+UBA5uK98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSnbwBgsFio2ehfBChAWyJkxbhcuFHyXVUzB6wC6EcE=;
        b=FBs5kg1A7snk4E5y7tP6TdKDQgXg7Xk3SK4H3YKFRezyOc6rH91tuCgymvD+K+HAFD
         nGSRVrz3bOEaLCvvwtMnWhMsHMjZRvfUnZck4IqtWhfsU6ir3KOZ3td3gKmZPL5PEPcV
         4TVSpTYcgW1KqcHXNJzgjlEJP/MEo0WAIuj4ifur1lQfgOKE8XZAv8uYc232yqL7Qx5U
         bfKi3vHv1Z0T9MNF86KigejPenX0OlSS3Gi3wcqrgEdg8+SbEuR0Ht+AA1R6Z0rz9/oE
         NTyQztilUEQC0yIXHE9yyuvxC/VYqDZKsgH7h1a5+asWCEDmxGsGq5OjUoh+HPoKMIOh
         AeFQ==
X-Gm-Message-State: APjAAAUiT7qfXbBH3v/wxy5JE4F69RPTVy+8O7D4cQzQvEGPkMOzhB0Z
        5pAMSvljfeqMBEvtcy6QSLhXS+SuK6M=
X-Google-Smtp-Source: APXvYqyPjWprOSoSrPciUO32pP6H/h0GW/3deMfpvU9NbgCKTlltaiaMhbtwjTpNs+zuOrzJb5X5og==
X-Received: by 2002:a67:bb18:: with SMTP id m24mr19029108vsn.92.1580850495027;
        Tue, 04 Feb 2020 13:08:15 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id d8sm7476340uan.13.2020.02.04.13.08.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:08:14 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id o200so5620720vke.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:08:14 -0800 (PST)
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr18378566vke.40.1580850493870;
 Tue, 04 Feb 2020 13:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-4-swboyd@chromium.org>
In-Reply-To: <20200204191206.97036-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:08:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLP4Rz9gW4hHDJRf54qFqnYJeXH259_B2Fd5ObTPZUeA@mail.gmail.com>
Message-ID: <CAD=FV=XLP4Rz9gW4hHDJRf54qFqnYJeXH259_B2Fd5ObTPZUeA@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Drop of.h include
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This driver doesn't call any DT functions like of_get_property(). Remove
> the of.h include as it isn't used.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
