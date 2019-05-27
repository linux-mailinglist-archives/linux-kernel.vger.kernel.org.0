Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B862B9DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfE0SHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 14:07:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32828 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:07:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id q186so12447153oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pgdAS9QmA+kymmNkQFCc70wQxZNKe+LAPHfdbYWWNfs=;
        b=LRJKerM3ylh4upd88+hgx1+BFJPM60FoiVq2gFGCKir4JVIqcEhMr+1Vv9o70obLmy
         6U0VbGoOKZadBoCid7j1cGTaS1D5sCGgZ2ekaEl3cJe7gzpwgIR7/Yh8VgJTREckWiH+
         Ct7i1tT6ISTxEbPGd0gZvd0kEXTbA0zK0tX1CMi3QwKTwsYcfYi6e9/sT81UXpfBF3yg
         g36U+vmt5d5jNr001ndEmF+/RMHx8uq/SmJJPewd6q/xoDpGCI2ApqRcl9a0w7uv7bKe
         Zq8OQOlwTMzeC0SaVl37zMMKWDCNpJxVBb4w+n53L3jtiJmeBsXt4bnDxxho/EyPfJhI
         vXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pgdAS9QmA+kymmNkQFCc70wQxZNKe+LAPHfdbYWWNfs=;
        b=Cr1YO4rIQbzIR4Ip2QqR5GJ9cFkSvZC7MX3pG2U0p4iuf9/vF9vGC7hLl39MYvEjH+
         CeL8sxqN5WLSBW1R0s+yJlxDADdkkxEYS+ClYxltEmmpOPYzS/jctVUDlHeN1hcA7CxN
         BzFZJt7GETJhqMdKMuVLoEwhypHGXQZA4TAumcHvCCg8WBAbgSh8ShRQpRULKXfFxlyf
         On+8B/eF4Yb7HbysgwGUih7LgPH8H0bnRfJBkeqRM+cWQo3TwiyQPyH49B4pQmwWxzvh
         6z6SiZuEc8PwuUmtQHSja+M3yZ0meuK5nC7fGDzkSjFUaTxOKZnTBx7dOKBDYfzFTMwm
         Qrmg==
X-Gm-Message-State: APjAAAXXqcL/mR9bWnrLpfeLS0w6ts53nE+mtk5J0Za8CH3rY8M+6ai4
        CCyBfOVdNQTJ7ZdAVfJtajo3y1PiJM72CbjG5c9fUBl1NUU=
X-Google-Smtp-Source: APXvYqyMXmtKIOU8ak7fRZzZtZnF43sZq/2nZIX4JJ6CVMqDmDlUS02YstvGsdCcG9uauJFg2OOUfWiobF2qL+dlXlA=
X-Received: by 2002:aca:ab04:: with SMTP id u4mr141664oie.15.1558980432356;
 Mon, 27 May 2019 11:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-6-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:07:01 +0200
Message-ID: <CAFBinCAsf4riNYLtJQeqTCZKwomrwfNYG1puTiJq-6VRK4Z_AQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] ARM: dts: meson8: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:40 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
