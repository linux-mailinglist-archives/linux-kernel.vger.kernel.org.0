Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40241150EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgBCRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 12:33:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38280 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBCRd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:33:27 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so10295468lfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hbE/x+sKgUAgdZy5iD1MgArPOja0ET3H9jzYkhb1ns=;
        b=WYFHmu8BI34dQPDYIAU9HVfivXkiWKo8NGvuEy7B6TsaQmEE8aTI4n0VwoxW+lgt2V
         kkDCpnuh98u9bEorsiDtOuKYAOPlNmacBmM21claXHAv5AtJRqeQyw4gS4hRyWLexsc5
         mW7oNEJYTcmOIHR+e6ixQIiRFZbZEzwujp5lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hbE/x+sKgUAgdZy5iD1MgArPOja0ET3H9jzYkhb1ns=;
        b=Z3xtEPoSIjiMipnDsQB+4If9qEP8ZLkyVZ9fWF7ZfJQs5XsUCUYWTyXcIksHa4OOj5
         kLUxCGIjEEra7Ac9TElANSkFTLEPfckADEHgRPbgbNg91FCr6smzHi+jI+bMlnRzLaho
         SFBBbQDUTQLSB2tiG1s2OrCu7ZWsK8zz3I2UXYU8ofT2z4tOd6xzdTvTNSWR4tRoILKd
         o4FSKpPFjfamSyKLhT8g4JzEkBSwqJiHbTmPDV0D+gf3MM/VQCiofuT8ekigvZAdotyR
         b+pfCEBhir3o58bbAHGr6ftFbeitY6ZKfbivNuifmdigARPAR3pqvqfGes3S9QTKrDM7
         fkYA==
X-Gm-Message-State: APjAAAVKJOqTVmP/xmwwx5vtQNybgwd5g+AFBajusiiERYL14HUCcakf
        +bzaLA/MQWrcne8Coq/TwR3DomGW0yoLVQ==
X-Google-Smtp-Source: APXvYqw+xyN6oIPsBe1jYmMjymlFDIlMwtsMGaSn9DS2+kjWp4pj1yzveP4zE68/XCGHzSnmRrVhzA==
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr12653772lfp.75.1580751204576;
        Mon, 03 Feb 2020 09:33:24 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id r20sm9300234lfi.91.2020.02.03.09.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 09:33:23 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z26so10230076lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:33:23 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr12455037lfm.152.1580751202962;
 Mon, 03 Feb 2020 09:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20200203164708.17478-1-masahiroy@kernel.org>
In-Reply-To: <20200203164708.17478-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Feb 2020 17:33:06 +0000
X-Gmail-Original-Message-ID: <CAHk-=whHRjzeTRsPta3VY3pnT_NRPXgCqPgmm=midXevHjGZEg@mail.gmail.com>
Message-ID: <CAHk-=whHRjzeTRsPta3VY3pnT_NRPXgCqPgmm=midXevHjGZEg@mail.gmail.com>
Subject: Re: [PATCH] initramfs: do not show compression mode choice if
 INITRAMFS_SOURCE is empty
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 4:47 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Will you directly pick up this if you are OK with it?

Done. Thanks,

              Linus
