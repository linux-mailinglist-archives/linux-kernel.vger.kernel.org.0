Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56F470D58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 01:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfGVXbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 19:31:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34854 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:31:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so41134217wrm.2;
        Mon, 22 Jul 2019 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pckXufXtw0kEazMS+bGnT6pn8YMKIkmXZvji3FZwKI=;
        b=BVj/vIzFCXhHQsHdw+x5dzSlgA4ZxwmyAkvfAMgqr38V0svYnGaMpua1Iki0retPCe
         V03mkHO2XEHIOi/1xm0eTKCgh/C5x405zZnf1NUKb7uyQGZUnaB4pkOIhcRsn9zMpznT
         HmZd0I07zJk9EaQ00b+OYCtsTv/Q7gZ/20caX/Q7zK+8wZD5GV58bxO2pQQqE6sMcNo1
         51K2NWGRzb952czsXat2FNenutkFEvDmcPr3QxSUW3vKxLqFgoenLSWOaY7hpg3WQivW
         Z7AmX3nAWbvRO0v9njXhje1BHSuIh7TwXWSpAslILH7gcYHvvQ1AyJwhFYWQGschK5Om
         b3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pckXufXtw0kEazMS+bGnT6pn8YMKIkmXZvji3FZwKI=;
        b=JGVuzhzzTl5e4yd1qhHAAEVVztXWt8+FfImv9cQ+MiMFAwFXVC26Wd8K+RxyRoMATU
         dNF4OVxcqHZYJf/nhNMz0PH3Tcuu9JOT0WhU59vIdEp7Lyd40xYAC3CivUKlblmbtGkL
         m/Q+uFSD+E5e+ieK1+7SN04Y16HgEw77B4kzZS7MOdjG4ykKPOc+j7vdcDxQMjkmwSWa
         D7z/0EmRfvi9dWERB6KBYFAm89SNDJqf52Z3f20WSEmZJtzQgkcG09DMJeFkUJ0nRmIr
         R1JLH3ivNTBRXv9d5OxD9QtBI+llPJJihp1GvPThiPLemFFITeD447cNfQPegnq5JAiD
         I7dg==
X-Gm-Message-State: APjAAAX1/s779oJK9/vUhuyZJzTxln4EiAHyw1iIEEHlIuRBOnMKsj3y
        KF2LTEvNuj+HMqewlnoCHgyJ7s4pOXWgORvWmm/9HM8UOHzGyg==
X-Google-Smtp-Source: APXvYqxM/GBlgX6OTyzevsXE7dFJwn4lj7A/bNiWYqzKr41NnDKrdCa07ll9L3weUPbzsJP4k1Q+SOXFzNjSo1YRAx4=
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr25780575wrt.124.1563838298016;
 Mon, 22 Jul 2019 16:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190723082253.33b55afe@canb.auug.org.au>
In-Reply-To: <20190723082253.33b55afe@canb.auug.org.au>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Tue, 23 Jul 2019 01:31:27 +0200
Message-ID: <CAEQFVGbuMKoE8uXkMjCAkey-H+tf_bjGqfRTnhweDvjgsRwL4A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the char-misc.current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:23 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the char-misc.current tree, today's linux-next build
> (arm multi_v7_defconfig) produced this warning:
>
> In file included from drivers/base/firmware_loader/main.c:41:
> drivers/base/firmware_loader/firmware.h:145:12: warning: 'fw_map_paged_buf' defined but not used [-Wunused-function]
>  static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
>             ^~~~~~~~~~~~~~~~
> drivers/base/firmware_loader/firmware.h:144:12: warning: 'fw_grow_paged_buf' defined but not used [-Wunused-function]
>  static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
>             ^~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   c8917b8ff09e ("firmware: fix build errors in paged buffer handling code")
>
> These need to be inline (as well as static) ... :-(
>
> --
> Cheers,
> Stephen Rothwell

They were 'static inline' in the patch I have submitted for review
when I reported the problem, but it was luck I am an hobbyst, not a
professional coder.

I checked with Takashi and Greg, because I noticed the inline removed
in the post review commit
and Takashi was checking if inline was really needed, now it's confirmed.

No big issue, now the important thing is that inline is added,
please Takashi kindly confirm when it's done.

Mauro
