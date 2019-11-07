Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC41F2B07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfKGJnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:43:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33428 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbfKGJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:43:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so1425870qkl.0;
        Thu, 07 Nov 2019 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6oBUNPjeD8vyot7PPCmzyHG3FdRrgFStwY+MglljGg=;
        b=ZacppmytF0m7kXmGvU/spGtWj9WVI/Gv5pMugvGTSK+j9uNMNF4VFdOvuZ8HkjWYq3
         P37UZCcOYHph0/IhZxX9liBdp1kU3yAdy5wnfIn0TB/cfvBLrfMTcnrwUk47m1XQ0w0E
         LNjsyE+Q+VBjlKjdrt77ZI2rpPI9wajyVuBEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6oBUNPjeD8vyot7PPCmzyHG3FdRrgFStwY+MglljGg=;
        b=lUoc2OuTmNEA6+0pmooN4dSb2ecW0P4kEZIg43IQ6VdKiSjnfLxhX7Gg+3ggV5VChz
         j4RM7Q5dUPW6xtLACNfQgJpEkFjzFyMo1hXO4TwlUSoj2JbfVCh1k5NGTJw90AWL7EfK
         3lIFl90AAxZp4wOA/HRrgV0y91zUaa0561Z1zhP+PQGdTDMzLIXLmYPIWIGhviNdu0HA
         rZ6WTE/AXm2Uj/XDi/LoMMTWOVRHIpmjwdDhR3sXiA9aZulXDhdEXabvnXNsPUsVdMZA
         Im7vlfEvp99Rt/Ovnnw7UHfoTCN9AzMq3W9UdPtDVX+i9wP0gJPK80ttXpOMSucbw5xt
         qrgw==
X-Gm-Message-State: APjAAAX/mXr7Q9dM2brvQK769c5+UB5gWGg7vyHGEUjUtKnyZ20t0lGR
        cjmPHxNuHrU1IhUC2WgCD0ZyJlozgJ5Tvw/ufgo=
X-Google-Smtp-Source: APXvYqxVSRtwG6RhOor7ywvigBBEHgP7u5zDZoj6hInpq+UuyVNxJ2bEQVTG3eBvPSMsX6HdIlsA+yuPP+J5g3tV6NY=
X-Received: by 2002:a05:620a:21d1:: with SMTP id h17mr1853648qka.292.1573119800326;
 Thu, 07 Nov 2019 01:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20191106060301.17408-1-joel@jms.id.au> <20191106060301.17408-2-joel@jms.id.au>
 <CACRpkdadKG=FrSRu_OP8S8sv1As35j1DBFnWrzD4MU1EEzAptQ@mail.gmail.com>
In-Reply-To: <CACRpkdadKG=FrSRu_OP8S8sv1As35j1DBFnWrzD4MU1EEzAptQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 7 Nov 2019 09:43:08 +0000
Message-ID: <CACPK8XdGq_-WZVwoKEMCQ+V72_0ayhVzvr_5hVTQn4KAM+jRZw@mail.gmail.com>
Subject: Re: [PATCH 1/4] clocksource: fttmr010: Parametrise shutdown
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 at 07:47, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Nov 6, 2019 at 7:03 AM Joel Stanley <joel@jms.id.au> wrote:
>
> > In preparation for supporting the ast2600 which uses a different method
> > to clear bits in the control register, use a callback for performing the
> > shutdown sequence.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Nice refactoring!

Cheers. Thank you for the prompt review!

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
