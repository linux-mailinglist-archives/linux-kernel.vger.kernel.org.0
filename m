Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C9BBBE3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfIWS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 14:57:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34219 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbfIWS5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:57:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so10984807lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4tgrGihcnnMxK6tf6Ms9qDSNmgdGrksSS0BVGhZJ1E=;
        b=Vuc1VnR62B0oJl7jXHhRX8MAVLKvNBiajFdnjcYaVEXV3zkbWaM41bUU65zSidpphj
         AFtRxoPEXlYYkxXyhY4G/F3+iRAwwazFEeMQhd6OVQBcQjfnpblE6Gm7J7meV5zhyaSf
         S6YgEHu8qww8SMXXeagBNtQG40LQYJEKFX3yGo/qxZGmigy/UmtnAEgo0pehtVcFZvgq
         zQJKaNihjd8Fai1gUZNGbmujWFLCbQoI/SuhivlbZ9NLou1tNbAywYyxCYSwYnZsSjxg
         j6bkz6shsdU32J3Gpg72zzy4oDhGL4cbNn8qmXAq+RcA+4teL+kn3akE0mzmYFnQVpWo
         mpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4tgrGihcnnMxK6tf6Ms9qDSNmgdGrksSS0BVGhZJ1E=;
        b=XMyZBj3Eysb70Fq24P49uvH1iR+QKsZJ3cbn5eQb6Bsux0Wr58XTPjrjv34aGHI++x
         tDwOwiOc01SyHvv5U3r8g0HSh8PZPC0hleqzaXdGvHAQNyLpRUGHCoBuV38h3WxOuRnS
         9A1HkwY8dk4gB56kIvkq3CFeaMbfmmfwCcXP1KLrW4Tanq2SlZBG9bBC1sadU1fRrauu
         aURzWDhAsUQ1fp30DDNL0Di2t0xN5TgqFap6FLY+B8YeU/A7ZZ0S2zBlG5pkRFN4T9JN
         qTPT9i/tLit92K3I2mbqUmrq+kSV4K2tCll9sK4gOiMhhPpu9T6YJqIciM3AZFShnKx0
         5gXw==
X-Gm-Message-State: APjAAAU98aghby8kJ3ua3ErR8M31RV8apnmtDa1QihwSNk5v13Ondy6I
        YQ0Ji7MKrrlWWRkefnZ/Q8p6+/jt4yYonPbXnTXaXB0=
X-Google-Smtp-Source: APXvYqz62ERe3OcFIvZ8Et5y7TEm9J0tpiQKpmff5I+9uZaO1+QV0ygNSEhKjPeF1/zs3jlKJGUih5RmbOY0CzZceY4=
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr590505lfo.175.1569265039864;
 Mon, 23 Sep 2019 11:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20190923165806.GA21466@codemonkey.org.uk>
In-Reply-To: <20190923165806.GA21466@codemonkey.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Sep 2019 14:57:08 -0400
Message-ID: <CAHC9VhTh+cD5pkb8JAHnG1wa9-UgivSb7+-yjjYaD+6vhyYKjA@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Dave Jones <davej@codemonkey.org.uk>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:58 PM Dave Jones <davej@codemonkey.org.uk> wrote:
> On Mon, Sep 23, 2019 at 12:14:14PM -0400, Paul Moore wrote:
>  > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
>  > >
>  > > I have some hosts that are constantly spewing audit messages like so:
>  > >
>  > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
>  > > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
>  > > [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset old=1850302393317 new=3190241577926
>  > > [48850.604008] audit: type=1333 audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
>  > > [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset old=2453141035832 new=2372389610455
>  > > [49926.567273] audit: type=1333 audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
>  > >
>  > > This gets emitted every time ntp makes an adjustment, which is apparently very frequent on some hosts.
>  > >
>  > >
>  > > Audit isn't even enabled on these machines.
>  > >
>  > > # auditctl -l
>  > > No rules
>  >
>  > What happens when you run 'auditctl -a never,task'?  That *should*
>  > silence those messages as the audit_ntp_log() function has the
>  > requisite audit_dummy_context() check.
>
> They still get emitted.
>
>  > FWIW, this is the distro
>  > default for many (most? all?) distros; for example, check
>  > /etc/audit/audit.rules on a stock Fedora system.
>
> As these machines aren't using audit, they aren't running auditd either.
> Essentially: nothing enables audit, but the kernel side continues to log
> ntp regardless (no other audit messages seem to do this).

What does your kernel command line look like?  Do you have "audit=1"
somewhere in there?

-- 
paul moore
www.paul-moore.com
