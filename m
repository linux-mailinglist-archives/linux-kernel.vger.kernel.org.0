Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B84BC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfFSPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:06:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41805 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbfFSPGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:06:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so3605914lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CLJF5UoD0PkktcnwFEog1D4I3y+sELYQ4QMuolgvp6s=;
        b=yEAuqHd/teD0bEa7Wvv7EtSMZmX8mb6QsDEE3Aerx0LAnx2E4q6Gw+E4oHeMkrbx4X
         L+xDstCW0A1lRuwgSgfSXAYw+P8g9iFRxygf80S2I3D385MHj3PSi2CAKckN85Rcml/M
         GibXtG1D5ovltPNE9NE9LU3HTHrveAE9Y2fReaVv2Gb9J4bLzc9RbfZnHJrhUjp8Gu4z
         j0P7DZ1TPe0OjdPmch+r7FGd7w0u69YMAmiqJ9fpNqsS3DWd8X9mG8TlP+DXaTKcVDhI
         aNbhxe/mhawugb1K+RNV+ZFx1xApKMhMXwOVZIL8ylN8hNFDdEHyThk8HvrWIzdbfzbZ
         xFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CLJF5UoD0PkktcnwFEog1D4I3y+sELYQ4QMuolgvp6s=;
        b=XQY1VUxraAb97dMR/D14AqYzQLghNSQMZKq4/uSUOztdWb7wf+gfqqXV2ZbUssGVFc
         9PXTQm93XsnfhqY2lb0FUEjZd20681i90fDrcyc9TZMBvlqhEy/BWLPjj5Xs5QKU38JN
         GHYfQV89kcs+fJTPFzeP7Rk/n4Ba9kVsumsH0KNZF3X0nFdEMpYsuRTRE85gfPMyfNmd
         WscsxY3FHzvrwYP1vKoXI8ZZizr3zOgdhC+9q5mXI4M1Bupxu8FfAFxW/FVCRCUdmX9Z
         fwymim9aPC6MvbZXgVUMv7v8mtrPhXpjdzBNTDA/yl0kYnmhJp5w8DbVV8/6ouYf3NjE
         JTHQ==
X-Gm-Message-State: APjAAAUovMlFmtUY9ZFjQ/Xx2aJP/Z6KFThrT6aHmD+autbfD1QDn8Sh
        j2L0iGL6WVaw0/rejfpSChKaIQ==
X-Google-Smtp-Source: APXvYqyMLO96BhAhlytIE+Ka8kFdXOnwnlt/Y3Ev1WHd9s/vwbPB0/i4dHhJQ2MiOCAxa7GBxsCb+A==
X-Received: by 2002:a2e:9155:: with SMTP id q21mr35693704ljg.198.1560956763090;
        Wed, 19 Jun 2019 08:06:03 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id t12sm3132540ljj.26.2019.06.19.08.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:06:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:12:30 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3] ARM: configs: Remove useless UEVENT_HELPER_PATH
Message-ID: <20190619141230.rtgeunr23gybv7u2@localhost>
References: <20190604185229.7393-1-krzk@kernel.org>
 <CAJKOXPd4LVFGgonbsuxii-5Fu5wWhxU9yotLHw+OXsPcxYw_3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPd4LVFGgonbsuxii-5Fu5wWhxU9yotLHw+OXsPcxYw_3g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:53:53PM +0200, Krzysztof Kozlowski wrote:
> On Tue, 4 Jun 2019 at 20:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Remove the CONFIG_UEVENT_HELPER_PATH because:
> > 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
> >    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
> >    made default to 'n',
> > 2. It is not recommended (help message: "This should not be used today
> >    [...] creates a high system load") and was kept only for ancient
> >    userland,
> > 3. Certain userland specifically requests it to be disabled (systemd
> >    README: "Legacy hotplug slows down the system and confuses udev").
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > For vexpress:
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > ---
> >
> > Changes since v2:
> > 1. Remove unrelated files.
> > 2. Add Geert's ack.
> >
> > Changes sice v3:
> > 1. Change also mini2440_defconfig.
> > 2. Add more acks.
> 
> Hi Arnd and Olof,
> 
> Do you want to apply it directly or maybe I can send it along with
> other my defconfig pull request?

Oh, just saw v3, since it didn't thread with v2.

Applied already with the equivalent fixups, so we're good.

-Olof
