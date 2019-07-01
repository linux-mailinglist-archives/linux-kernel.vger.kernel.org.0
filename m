Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE252CC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE1Qog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 12:44:36 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38942 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1Qof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:44:35 -0400
Received: by mail-lf1-f43.google.com with SMTP id f1so15117069lfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mZlg4sc7q9rQDVHOh6wEBx/xKO/kmSkGgITfjko1qow=;
        b=HFnOxRV2ppzDsKKS8afYxgqriBArjzf7Aw4Gfpuee5lbPOSqcaOO4sesORT10MysFm
         u2/g6xsqlph3uXVFfQuy7b9VwEBn26e6SL43DOnYsO5FGXfUm925LNM3QeMGC1zEQXsZ
         vkhPrxQreTKYpzfv7CG7huxATqWwt7sQFmQlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mZlg4sc7q9rQDVHOh6wEBx/xKO/kmSkGgITfjko1qow=;
        b=lw8AQpHvXvTXDUP0tyPNhdU2pHWD+vR6/BD8YKoo560SCVnddeYH6YEyzhAeYMnr9s
         ulBJMwih9cIZ4/e1Xzcba7BL/o33tr6qm/oRkYOq//aE58aVo3YTbGREi5OXhRAHATKF
         JCakJIXg92lAyhmncPbddMkJ9roWDUWWRXKWTd8bv7IhL1c3+24sHbMfZ0vaLSq85b+8
         FAjRllSumcbU5CBz7/JAvowbXMTVxD1Rl7gioQdTCUVepo1E09BSy6e62yQgUWWvlvtz
         iLtyq4c3TV3gMG10QNk+6xZ8ddxI/VGxgqhbYuCGyUAIxH/7QZDVKc8yCIoB1bJVFMRt
         ECdg==
X-Gm-Message-State: APjAAAVevqxm797faSwRRiEomHluF+z6USOR0MS1tUgyuF80o9Kfv2v6
        2X0jHZy5iPWVqfjImzUmur/IN2F5jpo=
X-Google-Smtp-Source: APXvYqxjJu5rwiK6wi+D6aflfmW1F8lnYbuGS913jWrIl1T4bM+ClWo+mR8gdpNB0VKPfh4aivKY2Q==
X-Received: by 2002:a19:95d1:: with SMTP id x200mr1416719lfd.166.1559061873487;
        Tue, 28 May 2019 09:44:33 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 62sm150748lje.53.2019.05.28.09.44.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:44:32 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id h13so15134870lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 09:44:32 -0700 (PDT)
X-Received: by 2002:a19:f60f:: with SMTP id x15mr12198921lfe.61.1559061872401;
 Tue, 28 May 2019 09:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
In-Reply-To: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 May 2019 09:44:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZBfGwnyRGjziYvPMssSf7XO+7L_FTGfkR9Gz031VAzw@mail.gmail.com>
Message-ID: <CAHk-=wgZBfGwnyRGjziYvPMssSf7XO+7L_FTGfkR9Gz031VAzw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for v5.2
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 1:44 AM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
>
> The outstanding commits are the Intel fixes [..]

Heh. Swedism? "Outstanding" in English means "exceptionally good". I
suspect you meant commits that "st=C3=A5r ut", which translates to "stands
out".

Or maybe the commits really are _that_ good?

                 Linus
