Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A275165901
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 03:19:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37159 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgBTITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:19:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so2371501lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8w/ISG8KFq/Fjl3981G7oGuaDvri7xJtq4icnzIEzA=;
        b=Jfi729bGUdIJ61fCox5a+GbkxisR/QQuT47B6cHyq+g86Nph/W5xrAjZQ61yrw5Mnq
         KKxlQbEp/Wmg3NI2TgqVb0ibWDSKZZmrRW1d9eq8ZHF89JMbmBq6vipNkofRJBqvX8RX
         ovUfISec35kjOh8yE6nmbP3uu1fnbBrfyjS33Sp0qYphqdRNXnjmZxdNoDYhpWGoEEcD
         51F7mt1jXBmthLZVJ/DpGQPese09fTQ8yAuyALTjgl+eloyf2o1SAPqWVaHQl6vmozYf
         WAUwLB5AoYXTEX7LzrxgG2VcOqAAM119LUiyJYfbDt2tbC0ZEOegShWcfpD85SwudAEW
         ppYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8w/ISG8KFq/Fjl3981G7oGuaDvri7xJtq4icnzIEzA=;
        b=Nl0KLhkNP5sVPVyrx+iDr+iYhSld1Zv1IravA4Hm9TiFjtYJz5STUsnHKM0mnBxZFI
         nGPbcwa+vIMeraCieSJeEU0bnwhLYeGKn3Yn+t4CGOho/ObWahyAatagNc7qs/U619hh
         OrBrYa3oVKjNQeUic8BKV57dywgqdj3mEzGChsL3kb7bqtGPSLiy19LE7Tx8mQ3RYRql
         bzV9nQyJzD+pAVeNqyOGDdyHAoWrSxnhuyMk43UPFj0xd6jNNTQHApFtNn+djYOhQVIl
         AzC79YtOhRZArFIy6pic5R2eec1FL9HZCSgFFHqnt+dmyp4T2MfDM6QltOHPBUs3XfTl
         TRHQ==
X-Gm-Message-State: APjAAAXdl009IGccxko0tqQgcDqIG1fKQgePgvdCE/g9iFREFqK6S4tT
        MZmaFlnrBVSyhu1cY6piXayT+QcED8RP2XMhMAipkg==
X-Google-Smtp-Source: APXvYqwM4myztaWN91fnjDuBms++WacpRwVJCXlpdWUEazIxZNYjBbC6EO58B6ksaRjwN2Gnhr1XpXJC9fpdxJgP+Zk=
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr16046600lfi.77.1582186771011;
 Thu, 20 Feb 2020 00:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20200209095600.16394-1-ashish.gschavan@gmail.com>
In-Reply-To: <20200209095600.16394-1-ashish.gschavan@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 09:19:20 +0100
Message-ID: <CACRpkdbYEpcugZ5Y=opmASC1JXfojv979ykp=q8mcknOAif4sg@mail.gmail.com>
Subject: Re: [PATCH] gpio: rcar: Fix typo in comment
To:     Ashish Chavan <ashish.gschavan@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ashish.gschavn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 10:56 AM Ashish Chavan <ashish.gschavan@gmail.com> wrote:

> "Positive" is spelled incorrectly as "Postive" in
> comment fix this.
>
> Signed-off-by: Ashish Chavan <ashish.gschavan@gmail.com>

Patch applied.

Yours,
Linus Walleij
