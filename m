Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03306107517
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 16:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKVPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 10:43:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40991 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKVPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:43:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id m4so7873656ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQzy1iQq7/UigF4z8t1UMdfHuT9DigedXPRNYTx8QBY=;
        b=XAGbQgf1cU8rD/kywGu8E//J0deKp6oSzrY4nW/7iQnOC7Z85qIiCXWxldnCOmfQM0
         5rD4pSqDLOxxYiQ22XtpA+ZQtIqNcfUSFvLURlIPtJQVgPu6ai8DLyrFL71pg9GiQ9pG
         J3lCWTccy2Ay+ptCBd2t+/YVxqaTPHmAVMWaO+1JJ8kbJonQBCsyOGxhUYGEl3GzmSzI
         ho5z7STf9Rfad2+G+J/cpfc9GQGp4z9GERHGxEaTUbyQm6+2MI6V46dhpZKOLPjpFlk3
         RbOEvF5G831FamUvktmD2bDhXniv+mEfiO+c9474NZJJF1jmAgNlIrUF58CkzGAeBa0J
         jdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQzy1iQq7/UigF4z8t1UMdfHuT9DigedXPRNYTx8QBY=;
        b=A/k5HaJ62dEuXbE/vt+T5iQY34i8PI/vFKrAzns9ARk+tKVQ3dY59BxvD6iB3LPqkD
         9ucOLJXWEvyoLhP2Yd2f2BftfkLPxFUo25wNpyubo3RYATJ+FgxkIC6DDiMgq/lWs6b4
         ayAUUGoQGqu5C4bDv1ImMmHL9YrvvaB95Bo4/EIfHKHZIGQ6PqatS1+YCVL4NZ7NEM8O
         5MNG0GT+g3Mjyk6Yro4SHoAdcV5wDs1Jyl8liMtmeWwPNWQvsG6yIvO1wZSvVm5bFyar
         C5D5rw6on+N0/XOVfyIrn8qJmmQ4Cn1yXdEAI4UGfs8NhTx+0+F/ETJzOzXpr+cgJNG1
         AEoQ==
X-Gm-Message-State: APjAAAWtOcJ4xyMeMydQEem71CIbcgKw7nUOZshbPuxxHeP9nRVLwQ/8
        wrzD1wrnYoD8ScGKJe2TVmQCDvim3TKEv/292vhPMKsZpLw=
X-Google-Smtp-Source: APXvYqwcugeW4edWhYbow6P3IthY8AWt+/SiEG9o6A9ekVZjqmWysrxtVlxvnwXZwUzSHLS/mgbF3SgO93jwQdxuQ3k=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr536136ljm.233.1574437400356;
 Fri, 22 Nov 2019 07:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20191120181857.97174-1-stephan@gerhold.net> <20191120181857.97174-4-stephan@gerhold.net>
 <CACRpkda-rm=1hz_p2YCqBVgxsM9cmKYJVUg+T91MyBrgmtDP-w@mail.gmail.com> <20191122140944.GA2872@gerhold.net>
In-Reply-To: <20191122140944.GA2872@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 16:43:08 +0100
Message-ID: <CACRpkdYfUikKaB-9HO_heLZrGC346XZVKxvifMPJizeYSPjShg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: Document compatibles for Ux500 boards
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 3:10 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> On Wed, Nov 20, 2019 at 09:22:19PM +0100, Linus Walleij wrote:
> > On Wed, Nov 20, 2019 at 7:20 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > > The device-specific compatible values used by the Ux500 boards
> > > were not documented so far. Add a new simple schema to document them.
> > >
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> >
> > Nice, thanks!
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I expect Rob to merge these patches as they are bindings-only,
> > alternatively I can take them in the Ux500 DTS pull request
> > for the next kernel cycle.
> >
>
> For this patch it would be easier if you take it through the Ux500 tree,
> as I have another patch series that adds a new board to it.

OK I applied it for v5.6 on my ux500-dts branch.

> The vendor-prefix patches are independent, so Rob can merge them if that
> is easier?

Let's see if Rob wants to take them, else I will merge them as well.

Yours,
Linus Walleij
