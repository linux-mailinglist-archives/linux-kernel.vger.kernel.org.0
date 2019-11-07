Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A61F28A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 09:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKGIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 03:03:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41635 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:03:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id m9so1151721ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kmm/jBUyOVxQYEej8YoVC+NyodK4z5S7O58CZiY/vk4=;
        b=lcxWbUY56TCq5OVhHvHP0fLd9Bnxpoto8fgVFrKDJpIxr3G9KHi3Pmy9oszlcNSXgo
         t0YI2eSOCjOw6F3uNrPqnjVh7GN0eObzxtVPJZ31uKAuEK4RSUr85mIiDCZShGmKUDoQ
         qTjbiNZTTyc8uZcFINlQ3Dx0xm0q4a4QMRb6gqBNz2VuiTME2L0TZn7aQ58d5uu1erAM
         0xqVnN+znJy+EtBmwpxPP1CX03jiq0cpQZOvZqK9/405oBUdMUiFLMEAQiEPpw6NhHLS
         NDHWrFBkfMw0NM5OGZdXgM+UKFRCGLrT0xv8SgtAXkwa8q382pidcHyxyCZiyfIfv+jQ
         A8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kmm/jBUyOVxQYEej8YoVC+NyodK4z5S7O58CZiY/vk4=;
        b=ubyRRwRher4E1s8DFd2MwRXRAbXe5fA7LJW0qWzBFn6sdxqgg388XH7pno6/f8f54D
         MW8NbmTFalos5ezuaEiieTs8Hk59EEFljoPGjckmFgHxapdOonJxK5oLJRPIMxB1UxJB
         Vpjd1CADsYuV2vQHeh0w726HrWSYNxA2fgWNU+TMDLIEyHsfThItyFjpeE8B9rfF42N5
         6r6t16RXYJIPRJfX2KlTRv8FO9kG/nZemOB5rRMpKGjWGArIyx61h2cYySVSZ3LZRY8m
         L+5671BhaYW2xOA0z58Ny8Z0zsGqEu6IhM3OckVGJlmPTuNmC/HVlYaCojK2C2Ee/M8z
         5TLg==
X-Gm-Message-State: APjAAAVrBL6KixfNAmzOWdZuIhj6utUYmFsPYhby/WAvQQzJLZjbcG2j
        0XCLQKDpFQtb+xxtunliT1ahjyIHeeEIM5bgAYJHAg==
X-Google-Smtp-Source: APXvYqwZVpbtOHL92iEyTM3EmkgPSjCx2Af+TdzU1057vZFBlyDBU0Xbub/hP3q/v8XmhDxndZmJPv23+9MTzdzI/9U=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr1318382lji.77.1573113786425;
 Thu, 07 Nov 2019 00:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20191106173125.14496-1-stephan@gerhold.net> <20191106173125.14496-2-stephan@gerhold.net>
In-Reply-To: <20191106173125.14496-2-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 09:02:55 +0100
Message-ID: <CACRpkdZKRc1NLiWe9EnNxbFK8i4gNZ92oqtoGar-Pb3SCr6DGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 6:33 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Those regulators are not actually supported by the AB8500 regulator
> driver. There is no ab8500_regulator_info for them and no entry in
> ab8505_regulator_match.
>
> As such, they cannot be registered successfully, and looking them
> up in ab8505_regulator_match causes an out-of-bounds array read.
>
> Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
