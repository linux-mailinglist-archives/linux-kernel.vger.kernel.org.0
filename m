Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3615063ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 03:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGJBIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 21:08:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34405 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGJBIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:08:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so326388ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Up9iZjHgNCrq6ieA7OVjWsH/10kzcc/oi8LMzBf69I=;
        b=Rf0xOIMPoXeM5arzCpWk0X8A7YdXx/q5SGa1Od6cG77Y3DQ+U7tiaIfxjxVQrso7wv
         RlVDVJyckSktKk5/NVoyVC5yHcdFsiyRiIigpFCbq9Qvzie6U4YZ/Xub0zDPilFL9VeL
         h0ue94X6HQsyBTkcJmVfS7PDivZLhW2Ae2Ujk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Up9iZjHgNCrq6ieA7OVjWsH/10kzcc/oi8LMzBf69I=;
        b=Kfoo6QKlaOLKrlTpxITGsMn9HTr+FAoVS84EL2ZneyVRibxVw3L6VbozS6SRKysxOX
         zuIOA+wI/Voo49iQwo1UswgD2GS10jl3LevW/z5KjF0edf7QWCXesK0SBjps4V238M1o
         1phK2UsSFjPXtX0y4dhF4eHlR5ms1N37L0/CrFu9/N6fmKNCZY/R9qVbp7azNJOods/Q
         jeMu7XovbKEOzaMgiDGnzgdexajyXIHD03ydFt+1JWVvef5g88t0yr/atAzO4ZMytlC7
         SSnF8M8lWaMcWsXmqCbBznKHlipIlgXMxEN6tPTLtniRzaT/pBhWAhdxT21lQirpkBbz
         eLbw==
X-Gm-Message-State: APjAAAVaxrcr53On7BH9koaw0+qGZ0jirpXF/6ZlPswGQjnJDWEwAgZU
        c4gvU1i+FEkNJ0KExZnJ5NYpq4vJTDc=
X-Google-Smtp-Source: APXvYqwIgUCsbS3Nbj76VqBsANuS54NJrbctg7zcdQx7um/bsrkBoAy7Wts2Z4ChoeON8E5JsRlfzQ==
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr15006182lje.46.1562720931662;
        Tue, 09 Jul 2019 18:08:51 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id p15sm141698lji.80.2019.07.09.18.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 18:08:50 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r9so308864ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:08:50 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr15908516ljj.156.1562720929921;
 Tue, 09 Jul 2019 18:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de> <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
In-Reply-To: <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 18:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghD6CzP7NxHzG4_-bAqOiad_aAohdETDTpUpyci55kfg@mail.gmail.com>
Message-ID: <CAHk-=wghD6CzP7NxHzG4_-bAqOiad_aAohdETDTpUpyci55kfg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 5:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On my laptop (which I am at right now), the hang is different, and
> maybe it's similar to your ACPI hang issue. I will try that revert,
> and at least see if that solves the laptop side.

Nope, that wasn't it.  Apparently there are three different issues.

I guess I'll just have to do a full bisect on the laptop too. That's
going to take forever.

                    Linus
