Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C481C15390E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBETYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 14:24:55 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41794 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgBETYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:24:54 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so2116134vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAJctpXOp7118HERLXET2DrllCvao5vObxu/nw3+/Cg=;
        b=IrCdKZxlk9MGjOVLL8nvg7LIAvfP0+eaAMZGI14LPfO2Xsvm/Oni8/zwNx3GyuHFVk
         xSLsRYvA/h9GJOGwHl3TB+be2gSu88KN9DX+j1QFvvlPQfCSgm7+m++IUH5+Awt0SV1x
         kg/476pbpukR7JOK7GsTJOiWYUwIcxVk69Ivs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAJctpXOp7118HERLXET2DrllCvao5vObxu/nw3+/Cg=;
        b=Nm2mNjhjqbr9qh3Dd3bG52ZB5JH4g/xMCKtKm6SScKMe5iDxCvQPdMGOoSaSy3xP3d
         3dVC5tpSF1+ozv6uu2uoJC/EIRn3JONCOUAyllbK0vi78S3mJ2lWUMhVdVXXZknu/H47
         H9QzHVneVF79OCEn9Oef3M0jrEFBJINJOI7H6huVrBrr7gFu/KnLhhRGEPN5OxGLprKb
         DOT2WLOkxnLdIZ3q0AjiWjlF+X8fP9Ynr11bRylijCJuXx+ZIuNwvMe7RBYxj8I0K+XW
         qWnB2gzEgZWEGYdckBy/0LOVAdsz/Ctu2EuGdgZAKsX3CDj+46yPgME78oyrXHd35tlM
         n/sw==
X-Gm-Message-State: APjAAAVnousRdcYgjdKygLjRd5m7xFz9TigyUCGMGdyUt/u+nce0cv6R
        2Cg8vIEFP97aXVUgDMSJ2CUG7J6u+Is=
X-Google-Smtp-Source: APXvYqwGhCSKUDbUo2Mwq9iw27F+ffvb5pPjLEtuhKTpXxlYM9FnxMIkNnJNs26Jq+tYKTQOuSXpnQ==
X-Received: by 2002:a05:6102:38b:: with SMTP id m11mr23218101vsq.187.1580930692940;
        Wed, 05 Feb 2020 11:24:52 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id g22sm186410uap.1.2020.02.05.11.24.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 11:24:52 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id t129so896964vkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:24:52 -0800 (PST)
X-Received: by 2002:a1f:c686:: with SMTP id w128mr2748451vkf.34.1580930691696;
 Wed, 05 Feb 2020 11:24:51 -0800 (PST)
MIME-Version: 1.0
References: <1580886097-6312-1-git-send-email-smasetty@codeaurora.org> <1580886097-6312-4-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1580886097-6312-4-git-send-email-smasetty@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Feb 2020 11:24:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ux9XjUQMy4zzaz9JxZzyuZJvNB_W9ANzE140W_pDmixA@mail.gmail.com>
Message-ID: <CAD=FV=Ux9XjUQMy4zzaz9JxZzyuZJvNB_W9ANzE140W_pDmixA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:02 PM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> +                       power-domains = <&gpucc CX_GDSC>, <&gpucc GX_GDSC>;

I should note that this is going to be a PITA to land because the
patch adding "GX_GDSC" should technically land in the "clk" tree.
Without extra work that's going to mean waiting for a full Linux
release before Bjorn and Andy can land.  It might be worth sticking
the hardcoded "1" in for now instead of "GX_GDSC".  That's what we
often do in cases like this.

-Doug
