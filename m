Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03A05674F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFZK7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 06:59:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37058 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:59:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so1720265ljf.4;
        Wed, 26 Jun 2019 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fv9xgHLhDYmnhdRlJ12b6ZaV6F7rsmVKSKGlSFypmB0=;
        b=AW93f0+wWO8xHqfQfeq02+uVvagQqg6g2aSwBswZ1jGXrtgSYEwDc4vrVjHnuHlusy
         9ITI9WY6oemJDG13jGFQ8JytMx1Wa6+NtkgUnCFPVstLuqJRoQ0O5fdaD95S064TV+OU
         xsm1LPYvsy/e1ujhFxUSIEw4YlJCcYUSYVeKqUYv0gNJB9Gl5AKBknpE1JbXhUssFjW6
         NRRBN/FDvEPV6ZTQ+caKanSaEFRg4K5nDzMdsWRdhr2kRNxzkH8HjaMxPX8WcNvtMlHe
         qIkm6FpIuodkpacPFmqbfYd/KNpwm/U8iwvnw05/9R5sDtmghJT31ZCCBLXkKrdiz8So
         FBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fv9xgHLhDYmnhdRlJ12b6ZaV6F7rsmVKSKGlSFypmB0=;
        b=WsVfXgivSu+nH93Hnpb01QKOR/mHShnBzU0Uv32QGdaNnzlJTg8E1nI/74ieOHQbLD
         gJHvI3FiS8S2KzkxWZy4v8nmVadmT7kYcD7YH3j96c3peM1el+HghYXuzdpoiXeYtUxD
         BfKlWMUg8Ahlip4rHoTMHyx/cbyVIoVOe+00hvg5N70QZIQ9jQnWUStwDlN7ZXX78TRN
         U+EFkD1Idie3gN6QJmRrsWJCxHUxT0MWorGWo04Y4w0x0nOi/wyenrAvMp9oBK7srQEl
         hD6wGJJhauCK9D20G4weAX5iGQ4zoXUSvy5wX8X5rGGNHaoOjht0zDx4ov3KfNegcMpF
         gQ5w==
X-Gm-Message-State: APjAAAXxsTDYILH0kcFLky2pPvrxOWjzpmmXUBcq3rD0Aetgn/SHZ430
        fyl7+XszHFUNtL504coi1ywYYAgIeLuZN4WbNLY=
X-Google-Smtp-Source: APXvYqyaajySBdajl3vqXKwz2VD2Lk2DSCmiP3YMTp9EcxBO9jpD7CRAiLKwQLplLJ3nVmvjUP4aURNpERdDUfw/E+8=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr2525177ljc.240.1561546784065;
 Wed, 26 Jun 2019 03:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <1561544420-15572-1-git-send-email-robert.chiras@nxp.com> <1561544420-15572-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1561544420-15572-3-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Jun 2019 07:59:34 -0300
Message-ID: <CAOMZO5CFSXHe7bFQ1xudmnm2=9sUL-FRqtzOtf_c=f7=e=bdqg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/panel: Add support for Raydium RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Wed, Jun 26, 2019 at 7:21 AM Robert Chiras <robert.chiras@nxp.com> wrote:
>
> This patch adds Raydium RM67191 TFT LCD panel driver (MIPI-DSI
> protocol).
>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Looks good to me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
