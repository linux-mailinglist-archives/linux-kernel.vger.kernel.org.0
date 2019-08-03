Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5198E803E7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 04:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbfHCCDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 22:03:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38686 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfHCCDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 22:03:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so74500347ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44/+Wu/RWWI3biEQEefjk6MChVguOKErpRKwS84oe4E=;
        b=e96STy2zk1RT0gcnxBQamQGm4+cvVj/BvaSeHbNcDROENC9N4oxtY01aWTPfpIQ7fw
         ffIOPTQIbFXMtLpdgq/qlsgNix2/KNE1UEChwPQCI+UfHVoJXIqUm+rMleKs0ngEgVxL
         tjb0w2IkhUlaaA9e+fXVr1BCGyJgyXnnAZzOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44/+Wu/RWWI3biEQEefjk6MChVguOKErpRKwS84oe4E=;
        b=Yqg9EXRp4VhSfbTIFzuXIeDoy4Nql2xfhxa5xG6Qg7EG6sU+l4t9BRxJNWG0YIF+8Y
         aGcnHHB+lG7T3JWa2ZEfxsox5wgtYWxqKE1yHw8+AphukIFncyJOjM8M/ZR8sTnYJ7gz
         Vhz/kRnyRKZfQB4+j9h0Dan29qUdGytGXtd6VYKlVmZvp/nCVC7yGWe1KkcjfjWBdZN/
         bqx8trvul+xEccIzfqJfjXyHDEdTGOfsz0CIW2+oEXtWuFeqPWur52dytIrGBnlTyS7w
         vO+J6DP/z+vH7hlzA2Ri8PmOqYvSkQVUtW2yF7pJmhGHhXTxTjjDyZjWGZLzhMnq1zMt
         jIsg==
X-Gm-Message-State: APjAAAX9fw86uOomdySblUEQzPIoUNv5LCtv8ufo8ZYIuU4TvBkFgbcY
        OiN6XQvG1I2UOOObASemIu4BeQgshes=
X-Google-Smtp-Source: APXvYqzn9rOypE9elewqi1lQtOuQzA6pzgrKhHmU2Vo9+m7Z/2mpJ3M5F3/Y6saSjzwjN2+CyR9ooA==
X-Received: by 2002:a2e:9643:: with SMTP id z3mr74106165ljh.43.1564797787427;
        Fri, 02 Aug 2019 19:03:07 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b25sm13140077lfq.11.2019.08.02.19.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 19:03:04 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id c19so54178199lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 19:03:04 -0700 (PDT)
X-Received: by 2002:a19:f24e:: with SMTP id d14mr11643718lfk.184.1564797783720;
 Fri, 02 Aug 2019 19:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20170331202136.100342-1-briannorris@chromium.org>
 <20190803010641.GA22848@google.com> <875znfhv2b.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <875znfhv2b.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 2 Aug 2019 19:02:52 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPCxDQAFPcPu5N6aY9mRDRF2FmsSTWAdgvSNDa2uPsRtQ@mail.gmail.com>
Message-ID: <CA+ASDXPCxDQAFPcPu5N6aY9mRDRF2FmsSTWAdgvSNDa2uPsRtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "mwifiex: fix system hang problem after resume"
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 6:55 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Brian Norris <briannorris@chromium.org> writes:
>
> > + Doug, Matthias, who are seeing problems (or, failure to try to
> > recover, as predicted below)
> > + Amit's new email
> > + new maintainers
> >
> > Perhaps it's my fault for marking this RFC. But I changed the status
> > back to "New" in Patchwork, in case that helps:
>
> But I still see it marked as RFC. So the patch in question is:
>
> https://patchwork.kernel.org/patch/9657277/

Oops, I didn't hit the "Update" button :(

I changed it now, but I'll change it back again.

> Changing the patchwork state to RFC means that it's dropped and out of
> my radar. Also, if I see "RFC" in the subject I assume that's a patch
> which I should not apply by default.

Ack. Well, there were some "RFCs" I sent recently that you *did*
apply, so I didn't really know what happens normally.

> > On Fri, Mar 31, 2017 at 01:21:36PM -0700, Brian Norris wrote:
...
> > FWIW, I got an Acked-by from Amit when he was still at Marvell. And
> > another Reviewed-by from Dmitry. This still applies. Should I resend?
> > (I'll do that if I don't hear a response within a few days.)
>
> This patch is from 2017 so better to resend, and without RFC markings.

Yep, will do.

Brian
