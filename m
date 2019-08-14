Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3C8D182
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfHNKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:52:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44632 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfHNKwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:52:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id k22so3066920oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFvHPaEBpVtDvsWsYTlc9ktuYlykq2Vr8qmG0BvJYjQ=;
        b=nZvbfydpf2sDd0yKC1kYDe7pbTYf0RoRnG/RwmCKjN4PumO0LUNsXhUwuGjilZjqI1
         nYaRqSAEFEqavuSSKxdcN6kkX0m9c+6ArZfhoviiE37qwBpKRFUYF1jWToMixOQkSFJA
         qjm9yWN0hOS0n1/MvltJKRhnYLeknjuIHfB2FapfoPmgfnZwA7iW8k1TPD/LjKXYhe9N
         LlJ/dFJnU5Cp3WbO2Hsls6hry/vs4ggNY6JdYejq6jRP16HM2bLhWwe+CfZ+ncYIWh/W
         aKRjnNGCAknT7MYibajbR+rmDfl110as88QeipfeOBKHgbL5EXpAQ/t1FmK+vXzStbvi
         GnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFvHPaEBpVtDvsWsYTlc9ktuYlykq2Vr8qmG0BvJYjQ=;
        b=ZJOORZUKTaIxDVjQox8IvyEGj0mheAeMTnlD58hj/kgOhvlQtoEkamHdfhqQx+iDuJ
         3ezcKeT+i9LPhaxcSBFHYK0sLX63tlBCGXNaKBb+9tA9/u+08T2YZmImxr9sP71JLRtS
         jzAKVI9GCSB8Rch9NWs7PCilEIFGF+fgm8RKiB2EDnWP0zDl3g7EjSBWcMZEnYtte+DX
         t+r9DrCFGMQqmkqgrb9gD+ujMkfw+hkO8P6MIBKFkcOKqhAfAB7BLm3nEO452+gODFdo
         2vhJGMFBO7ZWythAog4YaboytI94dM9KnX3otGEAeK3yi68HzEmRsWDnnERRL1KkDqDN
         ZXjQ==
X-Gm-Message-State: APjAAAUtP/ljqYPmJDCnCLVQElCbcJudEMTn5wybKd+fuHsguMz1guG6
        i5KhBJNex6TxfC5O3OPH0NoEbzxtD9IpyLz+nxxXIg==
X-Google-Smtp-Source: APXvYqy9mUtI5PPGciU9JdBXtN+uZK4N0zN7cuSjarKrVdkZREuIQs1m8ssHSkm+3oY9x9IO0S8JUsNE8p8fudmw790=
X-Received: by 2002:a02:a88e:: with SMTP id l14mr2649335jam.105.1565779938039;
 Wed, 14 Aug 2019 03:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190813110300.83025-1-darekm@google.com> <20190813110300.83025-5-darekm@google.com>
 <20190813112014.GE13294@shell.armlinux.org.uk>
In-Reply-To: <20190813112014.GE13294@shell.armlinux.org.uk>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Wed, 14 Aug 2019 12:52:06 +0200
Message-ID: <CALFZZQGXrQh-RnuMihfpTPxhpVohRFnrkQ0V_fJo00SAM16yTg@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] drm: tda998x: use cec_notifier_conn_(un)register
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Tue, Aug 13, 2019 at 1:20 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> This also doesn't make sense: tda998x_destroy() is the opposite of
> tda998x_create().  However, tda998x_connector_destroy() is the
> opposite of tda998x_connector_create().
>
> By moving the CEC creation code into tda998x_connector_create(), you
> are creating the possibility for the following sequence to mess up
> CEC and leak:
>
>         tda998x_create()
>         tda998x_connector_create()
>         tda998x_connector_destroy()
>         tda998x_connector_create()
>         tda998x_connector_destroy()
>         tda998x_destroy()
>
> Anything you create in tda998x_connector_create() must be cleaned up
> by tda998x_connector_destroy().
>
Thank you.

I've just sent out another revision of the patch, where registration
and deregistration is symmetric. Please take a look.

Best regards.
