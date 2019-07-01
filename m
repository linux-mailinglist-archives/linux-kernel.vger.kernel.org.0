Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44E4DC45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFTVMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 17:12:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34248 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfFTVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:12:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so6721692edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=959ru36WY2J0Xrly1vs1MXuZnqXsrreyoL0xoecTXQA=;
        b=ZyyEIWc8g9qNg4ofLToKGhgAmro8fi/qsiplRDzzYnsQzgUBFe4c86Ee/wR4SebDjt
         d63ZPlgcJxB1wYNf1eIPn3M3bB13fdEww4NsSF+uA3/ahauLDZUM1S12sFjWLoIzrkEq
         HMbsASyI+4J0m7OfyVxoUW085H+KZiQlel8eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=959ru36WY2J0Xrly1vs1MXuZnqXsrreyoL0xoecTXQA=;
        b=URh/gwvwsoY2BNopFro0qh4euMmoGsJ4WnfowCRDhEsmBChDdBj+3HCS4RxPZaTN30
         Tz0E+xrCw5xWVooqNXOzDFKrYeiHt0N+AGpLjxcPjoriN4WL9trC88tCqidlzBaznGe2
         SfxKSxUVDX3JJIuv92pvTavOSe++NIXpqZle79svoKSN1wMDOVn74wbfWr8owtkm5t2R
         SD1dPKhkXELHBXGOz+Wl0+ybxUViz1+uUbDn4UvzaBgMZMK3t3sYR5E8UbpgwBSW+BZA
         p4etMDt2XC4HgE9IdGUqTuz/ff/tG3hi3pAhAt8WC2Rlh3oc2OyZhI2RWAJ1n1LL7P90
         disQ==
X-Gm-Message-State: APjAAAW35sOgxM+Z+mdlAiqdE/WmhFvSOPzP7lIn6uayrnK50YPp+M6Z
        wyGufnB5RfoNom1IcH3YCtMBBw==
X-Google-Smtp-Source: APXvYqx3EnsHuhcIFTP2RIslvwoM3AQZ6N+bN+bCoN37PG+nA2hCPhd0nIWscWNoh843HbyPEoTJjw==
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr98153366ejb.130.1561065130725;
        Thu, 20 Jun 2019 14:12:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p18sm76849ejr.61.2019.06.20.14.12.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:12:09 -0700 (PDT)
Date:   Thu, 20 Jun 2019 23:12:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        linux-media@vger.kernel.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Dariusz Marcinkiewicz <darekm@google.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/7] video: add HDMI state notifier support
Message-ID: <20190620211204.GW12905@phenom.ffwll.local>
Mail-Followup-To: Cheng-yi Chiang <cychiang@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        linux-media@vger.kernel.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Dariusz Marcinkiewicz <darekm@google.com>
References: <20190603080931.GG21222@phenom.ffwll.local>
 <CAFv8Nw+1sB8i1d87vLeKxRricZOi4gnXFSgOzW9k0sa_Tzybjg@mail.gmail.com>
 <20190604072411.GP21222@phenom.ffwll.local>
 <CAFv8NwKL9ZL=gNpDmdRV+R9eq22+Da_1kzuYBv8kMMyV3Hq14g@mail.gmail.com>
 <20190611123455.GD2458@phenom.ffwll.local>
 <CAFv8NwJxs-R=ehgeqyx=e+T5OmUBsk3uWnUb2t0cC-LDPS7G5w@mail.gmail.com>
 <20190618121220.GU12905@phenom.ffwll.local>
 <CAFv8NwLci2ALi3V-e=8jjatciHWOoOj-FeajwNLWRpWRtqgBdg@mail.gmail.com>
 <20190620092506.GP12905@phenom.ffwll.local>
 <CAFv8NwLbS_f4cfeorzqtmRzQSY0u1tgM7fitAokg_QfViPvq=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv8NwLbS_f4cfeorzqtmRzQSY0u1tgM7fitAokg_QfViPvq=Q@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Massively cutting this thread, since halfway through in my previous reply
I realized that maybe hdmi_codec is a much better starting point.

On Thu, Jun 20, 2019 at 09:23:23PM +0800, Cheng-yi Chiang wrote:
> On Thu, Jun 20, 2019 at 5:25 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > Yeah fully agreeing that hdmi_audio_code is probably a better starting
> > point. Problem is that becuase hdmi_codec is built on top of platform
> > device it's quite a bit harder to extend with callbacks and things like
> > that, without breaking the driver model.
> >
> > I need to think about this more, but if all we need to look at is
> > hdmi_codec, then I think this becomes a lot easier. And we can ignore
> > drm_audio_component.h completely.
> 
> 
> It is surprising that you think this way.
> Maybe the original patch before hdmi-notifier was introduced is the
> better way to solve this issue, if we only need to look at hdmi_codec.
> 
> The history of hdmi_codec driver is in this patch series:
> 
> https://lore.kernel.org/patchwork/patch/539656/

Hm, this doesn't seem to be the hdmi_codec driver I meant, but another,
new one. I was talking about SND_SOC_HDMI_CODEC.

> There was a callback mechanism implemented between dw-hdmi and hdmi
> codec driver.
> It was later consolidated by Doug in this patch for better jack status
> reporting:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/303573/

Hm that still seems entirely separate hdmi-codec specific to dw-hdmi only
...

> I am not sure why the original patch series did not get fully accepted
> in the upstream.
> It was quite long time ago.
> 
> But if you think this might be the right way to do, then it is even
> better for us because the patch series and Doug's patch had been quite
> stable
> on our RK3288 products for about four years with plenty of users, so
> we have much higher confidence in them.
> I can rebase and clean up them and post another patch for review.
> 
> Please let me know what approach you feel is better.
> Thanks again!

Not sure we're talking about the same. What I had in mind is to add jack
status to the hdmi-codec.c stuff, which is used by multiple soc drm
display drivers already. Looking at git grep output, there seems to be
already some support for dw-hdmi synopsys drm_bridge driver. I thought of
extending that. Does that not work for you?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
