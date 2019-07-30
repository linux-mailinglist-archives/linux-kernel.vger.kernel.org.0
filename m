Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE73F7B1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfG3SaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:30:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42253 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfG3SaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:30:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so64005446qtm.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nptb7S/JW3GQk2GCnWj5ZTnDV1Bl/f6jkOieeFfqYcE=;
        b=fsKZDRXCD59lDTZrznlkMK5X2mKaCmbdQL4F7XeyOUpJ5g3/6nmCA7rGFh2I0ADUUj
         TQW3EDuoMStndZvQgkcN+RPE6J6YOwI/rVN7AHOUp87TshyPfkfal/OjlSvqppHNVbFk
         1PJcAxIaxhdZ1BVpshSaCpC2NOzL0HFq9NbQPHuIV8mvRwc2sfppOQlNze89yV1SSVjJ
         /5UfUtr4U41G2Kr0pDqn+5f3tgZ0ZKZkZPzFH9l+qMLpUUNuru63S2SRZog93UlFGkHv
         c6cR7ycHwCk47w124Ug78sKILvJrDJi7cBdt/B/N54tGYC63byQz6+7BFcx1IGvYJJcD
         5ACA==
X-Gm-Message-State: APjAAAW//Ij1dmxJCgsnq6iYXIGDs3AjdV9vj/hEowoUtjjIQ5b3jAVb
        C8bGX5CUHbQ4UIFIr7FT3G/RrkKyN8kVyPGb7Vw=
X-Google-Smtp-Source: APXvYqzxcA0OUdqus26Yj2D5Aai7ELmOMRWeTcgLDvkEuspiQiHavG0iduECmGbX5SOd+GvJrQPybS2I7b1+m+zOL7s=
X-Received: by 2002:aed:3363:: with SMTP id u90mr82306305qtd.7.1564511401605;
 Tue, 30 Jul 2019 11:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-29-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-29-swboyd@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 20:29:45 +0200
Message-ID: <CAK8P3a3Zi=GMvV3=QYBDza4--CV9J_-qNCTBXthCm__-b52Beg@mail.gmail.com>
Subject: Re: [PATCH v6 28/57] pcie-gadget-spear: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 8:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees

The patch looks coorrect

Acked-by: Arnd Bergmann <arnd@arndb.de>

I wonder if we should just remove that driver though, it's been marked
as 'depends on BROKEN' since 2013, and it has never been possible
to compile it.

      Arnd
