Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52F7CCB51
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfJEQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 12:39:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38626 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfJEQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:39:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so9532570ljj.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPHHQsCm9P5lZAOoBEEQkMv+jTLHYjpWxfU2c8iJm+s=;
        b=km/R+P3zNivGmATXsVjC0pwOaNaLVsp770WNbE2ZdpnVhPJLTNALAk1pY+eMZE8pxA
         YkojbQcoOTs9kZM5JOF2Rv46YYNSaKgBPCmQW9HOvbS96RPuJAla8Sb2VPqcElrCO5UR
         2/6Sh6fMfSddcEzFcz14tMESk62O3II7RDYFrnC07gcpY0285wxcVavUiG4u/u7lIT8k
         Str8vwDdfk6qaSpKCDpAnHPxIlzLBsALXel32/ueZHebYUHkyCAb/fvINXvtN+ErP4hp
         AyA6Qc+BWhszgGMCLMW3ME4lR8pJoWEG1nEZYcfMy0G/Z1RZcXMUMIAIqKhzlESl60G8
         HHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPHHQsCm9P5lZAOoBEEQkMv+jTLHYjpWxfU2c8iJm+s=;
        b=D5qmEwQkatdiVSMeOMVgUk1jDBfvuptg4Vu3yDI2zqj/rQSF2FRyrCg5cFxcqPKjfE
         vMb90RpWYrFFxysBZnxlUoS8mXHgd2okx7PfpEKLPT9zuexradiknRvkxrNkWBEUtmET
         +K6NdqMkXEUN6uyjwklOMs0K2dy9Hba5Z2OLWaVOtoVQc3LzZDNTkzM9fWy9xZkpug8c
         TV6EJcC2CpTXreTlTcJ8HRAN6n2l1WxoSreH4HEzNaseJRTehg+EcIKl8fN0XtogVAVb
         gpiIJ0XLrd98dIJNXPYTTgEzoMunV4VaxZ/75VF1zRj00O90Uoz9t3fZNW1QQsGh15Je
         u7mA==
X-Gm-Message-State: APjAAAXtMfZcgeu2mgNKAvt9DUEE2ZHpqCCgro36+ATDkmWvsv7nHCQQ
        h5OguyOV7cD4yXbTEER+HuguHC4wWkKqoCaN7+Vc5g==
X-Google-Smtp-Source: APXvYqwgSpaaFyzXdZShSpDLB3i/tHQGn7PDveIUsSUQrgOPp7Y4zvvhnbMGw/WaUGyUixEqB0xsj3nUp2bpy3kvhqM=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr12889974ljk.152.1570293595719;
 Sat, 05 Oct 2019 09:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191004122342.22018-1-amelie.delaunay@st.com>
In-Reply-To: <20191004122342.22018-1-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 18:39:44 +0200
Message-ID: <CACRpkdbhoAp7Zif_7pbvJLoFeLdbT9u+RRgZk94cJEH+NadBmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: fix null pointer on remove
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:23 PM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> dev_get_platdata(&pdev->dev) returns a pointer on struct stmfx_pinctrl,
> not on struct stmfx (platform_set_drvdata(pdev, pctl); in probe).
> Pointer on struct stmfx is stored in driver data of pdev parent (in probe:
> struct stmfx *stmfx = dev_get_drvdata(pdev->dev.parent);).
>
> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Patch applied for fixes.

Yours,
Linus Walleij
