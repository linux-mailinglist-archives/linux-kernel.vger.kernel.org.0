Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7152895FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfHTNVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:21:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46358 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfHTNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:21:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id n19so4091217lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YK/0EF3gnBKgjuIY+ib7891ltM0NoVTD8m/vCrHPrxo=;
        b=Xw2O7bfBzoVIA7uBjRF/yBzM0AX4s+fhD9m7A7xePAgPcMC5xWDuNHD+FP6DAAuoeg
         f9l7jRFTFuEpgh0UV/MD2odc27Lfvs6S7Y9NZmIL6qSt0enZjTAYoNla+Cc2SquAV6Gv
         qfeDs2eyeS+ah/jxCPXKYUHLIC7htmZzkRWIQB0OFE9sDvmMpRO1jOaH2zI1UjQeQFsU
         kyUV+BPQ//NrjTXWbuDtXaQ5wF9XQFzs7MlRXVwXgiG+wW01WSCjJnxnz3ppb0iG9pVZ
         bQovq3BQw/pK9eokOOnqRxxWZhyBmzDnjraJks80nLa1+IStdZCPGGVLOTgh2XfmkCm6
         SPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK/0EF3gnBKgjuIY+ib7891ltM0NoVTD8m/vCrHPrxo=;
        b=cror3LroiL8OFCbMJn0KanfME120UtytkIKC6rxH7GKL1C+a7J9UNm4lbK8gVVg2LY
         KDP3rieuN/Sj/Fq/5kvy5N61r7EAXwcM7cwzoj6Cu4JZ6FQIN7pkz56q5OcwdqhxO0qr
         BnMTEaLkl2rLBxV/aElGTESv441DMvMeXPsA30goFNHVVana3XBbyHXrcMZy+Ng7pbZK
         /XJODBpEmm4PlhrCHKpzUJYWUMPcGJEa5i67XKeyU+M8vO7mM/+DiQtyWDFnknjJxoQp
         hag4irB74/jaxlFmwtJiD8Oeif5WlE5HrFyGfuC6wHnF/Yn+DTOVDGXQNiBdwLavRJIs
         kSnA==
X-Gm-Message-State: APjAAAULiramR3qOkFGHXnN+34lAnx+xC1CULVjiDMf6aFm08TdbxwP4
        UBC4vnEW19B1hW0bpv+E0uJTnc0hiIocS1G+C2Rtn5zNucM=
X-Google-Smtp-Source: APXvYqwuY7Mwr36cEssEQwVCrvZ1pHs1jPtuHvPtqLhdRMG6LujyXVk8yUaiIMfQkBORVc3Kb+TBpHvENpfFd/iqASA=
X-Received: by 2002:ac2:5939:: with SMTP id v25mr15606434lfi.115.1566307258940;
 Tue, 20 Aug 2019 06:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <1566304548-19972-1-git-send-email-info@metux.net> <1566304548-19972-8-git-send-email-info@metux.net>
In-Reply-To: <1566304548-19972-8-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Aug 2019 15:20:47 +0200
Message-ID: <CACRpkdazbH5pD6eqhM_PWyK1wcjrKzxY24AwEk-TmzpFtmnxqA@mail.gmail.com>
Subject: Re: [PATCH 8/9] drivers: ata: sata_gemini: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 2:35 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
