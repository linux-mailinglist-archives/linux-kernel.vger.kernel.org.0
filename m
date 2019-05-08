Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5176B17D48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfEHP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 11:26:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40615 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfEHP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:26:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so14836005lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rIq7gmaA9NMXEjKGvXInNhUyh84RAmH4+jHxozM48g=;
        b=o51eORyUc/vhgGowEBY3U1f1Wb0J5uTFKxXu3nbTQx9Pn1GdCap/WlYhOpEzhbOvO8
         AQR+00NI9UWRVcxCLGEO1lnewXOg9b1WnGqkbt8hb1Ky8MUujd6eI7WDBPZywiS/LBT5
         vYTEHYaIStdLN238AOZ2O2/WCK7qBSa1uQCECZGmH4krle+ofA2+EZQb85KdBHzH6qfA
         pYKtKaQ1QvshzI6D6xyzddZaEEm0avJeoDzuNs1jUMMeUM7cj1eC7PowrHRfrPH14flk
         8wvOm951TWSc34H+Gna+TYM4QXuN4I3TYpBq0s6X+9vWwxvrv+mXODGHS/0RcKR/fvZg
         wxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rIq7gmaA9NMXEjKGvXInNhUyh84RAmH4+jHxozM48g=;
        b=jWGDSkbElIUjYJpMGh0U3t0NLA9x9iyh20jwgAuq8vXRw1rebHUqAvMR9MtQw3fquG
         78rZqFGacXF+NFbQ9N0h7hEJjVwS1hcPEOVyfbdqCfeAqBDRhZKDPwrfesSaD6VviE1E
         uUDfwrEZOH1VEeCod/KeaN/QLT835IwVuxR+gogwTe8VLJ4R3KAKpsbcXEh70jlJFGnT
         W1+tpHmfr0hvXj0/PW3qRzUvCieBWyHwLuNGNwwAni5gwwmAB6Fcbmo9Auhyr8/PjI1n
         2siBQO/+NkHsHNOfuowxgHBFiIZG1xpEaWvWxUfIlaYfvpzToHbblXIng+2xTHx130GU
         tu2Q==
X-Gm-Message-State: APjAAAUVVx4KQlGbSnDtR6iZon2TxMIsGqR4SGRORHl+438oar7V+6sE
        4tKx3/tKsbkEl56TGi/4P2+lQpj/BEmFA58RPV4=
X-Google-Smtp-Source: APXvYqwFzfGEOLv/TUFRCcQy724y1VsJ5AB8wPfpn2R4E2hWKxIzzXDqZfDE77SPiWcRdbDZpHYQBzcjjdyOtdJzng8=
X-Received: by 2002:a19:3f4b:: with SMTP id m72mr5192626lfa.32.1557329191896;
 Wed, 08 May 2019 08:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190508122721.7513-1-borneo.antonio@gmail.com> <4517dfca6c4692b28c4914410f475d3f521cd230.camel@perches.com>
In-Reply-To: <4517dfca6c4692b28c4914410f475d3f521cd230.camel@perches.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Wed, 8 May 2019 17:26:11 +0200
Message-ID: <CAAj6DX0Gaym5ftcAdsAwTiaN9qvfJWxX0UN==VKzUT-4GPDtHg@mail.gmail.com>
Subject: Re: [PATCH 1/4] checkpatch: fix multiple const * types
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 4:51 PM Joe Perches <joe@perches.com> wrote:
...
> It might be better to use a max match like {0,4} instead of *
>
> perl is pretty memory intensive at multiple unrestricted matches
> of somewhat complex patterns.

Agree! Will send a V2!
Thanks for the review!

Antonio
