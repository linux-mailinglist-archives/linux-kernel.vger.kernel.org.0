Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9D16931A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 03:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBWCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 21:20:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42051 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBWCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:20:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id 83so4292212lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlzDCWKnpP64oLtQaBAbzFOIcuprG8j5G+iWBrmKVrg=;
        b=J87BUl1GAtEGuqJhlVY2/k9SfnX3/EJ26CnJ5zhPvKO27Ck4gIMAaEcEp6RkXK1CoH
         cYeUu7QkJG+o7g82QaU04EprymxperNTYgWURB5uT+eAQBNQAFtc9siHaFRsGCPU/lfu
         6B0xzEvBpPVHL7GX3USuIS4PmGhz5I5USMHYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlzDCWKnpP64oLtQaBAbzFOIcuprG8j5G+iWBrmKVrg=;
        b=qaKBSOpNdngtBL1bZC2lzdBNkYUldcuUzKu/XljZUgOcHO0Rdo/bFpn4C31FXYi1L3
         jEPCMNG81gI8/nfdqJsCcQL/pB7ZkgoL71fnAZiTZM1WpbmuMBRkcD/Z5UpGCTLzhQBA
         G5lQyiaVz7INU8jjonc1GWwkQqaPK2a+nf/c6jmF2eCZXnA6TtaBlzIyPdrzcV1CWJx0
         qFV2nnSgQ5tgRxyzWgRSRe1WWzzU0+MPU2WJFqtmiSVNfiix+oU6JrmnOmZOjrO3Q5yA
         iV8P7vgcUnxSxHOhq2VWMf9s1jgsMsHAeSWMkvY5nTDIaAhJfKFjS+DzQvBnFpxLHbd2
         jCLg==
X-Gm-Message-State: APjAAAXsorz+eJFftFLV5oMzpixKI4WzW+oebBT8EwNwCCsZy23inmBz
        BKcMno4rQWptV637r/VKpKSjqQ9bIk0=
X-Google-Smtp-Source: APXvYqzsterecWQv6U8m/FI4sVMpz7ciIXtZf5v7BAoTkOR+LDssHeDjmHuUm3Z1AfJmq16sT1TdQw==
X-Received: by 2002:a19:ca15:: with SMTP id a21mr8258634lfg.67.1582424412309;
        Sat, 22 Feb 2020 18:20:12 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w8sm3947170ljj.75.2020.02.22.18.20.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:20:11 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q23so6237481ljm.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:20:11 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr26028515ljj.241.1582424410837;
 Sat, 22 Feb 2020 18:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-21-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-21-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:19:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikzXu_Veyj-H90HmLRof5vyMVZCWp03J_pC8fjb1_N8g@mail.gmail.com>
Message-ID: <CAHk-=wikzXu_Veyj-H90HmLRof5vyMVZCWp03J_pC8fjb1_N8g@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 21/34] merging pick_link() with get_link(), part 4
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so far I haven't seen anything bad. But I keep noticing these odd
stylistic things...

On Sat, Feb 22, 2020 at 5:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -       return step_into(nd, flags, dentry, inode, seq);
> +       err = step_into(nd, flags, dentry, inode, seq);
> +       if (!err)
> +               return NULL;
> +       else if (err > 0)
> +               return get_link(nd);
> +       else
> +               return ERR_PTR(err);
>  }

What?

Those "else" statements make no sense.

Each if-statement has a "return" in it. It's done. The else part is
not adding anything but confusion.

IOW, this should be

        if (!err)
                return NULL;
        if (err > 0)
                return get_link(nd);
        return ERR_PTR(err);

with not an 'else' in sight.

              Linus
