Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7843D19A149
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgCaVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:51:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33657 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbgCaVvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:51:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id 22so23781036otf.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHaIHwn4ktvTsWAk+mCwI8K6XYVuOK/Unf5nY2XCo/4=;
        b=s/TzubDxmZG/l1J2n9izahq+BEbY0Xs14zyoIv+FOS++dnQtjVEcXkV1e2ytz7P2/8
         shqkU4c0wt/fLYhCEVH2SP4CkZODzVnm5gzeYwF765NK6Z1/DzwnEu0hHngbBqwH9pQf
         dBjCQK7j5RwCtq0DvO3k6Yf2t2AbuhIIn7mvER3JeqBbfaJ4CtF7R4ji4ilcqrR7lwLl
         9pgkPF+ncMqE4YrRPV4MG8Kcdhg2gLbm8JAfiu9eMLiPlfM6Qp3Osy6etDFI6UBu5dEN
         T8Ws2bNqFD87n8q/9n1Zja2uPhO0wmmcSxhWTb+qiI+ALumMUl/OYhc3ifsKFpSxIY+5
         eqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHaIHwn4ktvTsWAk+mCwI8K6XYVuOK/Unf5nY2XCo/4=;
        b=fOlQCK171jnVGKN9jaV8QLjd8cCqZM4n8e4UAh3puCcaehBuhVKsIl8URW4deJlNzw
         y1DWFtt7TJ7OC7Q4yhNvKNZwnfrLFbZLXJ77QuYLtjf4S+ZL7zlp472F54axJLTPU50c
         Tiu1ubwWRrdyozx+PNA5UEf1ghS7X6idslF4FwkdSJ8xnXClRXPHONnNlXvcNrzSLhqx
         ibN2/Z2TbtfNe896qvKAxSjjH/hifc0aWiQo0ZBLq/BAkdxYLAxq6QnUMK6AfyK+r3Bh
         s66e6why1t/goo+S6nPO2bGzWBOv4x9REy3EVaSUE4joIeGlPdpfAOICSRC4JqwSeyJq
         IUZQ==
X-Gm-Message-State: ANhLgQ1/HXar9yFHcRghgOvmd7sH2Y/M/dGTAKHs1Amz/fH5/dwh4bAm
        Ph1YQ58fmY9G0IKYtMa455kKC+3mbFpBVFen0zCS9g==
X-Google-Smtp-Source: ADFU+vs9sP8dvHcgnPyScUhAlgar0A2TOtOCGPMBEQEu/98+Ch2n1HoMb5Zmg5epVur44Wo4OSJKTyGzC9kwm5Tqeds=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr13906988ota.221.1585691459553;
 Tue, 31 Mar 2020 14:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
In-Reply-To: <20200331214045.2957710-1-thierry.reding@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 31 Mar 2020 14:50:47 -0700
Message-ID: <CALAqxLXD78StqLMuaGqHqhSfS9L2FBfNCm6yDyWMZT_7iNX-wQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource: Add debugfs support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 2:40 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Add a top-level "clocksource" directory to debugfs. For each clocksource
> registered with the system, a subdirectory will be added with attributes
> that can be queried to obtain information about the clocksource.
>

Curious, what's the need/planned use for this?  I know in the past
folks have tried to get timekeeping internals exported to userland so
they could create their own parallel userland timekeeping system,
which I worry is a poor idea.

thanks
-john
