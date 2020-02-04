Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729F91521DA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 22:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgBDVTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 16:19:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45990 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbgBDVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:19:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id 59so16240uap.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDQhf3pngJwbR1rzpvQJkKUBb4tiCCEEJ4Q4M59w1tI=;
        b=M0ctaJidym4w3v7F3eWRuV5lKNaGvr7QcuL8CyBluGLOCIRUMJ+MyNiUbAv2YFH6dR
         z+UgAPYCogS/3dgL2A0nO8wJo5dwiG7JsrrJLEeymRo8PxvngwNow3za7KlB7LdOFatn
         q9/Zt7Y8c0MKbEf9RjOKPOEsWMHoz/k431xxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDQhf3pngJwbR1rzpvQJkKUBb4tiCCEEJ4Q4M59w1tI=;
        b=cM6hiuZyeTyWZcWsOohhKFE1zjVAmNQ/4v1PpkLMSy/yZ8Y/An750jgr2CYZCWMatT
         qZedhcJOjItTa2TodMUSS2gyEZweghDXN6SADEhgcz7Q+z8JAt60zib3BbvONxTp31DF
         c2ReIBRmRoclWEKgn9+XKuSW12NtR2JY4T9rvXh+w1bbefsKgnwUQU9+18RD0BXMBQT8
         b8BhoxSkzjv4r2NxiWWLfKVTkp0ZJhhgeYwRJ3FDjXyRTjvlea69MWrfDrTZRx3ese+D
         yBkvDuAWcZKAuzIY0ZFaIbgI+bhe51OtImZHQPXkRn3eVJZMqJ7bzxTpyoRR/ztKRhIP
         Qm/w==
X-Gm-Message-State: APjAAAXhIvoOCGS0uITZfscNTw7/sRDZhE9KJapbOx2chac/ozk9VWHy
        ljR7rteReqheJi7z8W9k+lW8qmpSzVM=
X-Google-Smtp-Source: APXvYqzvEOzCJu+9r+tYa5hItDnlKrrglToO4lNkQM1X85PSUPdVpxmwKGg7zViYBvglY7zpsmaH/g==
X-Received: by 2002:ab0:724c:: with SMTP id d12mr19245748uap.0.1580851144846;
        Tue, 04 Feb 2020 13:19:04 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id h139sm7693213vke.34.2020.02.04.13.19.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:19:04 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id b79so12422137vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:19:04 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr21048875vsd.106.1580851143693;
 Tue, 04 Feb 2020 13:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-4-swboyd@chromium.org>
In-Reply-To: <20200204193152.124980-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:18:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XynUY1++OqZMMWVQq0FJCxPUBp0umeDOxs4W8WH6bNQw@mail.gmail.com>
Message-ID: <CAD=FV=XynUY1++OqZMMWVQq0FJCxPUBp0umeDOxs4W8WH6bNQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: qcom-geni: Drop of_platform.h include
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This driver doesn't call any DT platform functions like of_platform_*().
> Remove the include as it isn't used.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
