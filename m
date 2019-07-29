Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF66797F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfG2UEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:04:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41969 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389702AbfG2Tpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:45:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so59742691ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Xj0KmdFEesb0An0pvpoI4nRdiLfdj9xAiXwnPK4NLM=;
        b=i4fDxC9jgwYfkwAabdzbHKdotQBa5S7C9sw2mTATq9cGBTlThSmyjKilRde22eS4EQ
         J1y54uKk3TdvfFz+IZixYBhYEDQKK00Yr5LCyxsLkgEpzD2QrreBz4/IrMb+XjkyZi4f
         6P+ywrpTxBuWukUHucrzU54+yZN5I364s2E6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Xj0KmdFEesb0An0pvpoI4nRdiLfdj9xAiXwnPK4NLM=;
        b=jUU3vjDjFlKXNEIlnu9CBS9BGjUhx0VreCbDMAPK+fJikqy10jKfopbvnPeGolIcmk
         SOJUJAZ21JL8SLg1zvz/Bf1m+fm5SkWNpGkkfTnB1D2Tvt86e/QcIfLFGkcfpqHQmr7d
         Annot1SAO9ZtM5bzUXr0N6LFK0C0vHcy/D68I8Gg2l3TgLFqz8Gxrdyk/o+df6Vu3s+N
         6oMxFH4xGA5nHSf8jRfIZphai/jNm93IbNuGsVYzvQWlumZ2r49LaDcOptlSiA//6d03
         q+AGsHbDtEuWIWROPUPxv+xIAGh9HQhdXbLdeIkqBFDPEpl6mF2NUx4l41DzL8YjgFeF
         x7ig==
X-Gm-Message-State: APjAAAU1Eetz6Gh8VZDrlbGskE/2GJ45zTnTbobAGbPSWEhL9S8eY49I
        wtze9WLzuYGM6RnCzlSXx+Nx92yqoOw=
X-Google-Smtp-Source: APXvYqxmrJyu4mHeY340jv33GIOUR6sUBAP7nr/0oyJY7u9HGnDCYQO1Feys/MAjhuiwEQ3dgyxRVQ==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr34201783ljj.146.1564429541762;
        Mon, 29 Jul 2019 12:45:41 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y194sm10751627lfa.5.2019.07.29.12.45.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 12:45:38 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id y17so35180257ljk.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:45:38 -0700 (PDT)
X-Received: by 2002:a2e:3602:: with SMTP id d2mr407913lja.112.1564429538156;
 Mon, 29 Jul 2019 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190724194634.205718-1-briannorris@chromium.org> <s5hv9vkx21i.wl-tiwai@suse.de>
In-Reply-To: <s5hv9vkx21i.wl-tiwai@suse.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 29 Jul 2019 12:45:26 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMEFew2Sg5G1ofKq-0gfOTFEOhZNjfyNJMRzRjv7ZFgXw@mail.gmail.com>
Message-ID: <CA+ASDXMEFew2Sg5G1ofKq-0gfOTFEOhZNjfyNJMRzRjv7ZFgXw@mail.gmail.com>
Subject: Re: [PATCH 5.3] mwifiex: fix 802.11n/WPA detection
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 9:01 AM Takashi Iwai <tiwai@suse.de> wrote:
> This isn't seen in linux-next yet.

Apparently not.

> Still pending review?

I guess? Probably mostly pending maintainer attention.

Also, Johannes already had noticed (and privately messaged me): this
patch took a while to show up on the linux-wireless Patchwork
instance. So the first review (from Guenter Roeck) and my extra reply
noting the -stable regression didn't make it to Patchwork:

https://patchwork.kernel.org/patch/11057585/

> In anyway,
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks. Hopefully Kalle can pick it up.

Brian
