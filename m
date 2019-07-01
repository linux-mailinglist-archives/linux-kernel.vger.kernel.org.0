Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548B539501
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfFGS4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:56:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34741 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbfFGS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:56:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id c26so4429778edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=pLHqHIiNEMpqBsq1VQWJdA+f/ogiGuALrvYvfOsre5w=;
        b=JKBmHUupUT1En6Wm/PaAfDvWLs9G4reHIL/Dq7a28RXjQhW1bvj1OuB26Otd3Nzv/F
         5ZMid02V6ON7krE7muBA6YEhkfXI5N+61Qho5iv95IBFh/MlqvIhkuqMpLLIh4Gx1vis
         dD6p2HlT0owEbyLmy2rgkQ9McTJKn+DOb7v3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=pLHqHIiNEMpqBsq1VQWJdA+f/ogiGuALrvYvfOsre5w=;
        b=FqcCShX+xF9qxAwnroakJ//oYYC3pJ5+nAHFXkW6fUvrOzH6Y0W0JQGdukzZJf0HV7
         CLHE026S+7o5babuehKvaD96zDzBi0AaAuBDU3pw+U9tsZUENXQmiqPgMjNC9CZk/AfO
         x+sPr4uW7yH9TtoXm5/nwnIWXg+0g5aQV2fBNnxjB8PuKPY1Tu2ZirNxPq0cajB6/0Tr
         rRhu4GohQShz5LzqL8zfw06r/IsjER/o6CVXzfvuTIlEQ43+V/TMs+2TS8lfM6JFzIMx
         UiOUuzzBg0l0gPCfdIfTrikDtcBtbe6zrkx70C/aBN9VaIfMvqpLoIC+TJzdmEADwx1b
         auhw==
X-Gm-Message-State: APjAAAV6ntjJzNpMxzWeNEb1RGWWomy1XsQXzCgitcPa6/m2SvMye2QO
        f+xkdztXIkNbxuTPcS6ZPGfXJw==
X-Google-Smtp-Source: APXvYqy/QInNnOY8qOmxzPqvg5vvvunnvhTKvbvtqEaMLJvI0LfXEgZqTasv/6lBtFt2xGxRunVBpA==
X-Received: by 2002:a17:906:4ada:: with SMTP id u26mr28479238ejt.258.1559933807813;
        Fri, 07 Jun 2019 11:56:47 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id f9sm501183ejt.18.2019.06.07.11.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 11:56:47 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        "linux-wireless" <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        "brcm80211-dev-list" <brcm80211-dev-list@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 07 Jun 2019 20:56:43 +0200
Message-ID: <16b334cd9f8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAD=FV=XVmCYWe9rtTFakq8yu67R-97EPyAHWck+o3dRXzHCchQ@mail.gmail.com>
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-4-dianders@chromium.org>
 <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
 <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com>
 <16b305a7110.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <ff0e7b7a-6a58-8bec-b182-944a8b64236d@intel.com>
 <16b3223dea0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAD=FV=XVmCYWe9rtTFakq8yu67R-97EPyAHWck+o3dRXzHCchQ@mail.gmail.com>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around commands expected to fail
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 7, 2019 8:06:30 PM Doug Anderson <dianders@chromium.org> wrote:

> Hi,
>
> On Fri, Jun 7, 2019 at 6:32 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> Right. I know it supports initial tuning, but I'm not sure about subsequent
>> retuning initiated by the host controller.
>
> My evidence says that it supports subsequent tuning.  In fact, without
> this series my logs would be filled with:
>
>   dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to XYZ
>
> ...where the phase varied by a few degrees each time.  AKA: it was
> retuning over and over again and getting sane results which implies
> that the tuning was working just fine.

Ok. Thanks for confirming this.

Regards,
Arend


