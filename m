Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1621010C89F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK1MV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 07:21:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41276 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1MV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:21:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id m4so28256186ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXCA4P1++mZ4GjWU0WE3nsYL5FMcWa3cXbIapek2T/s=;
        b=jabLiYoVLgEE4KTwesZZ2DmLmaC34ZclwZ1kroQlBm1emD0PcHERirT/hIXKWoQFos
         FXGKTcgMut7RTmZ5gXXmVxyK4gRpeofT8e2F8s6uLfmA+TQObcbJyQh1OR+sP5z3w+vH
         iVyRWxpvtyGd0kqgtzW3CQRScRwwOudpNBwxE1TAHpVCjIzAJwfin6SsgPTMGVpotdh3
         ooylYNSUGySU9KKHhWVPly1OHawrnLauXENT78d93EllPbBwpznUq9al7WKA6Jc+w8X2
         yzAsA4EJ59JuX+Vfi82qtpXLIyN+EOD8BlzexqqEakfaRNLtDQBtKzorXhAlD3MTM1sV
         03JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXCA4P1++mZ4GjWU0WE3nsYL5FMcWa3cXbIapek2T/s=;
        b=Q3ZlUujP03gs4H/31e7atWKuw2PX0fWaYnM3ukjXcrcMPvJIE1rxEh0i6QOlcAGvlL
         Qpg1Ugq7ljlfHmA7vRMYX/JUpcfoCJkujITyWuonS0EYpgzckOM7RK5XIWiFuOKyPiZN
         W+HTRdYAn8eWQoCXqK3I9uX+kwtnbJ4UNfG5aYVccdrm/FLusp0NTh35xyOf894A9QAF
         gWdRnY8ISGhhfjZgfhlmj2/Ogg0oJtuMzG6vlhb002Ggj/kYjcWVlzLbmfRfoSS1CsEM
         +WkghAd0brPb1EtdYJH8yuHQe41t5vTyPT3eggHvpGE66rOduoz5hHozi+mOYRAVh9tO
         IAgQ==
X-Gm-Message-State: APjAAAW6DfuXOHwr72W63lON0K+/aUg76G9025MYsmt3Tjs61kxYoh25
        ctt5VXYSiDPHluhI3mykqkOCnxfDV5kUFMxpgcrXAA==
X-Google-Smtp-Source: APXvYqxC+CilfFecs694uPA2TkzfBRgLiP8clA3RZ7THF3M8WYbpWuyE8yJFEz9LrJzLIs8TgrYqaoLQgeR+Iv/pMiA=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr13384895ljm.233.1574943715334;
 Thu, 28 Nov 2019 04:21:55 -0800 (PST)
MIME-Version: 1.0
References: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
In-Reply-To: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 13:21:43 +0100
Message-ID: <CACRpkdZZc5QKqX74WbyO8WQmVw7SSm2HYYMtoxjbEWomGvnkUg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on
 fsl,spi nodes
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 1:16 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
> descriptors"), the prefered way to define chipselect GPIOs is using
> 'cs-gpios' property instead of the legacy 'gpios' property.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
