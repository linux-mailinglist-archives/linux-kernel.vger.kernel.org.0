Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8CD76D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfJOMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 08:48:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37685 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfJOMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:48:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so19026905qkd.4;
        Tue, 15 Oct 2019 05:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LnCAgtzSVxjK8NjcXy6tgIzMWWpUK6SaYtzp2QjSDM=;
        b=nZq3Zum0QEm1jjAcBlHv79DmGxf+oCa3/809b+qlYBtVr1d1hO3CtDySrU+AMiMmB+
         Ec5VjBcZhYsOBxip875W5gNoyjoQT6o4v+EUmrLPeREVvhIi3HWsD1chcgoToR2eN0Ow
         reLCpYcKXD7NLMkESjxwAnp2e58pzJv5ekRlyFz+bjNab7uXYREqRqGJgWdTPF/DHJH1
         AAn+uo8dXYwBTE8vbQKcfd+yMMO3IGs5Esoc5IcT4hqdR4ZztFWfCTV6GyD0aPL7eQ9K
         zB/ZhwDNvD2I2pL9O1LR800CaQIKSyFSmX4oPAKObxnOcOXzV9XuzRkY9YytpFwRoSL0
         A0+g==
X-Gm-Message-State: APjAAAV5DutuqaHRWOp+Xsd0njw18Z5pgsSH+MBVIFQl8aq5LUZ1Hl+Y
        7CSg0yN0/sHtr//Ebv17Yf9I7YT8z1jkoG/55W0=
X-Google-Smtp-Source: APXvYqxvczERSc/QdTVw6XtrArG/ved1ElaY1gnQxojDC7n+dRbqekh+y6GhSVolCfEI9PxFVG0gsLhVmsIVP35SbWM=
X-Received: by 2002:a37:9442:: with SMTP id w63mr34470183qkd.138.1571143721176;
 Tue, 15 Oct 2019 05:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191015122754.14721-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191015122754.14721-1-ben.dooks@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Oct 2019 14:48:25 +0200
Message-ID: <CAK8P3a3CEcAJnTk7ThYcM6Adm09Xvue9-C3jw4ph2fGeOvpu1A@mail.gmail.com>
Subject: Re: [PATCH] hwrng: omap3-rom fix pointer warning for omap3_rom_rng_idle
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 2:27 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The omap3_rom_rng_idle function takes a pointer, so give
> it a pointer instead of a plain 0. This fixes the following
> sparse warning:
>
> drivers/char/hw_random/omap3-rom-rng.c:115:28: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
