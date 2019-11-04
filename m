Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21289EE1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfKDOA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfKDOA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:00:26 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E3221D71;
        Mon,  4 Nov 2019 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572876026;
        bh=OWbKtK0i0fpZ7HMq4IWDZ/zHR1wQIHsCjhclNVqI7cs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L3F9qVpuKwq2k4DJhdeBUeaZDrY5/2BO9ZEILgx1UqbvBX47zpfteH8Riw33D90lY
         FK87rhNlLQL0Nv0Ze8GAJR2IUvzOLk8xM1+a22zySFweu+8rNFlQSXWknbwA5WDoLd
         N8cMt0+CaX99DaLgV9Pq4rTimFFfmAXLCuvpqk+U=
Received: by mail-qt1-f181.google.com with SMTP id y39so24071571qty.0;
        Mon, 04 Nov 2019 06:00:26 -0800 (PST)
X-Gm-Message-State: APjAAAXyY79jdMZNLGgwAN5YLOGXvC/3iRYDS3yUZGRmo8eDNWpal/a9
        3xzmLx70uEE1aBYvsKG7EKSapHdsLAz2R7wOeA==
X-Google-Smtp-Source: APXvYqwC/UsXG1zJ1xc8CR86GG8c20fgOKNAVt0QWyGvdkTztw6vTdeoGSWn0GfCtBbRQCyxI47fJxmWk+2G9rlJau8=
X-Received: by 2002:a0c:d2b4:: with SMTP id q49mr21523114qvh.135.1572876025475;
 Mon, 04 Nov 2019 06:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20191101061411.16988-1-yamada.masahiro@socionext.com> <20191101061411.16988-2-yamada.masahiro@socionext.com>
In-Reply-To: <20191101061411.16988-2-yamada.masahiro@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Nov 2019 08:00:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJbmFd5wZ0RCP2baqv-bjWwzaJ+hLqtGeYjK5LPJ54dXA@mail.gmail.com>
Message-ID: <CAL_JsqJbmFd5wZ0RCP2baqv-bjWwzaJ+hLqtGeYjK5LPJ54dXA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libfdt: add SPDX-License-Identifier to libfdt wrappers
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 1:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> These are kernel source code even though they are just two-line wrappers.
>
> Files without explicit license information fall back to GPL-2.0-only,
> which is the project default.

That is true and these are kernel only files, but given they are just
a wrapper around the .c files, maybe they should have the same
license?

Rob
