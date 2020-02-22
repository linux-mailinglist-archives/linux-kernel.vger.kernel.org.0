Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5363A169102
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgBVRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 12:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgBVRwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:52:07 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9350E208C3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582393926;
        bh=LKke1TZKO5OgzTL/0rK5P/ASeho6K5dTtJsthmRpUEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nh6sObk+UwVZuQ7QmtqhTvnXLpatEoUVRRWkB1jVTVKv4xeODsmlYVWhnZyQULNMd
         AnvGvplkv8jDgKd9wp0OoiJI4OVlM1wlDjHs2swTccS34MpM9RBFrzQdZRvyq1Vr2y
         iro3cbATyjYCMbuLAuZcUH3yY1rE4WSMsxCfDqZI=
Received: by mail-wm1-f46.google.com with SMTP id b17so5215742wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 09:52:06 -0800 (PST)
X-Gm-Message-State: APjAAAUc2s0pQYfHezQTlHXcrV8Ixn45AfTYSro5TxSnvlHjdYt06dTq
        zmW3dog31ZSqrpL2MBW6VwcZiTAdA+bXwVFba8tWdg==
X-Google-Smtp-Source: APXvYqx8LK/iq059UICaGpUxYYrdkEVXivBGrCUSlxtERrg7G74GqbVSDvwfoUaXtovQ0xXYjQKtTfosScxBnq5QMZ0=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr11842893wmf.133.1582393925002;
 Sat, 22 Feb 2020 09:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20200221114716.4372-1-xypron.glpk@gmx.de> <20200221163017.GA4477@light.dominikbrodowski.net>
In-Reply-To: <20200221163017.GA4477@light.dominikbrodowski.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 Feb 2020 18:51:54 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8FhCYQsihjQ4MTXPQsGbz8a3rUA+Cy2-4GT8cukdJHSQ@mail.gmail.com>
Message-ID: <CAKv+Gu8FhCYQsihjQ4MTXPQsGbz8a3rUA+Cy2-4GT8cukdJHSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: describe RNG functions
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 17:30, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Fri, Feb 21, 2020 at 12:47:16PM +0100, Heinrich Schuchardt wrote:
> > Provide descriptions for the functions invoking the EFI_RNG_PROTOCOL.
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
>

Queued in efi/next

Thanks,
