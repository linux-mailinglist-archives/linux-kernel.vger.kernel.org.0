Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1793D4EB46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFUOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:55:51 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43063 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:55:51 -0400
Received: by mail-vk1-f194.google.com with SMTP id m193so1342856vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McASa29lxjZpj0oJ3ZfQEaOaFXbUU/UG3+m1x1GG8co=;
        b=X3xAV4NyA3y9UzA2IA/Mk+qrbdrPKZIojhR+endGbpMJCR38xtZNqJ9k22djG6EF8T
         lgeu4QQxt/tsghp0XWw3YgkSmM36uLQez2tVp4MN+NadgIHC0T2hblyRbSo9szBtCly7
         Wl/mDoc9QOORA8aKlSOXdTAQ2mVhqtKyuShPZOn9t5BGSWAGAHhGSbwIAFb5WEVoeR7E
         kP+EjwXcBAkzjawd196Z/h9+budQycSYG4WoqpHICVdO3OTu0jmpgEthvef+K46SvBJp
         k+whefb30M+1PGYlpvNw5ZQWAt4m/unHVMNLGpia4S28NYrHiRibidO0Ao1/uRPdY6o9
         rBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McASa29lxjZpj0oJ3ZfQEaOaFXbUU/UG3+m1x1GG8co=;
        b=mSqIUyPOsJZYcK/iem99k+FHrMmFHhYxmUYlO5x+Fr0CqaonCO34kAJE9wIyv0NB8r
         9GO4Wnt4nFQ5iH8An+3qgd7ACu7Mv/R7alSnKwxHDO3qNoeItNeWRqV9sWhRweiczMMM
         q77SGs6oJV/RJJxPIqHKQ250fNeiem8y7iLvaXIMo2RsHYO9Exb9Gb53901a18QDWYUs
         eymMvQKWdWCWK0LIkao1PGQ5bG6wK/4MdnQNiPPgL4ihV3fKTSiMf7123nVQtJLG4oJ5
         GSAqBcTD4c2Nou1k9zkQIMHbCGYC+UpODrXKntqJQ7NEnWvpAHsuxu1wHeH7gT0Qw/E/
         /RdQ==
X-Gm-Message-State: APjAAAVKNRUIVG/sjpGEMBMmAIrcwdFtJ27W/gNdkP/Pm3oVVZLssdzi
        OLAx2+Q8U/vpLhARTnWfFwDQPeal2LTi/SAtZ3w=
X-Google-Smtp-Source: APXvYqxCcxQEXetp+8qxWOCkYRfCFeSjQTr5ue+VK7qlD1hltuVYOFpeQY0fPGUN+r8Luu/8sd8vTD7bA2pcXXHSCQ0=
X-Received: by 2002:a1f:14c1:: with SMTP id 184mr9771787vku.69.1561128950035;
 Fri, 21 Jun 2019 07:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <1560755897-5002-1-git-send-email-yannick.fertre@st.com>
 <CACvgo50vSNCTTTKp9D_07tazOE9YkU-zKAsDywvWe6h0NgcEmQ@mail.gmail.com> <2c169739-febb-12a9-0fa1-d5da053ded67@st.com>
In-Reply-To: <2c169739-febb-12a9-0fa1-d5da053ded67@st.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 21 Jun 2019 15:53:32 +0100
Message-ID: <CACvgo52tK2Gaz7wzJ0Cw1rKsTog6PbGF4G8at=cO-oyiEZ4EUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/stm: drv: fix suspend/resume
To:     Yannick FERTRE <yannick.fertre@st.com>
Cc:     Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 at 15:01, Yannick FERTRE <yannick.fertre@st.com> wrote:
>
> Hi Emil,
>
> The msm driver tests the return value & set state to NULL if no error is
> detected.
>
> the ltdc driver tests the return value & force to suspend if an error is
> detected.
>
> It's not exactly the same.
>
D'oh I've misread that patch as pm_runtime_force_suspend() being
called when the atomic helper succeeds.

Thanks for the correction :-)
Emil
