Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E32181CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgCKPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbgCKPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:45:00 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE4C2074F;
        Wed, 11 Mar 2020 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583941499;
        bh=PFGUByZEZTBls3DOx4QmCSCySBxN4HHWWP3hytIxz6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B933aFpcNlMJxmS8HIBv1ozND2nqR1JpFud+7CWKxeDc9Iy0XBV44M5fNbDRY5Xl9
         vm3dG6mVkT9Yg6CMQ7i8ect5XDgIYYnz1EaF0Avd4vGhfg4PsJ48QSaZ9BkQyfU3O4
         jSMb0T8qX71Ap4tF8QRvB6t/NL5+pK8ob/tWNIUY=
Received: by mail-qk1-f179.google.com with SMTP id d8so2528445qka.2;
        Wed, 11 Mar 2020 08:44:59 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0kUXHHRRTNgU3Ve5bciPsbhNnHai7idqKirGq3oAbWwu9RsNbj
        7hOakcWNwr8SAQKZgQdgfwTmKNqFvcq47r0fcg==
X-Google-Smtp-Source: ADFU+vuw15q6epFZCXVJuZ1Xg31IOj2uW3MXifAIuvdbqLoaajvp1prFnelurSmWkqVzjoRj7mM7gpt70hmkQJ36bhw=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr3442629qkg.152.1583941498611;
 Wed, 11 Mar 2020 08:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200117170352.16040-1-olivier.moysan@st.com> <20200121220022.GA12737@bogus>
 <6a49bf6c-8851-a65c-5606-563776e07c08@st.com>
In-Reply-To: <6a49bf6c-8851-a65c-5606-563776e07c08@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Mar 2020 10:44:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKGy6Ec57RC_N-KZfKgGij4nn-BEdNQqXCd9dH_yPY6ew@mail.gmail.com>
Message-ID: <CAL_JsqKGy6Ec57RC_N-KZfKgGij4nn-BEdNQqXCd9dH_yPY6ew@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: stm32: convert spdfirx to json-schema
To:     Olivier MOYSAN <olivier.moysan@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 3:20 AM Olivier MOYSAN <olivier.moysan@st.com> wrote:
>
> Hi Rob,
>
> I did not report your reviewed-by tag, as I have made a extra change in v2.
> This change is related to dmas property reported in v2 change log.
> Sorry, this extra change was indeed not clearly highlighted in log comments.

Indeed you did mention it, I just missed it. Anyways, it's a minor
change and my R-by still stands.

I'd resend this to make sure it's in Mark's inbox again.

Rob
