Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9579514D072
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 19:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgA2S1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 13:27:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41248 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgA2S1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:27:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so782095eds.8;
        Wed, 29 Jan 2020 10:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgwXL5RlE8u/644YX8TClNL9wlJ237mv6DTllirKfdw=;
        b=ZSeHE0YXCw2cYqDN34HdokoPVq6JQufYPq4GvE1aZ9UwHIj1YDyWwykL5oXApUx2Bs
         +fmus+Df0Y94WHPASPCo8I6/MR1WCDxekuhONa3B54mpL0UyvZIA9mTEPBr+E6QPzMPd
         vOjRkaO69Zt9QruiOY4aPTHpZOcKPcElrukSlF/YPcmde6R27ILyeeCnpFhliqkb+/0K
         l/UKmMqVZbusdutmnzOR7ZqEiSESL5kL8YUnHfUe1XMORv5jpWoz15Ltl6/Zww5hYYda
         jU8suIWWhsgXMFZ1gCjtE0Tu+eFEzt1v3nQ9yztC+vZ2aOuOU1miavbe+tVLwnkjpoN6
         5TIQ==
X-Gm-Message-State: APjAAAX9325W5HpyPuxhWc5zSTgXHy9GbhehE4/nck7NApwgZYpTztQM
        1qr/E68Uyt8y4GNpTHGKLUQ=
X-Google-Smtp-Source: APXvYqzNl3/Wu+e5/GgHKeNIpy9A4hBqgGhZDdTgGHrw4RyxsH3VoEDMXQeX6RrJv2L7+SmRAbEiUg==
X-Received: by 2002:a05:6402:2211:: with SMTP id cq17mr275330edb.94.1580322448751;
        Wed, 29 Jan 2020 10:27:28 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id s16sm317790edy.51.2020.01.29.10.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 10:27:28 -0800 (PST)
Date:   Wed, 29 Jan 2020 19:27:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
Message-ID: <20200129182725.GA13441@kozik-lap>
References: <20200129101401.GA3858221@kroah.com>
 <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
 <20200129182027.GA13142@kozik-lap>
 <CAHk-=wg67HWkPawJRFffOS25CL0tjzF7tbk-mJot9oT8siqPfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg67HWkPawJRFffOS25CL0tjzF7tbk-mJot9oT8siqPfg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:23:54AM -0800, Linus Torvalds wrote:
> On Wed, Jan 29, 2020 at 10:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > The I2C fix for this is in Wolfram's tree already:
> 
> It was never an i2c error.
> 
> It was an error in that commit that made a change that introduced a new warning.
> 
> It is *not* acceptable to break things and say "somebody else will fix
> it up later".
> 
> If it's broken in the PHY tree, then the PHY tree is broken. It's that simple.
> 
> We don't enable compile testing that causes warnings.

I never said it was an I2C error but only that the fix is there already.
The error in first place was mine because I did not spot the
bisectability problem when preparing the entire set of
compile-testing patches.

Best regards,
Krzysztof

