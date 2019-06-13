Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED114464C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbfFMQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:50:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43499 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:01:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so13870683lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbJVJjV4JHgO+lN2CsoiJmjNN9A/OrzWGNbZgYy8/Gk=;
        b=ZuHB+EFIWdmyBI+Bcm6q34WvnNer+ayYdcSCBHw9qKdJL9RuMOUEPVDSrPOV456jEe
         Mu2BtvM6HHM2VC/dxpIL71LNetzBiC2Kp/5bf8wCUjnRs36qyJeTHEY/nu3+T/gkFmV2
         AKNJR7dBb43TR0xZODVPwIEf0f2Q0JzJ6s+UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbJVJjV4JHgO+lN2CsoiJmjNN9A/OrzWGNbZgYy8/Gk=;
        b=fNCjViMW5FWBO6ONXxlH/1Br/9YTx8IxjCg2dEXTUGmFbGzJzB2brwxhzYK9014QsU
         USOjeL1Rd7HG7REi/rZKWgTvEacTkn6fi5EdvpHhf+8Hx9desPoBIctkrTqOz++4Pyv5
         kXX4uKzfxvV9PUjKWY6PnLRjgFN2APaKzN/feocovoxcTgjl681vLMOSPBVYmPHp3w7o
         xNpYPGkMEjbcfdsbD+5VUoXNgJvhXiPpAX+HsiJqJ8lo7GciYa5a70Y+XzO+aKTJO7tq
         PlxeK2s/yWK1KFX1VpTmnR1IVdpQZoWN+iNgaHzryjGF/BBsPm+ZurP3nO1cTqgZqEyf
         yiwg==
X-Gm-Message-State: APjAAAVJ/PSxdrLdu8AiqlWlDWiESe7J1fU6Pykd0zT3TTauuk1pqqCp
        +nVMpJfT8ci5xxYEpNH3QB5dz2KATo0=
X-Google-Smtp-Source: APXvYqz5Nm37zxojVrusz5L1bDSxR2BJjoIotJxPguHypWXEegb2g9Qh/YxNgqFDXXxn/KhlbfMxBA==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr35977962lfk.125.1560398457286;
        Wed, 12 Jun 2019 21:00:57 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p15sm319635lji.80.2019.06.12.21.00.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 16so17055237ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr5616489ljs.44.1560398455064;
 Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
In-Reply-To: <20190612225431.p753mzqynxpsazb7@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jun 2019 18:00:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
Message-ID: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>
> The commit changes the internal logic to lock mounts when propagating
> mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> to fail at:

You mean 'do_move_mount()'.

> if (old->mnt.mnt_flags & MNT_LOCKED)
>         goto out;
>
> If that's indeed the case we should either revert this commit (reverts
> cleanly, just tested it) or find a fix.

Hmm.. I'm not entirely sure of the logic here, and just looking at
that commit 3bd045cc9c4b ("separate copying and locking mount tree on
cross-userns copies") doesn't make me go "Ahh" either.

Al? My gut feel is that we need to just revert, since this was in 5.1
and it's getting reasonably late in 5.2 too. But maybe you go "guys,
don't be silly, this is easily fixed with this one-liner".

                      Linus
