Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C5199FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgCaUJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:09:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36168 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCaUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:09:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id u15so9335911lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKaVv0QFSusV0PkUpSiPeLn+wqflJBF9dNYt1NXd3nY=;
        b=WACU5+XjMDtXULxTZI3cQPuNE+UvZXD8jd+XmnQ+Z1j1qBAFpD08j907T6I93wlOu9
         FdwYTqPCZO/3qM4C56Ij44YCy9lrAAQixPcCOB8F7VDaIaWsKVu9j9krN7Je02jfVelw
         /hc8J8WE+WUNGdP21CUYXpBnrg93J7rknINiv70BfJ6lonUHnUgJnN2eAB9YFXB5pnHU
         ekNYjURgy7vTk0T2B0+ShX6hgTWP2+1x8znblb/AwsjCEkLLxFJxyuNVKWq/tbg1V5Eo
         8jp9ImM6AnhtL+YJf2frQ6lYAjkkV2i+dvWZmTQPH7e1xHlpe7xsdTZ7krbQCkxycOdc
         ZG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKaVv0QFSusV0PkUpSiPeLn+wqflJBF9dNYt1NXd3nY=;
        b=tRnyEOxRSF/Zs+ZOQ3Ftbx7IOkTtNTuPoqhwraC04b7im9/dOVzSxcerVfY5FJ1DWG
         iyjxLJQM4X+XIqKMjTqBLB85N6GJ6POI54xs4gyiHxAPbBwf5z60DjQRObbLYf1VEHSg
         XKj38Gj/z1jZljQpcJ1QLlQ1ZjBB8n55rN3/Y9jQNKBCEXecqGNYCteOAz3pCOJ34IRR
         AlsB2vwklWG3Jwk5eKy45zBn58lbzaaJDiqN7tJgwFwF+PL8VnaAjLk1sDv/WqfmS0sb
         cht1KBsB5JSMWPY4FHmAYdJoLOoJ0JJPnZ/NsmwaiqsHnaciHl1BQa7/+1J21cRmT11J
         Ojfw==
X-Gm-Message-State: AGi0PuY9hinTbE8mN1XR05SrIGC1I5UMLbMHQGlbSMd29kJ4uM2CCf6d
        eW/jZsyenlXuAj9cMBbsq/kTpxSOeO1DRUN9tnJz2A==
X-Google-Smtp-Source: APiQypJGFFBCketP8L6snf0eVRiknRW2dOs8vCGK+VPhA8ByP6xKDxjeuS3UpUpWzZd2d3D79cVxY5Pop7HT8WIZHbQ=
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr12659030lfp.21.1585685370750;
 Tue, 31 Mar 2020 13:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200330095801.2421589-1-thierry.reding@gmail.com>
In-Reply-To: <20200330095801.2421589-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Mar 2020 22:09:19 +0200
Message-ID: <CACRpkdYEHMCkQpU5f6kxS8caz9QovrHfi8u_iq3ns21v1p7L2A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Define of_pinctrl_get() dummy for !PINCTRL
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:58 AM Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Currently, the of_pinctrl_get() dummy is only defined for !OF, which can
> still cause build failures on configurations with OF enabled but PINCTRL
> disabled. Make sure to define the dummy if either OF or PINCTRL are not
> enabled.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

Yours,
Linus Walleij
