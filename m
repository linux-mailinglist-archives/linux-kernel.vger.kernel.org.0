Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4076894AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfHSQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 12:48:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:48:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id a30so1888593lfk.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5r3XqVK7uUsQV/llWAsJ+lLwxWZKYui1ernh/kc6CgI=;
        b=JxFov87LYvfBlgQIn7fHkeQlQaDh0lzTxae+saZVrzNE97zcgm2CNKSKxvMmFVaNSF
         /SSw8tj2LvjSGnCtn2btJubah9nsoxe66JrRDDFL1bWAY1vCPj1AXtQFzbKbYRLikM/V
         o8N9I1ATwyFd39Ut+oPs/x5LHd5U2q4kiDMySqv5NrMgkN7P5IR5X30ylKR21Yc7cwpY
         0nBHcXM4di24iig03wPqbQZEjHu5VW9k0fFEZcOkws580lCF+mgUWKpsX6t0Y5uPXVQv
         89PdH6xhEr1354GVLfFsksg7gFFnRNmbEOv173Dor06GVW/YPTC4nTxqfa+1TRgwTja1
         qi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5r3XqVK7uUsQV/llWAsJ+lLwxWZKYui1ernh/kc6CgI=;
        b=jX2J85A5LeK164pMCBjKqu9vdhN2a6KsZpJ7LZ2ehOuIhSHw44QLDAE2QgHr6yaikN
         Qtvk6BtW9UX0xpQIW/Ge8zYwF7bgqR52aUyxMayogfN5iPlRb/pZYYN8t5UUTtFfZ542
         Kr7iiq5zBcO6D5AJ4sokh8COFwJa1KicH0egAxP4DJqqVCcYfhBQhuvPDe8fkd/3WS1t
         O0nvaJ17KzoJyIpZlUgtAGf0qHlh0sBikskotAriGvbYU9kcwDOKTSF8yDOSQ8COL07P
         QpNM9igwzZGjzjRBLUHie2fkfDZBBWw4TTUc3y0quTJWaMr2Bj8zlOvU/50S4M870S11
         12Ug==
X-Gm-Message-State: APjAAAXdxQIn82IRWVAwrMAP592Dw/R6qhcUKmwpHK23IlHAEJdSWUgJ
        EGzmc1Vzr2QRg9vafmsic6HXvHKN2LOb/Ts1xxo=
X-Google-Smtp-Source: APXvYqwozb3tJz+7egOm8fZB90SYJi5AZwcOxYs0BlJb4HwHmZstGQTqGK6SiS6n5Wq2ZytkUZVDUPJ82xPHPzpVdk4=
X-Received: by 2002:ac2:5a1c:: with SMTP id q28mr13521904lfn.131.1566233295354;
 Mon, 19 Aug 2019 09:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190819075126.870-1-nishkadg.linux@gmail.com>
In-Reply-To: <20190819075126.870-1-nishkadg.linux@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 19 Aug 2019 18:48:03 +0200
Message-ID: <CANiq72m5LsZKY-WU+63Rt9EfXW51SN-QGXg17AciounFQdsAPw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: Make ht16k33_fb_fix and
 ht16k33_fb_var constant
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 9:51 AM Nishka Dasgupta
<nishkadg.linux@gmail.com> wrote:
>
> The static structures ht16k33_fb_fix and ht16k33_fb_var, of types
> fb_fix_screeninfo and fb_var_screeninfo respectively, are not used
> except to be copied into other variables. Hence make both of them
> constant to prevent unintended modification.
> Issue found with
> Coccinelle.

Thanks Nishka, picking it up.

Cheers,
Miguel
