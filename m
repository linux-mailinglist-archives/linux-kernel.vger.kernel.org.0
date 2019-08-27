Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6859DC97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 06:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfH0EZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 00:25:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39761 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0EZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 00:25:11 -0400
Received: by mail-io1-f66.google.com with SMTP id l7so43150602ioj.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50AsWxywlUQnTpKVGriNJYvkgwgK3KTBsrNIGfbmuJg=;
        b=dBANGAYWISHTeTavGx+Oq+JztZ48oyMY2VNfywPY9FNaLGhDilAJBBa4FDN/CblBCA
         zxO77qI8sPK4WdvgpCDRmw+ggpkCe8mUbFN7zWIUiPn+g1FRFnww5a5I+8rVjt94fMCk
         cF5jjlpMTS622rv8B3yEVKE9kiP+HhHk6sEYqTKkpfibJBPQy4E5+/qU6fbG/Th8K0GN
         HMM88LSvNR7JV1Xw3YqOhAZGcdoPHETjZTGvp5b/27VnaX3ZRapVP13/GPcE9BW8ZYyo
         vZJaiaU27pcaZXAZV6SaY6eSF+dDIKaHpV5HeY/YNxyVlUu7c4ZVrQ4gbUn2FrdqNCGM
         OtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50AsWxywlUQnTpKVGriNJYvkgwgK3KTBsrNIGfbmuJg=;
        b=Y418tTIFwu02x9ejKyHkVBt5D2at76E53ndieyWf9Z8xHAcsNRLU8wrlIghl5VJ8Ee
         IuwtlLuRyVk8qe0hpH8moj8MhXpOSXt6hlxTj7Ion2xxchb1cnMAkJON2bYBGtYk55Lf
         8ICMKcGmWKT/PCOz+Pk307CMspOl/E87qyd8tlFedO1WynMVZxyvUEWEih6mLtjYekhe
         y6OGwdaYHTqFS07ndc5F/G2g/oQRII5/rqZq0fwpao1Q6fQ0QPuDwMY1Z4v1RTIeqRjS
         Gg48L2/swKdi5ZxPHaGBn5f6RwSDc8zKz8x5l62xEjQ4o4Dz4FUV5KM7n8EU7FoglMdp
         0UoA==
X-Gm-Message-State: APjAAAWEzWRFnVHc6XzglqJxRh/ewxxVbRmiP3HqL1cD4fmqSIr0OX6c
        +5AR+IRQQneGeQ1yFo5ZBSBMQ+7bZng+6GVN/w595eT87zg=
X-Google-Smtp-Source: APXvYqwAnYBYhGBIk4q1AhmMKkEfDX6WoyU27/d93CGIhu/pT4/AweH1krcpzwa0imyijNZtlQVuRIyyogHdeMtIxxM=
X-Received: by 2002:a02:654d:: with SMTP id u74mr21888139jab.115.1566879910001;
 Mon, 26 Aug 2019 21:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190826182524.5064-1-andrew.smirnov@gmail.com> <20190826220807.GK5031@pendragon.ideasonboard.com>
In-Reply-To: <20190826220807.GK5031@pendragon.ideasonboard.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Aug 2019 21:24:57 -0700
Message-ID: <CAHQ1cqHuJNTH=HDfEP9de0Df_D45VV034riH4J3+ix23v=aM4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: tc358767: Expose test mode functionality via debugfs
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 3:08 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Andrey,
>
> Thank you for the patch.
>
> On Mon, Aug 26, 2019 at 11:25:24AM -0700, Andrey Smirnov wrote:
> > Presently, the driver code artificially limits test pattern mode to a
> > single pattern with fixed color selection. It being a kernel module
> > parameter makes switching "test patter" <-> "proper output" modes
> > on-the-fly clunky and outright impossible if the driver is built into
> > the kernel.
> >
> > To improve the situation a bit, convert current test pattern code to
> > use debugfs instead by exposing "TestCtl" register. This way old
> > "tc_test_pattern=1" functionality can be emulated via:
> >
> >     echo -n 0x78146312 > tstctl
> >
> > and switch back to regular mode can be done with:
> >
> >     echo -n 0x78146310 > tstctl
>
> Can't we make this more userfriendly by exposing either a test pattern
> index, or a string ?

We could, but then a) it would require more code in the driver b) the
files wouldn't correspond directly to something described in the
part's datasheet. Just didn't seem worth it to me.

> Do all bits in the register need to be controlled
> from userspace ?

Pretty much, yes. It's formatted as RR_GG_BB_X_M, where R, G, B
specifies color used for various patterns, X is irrelevant and M
specifies test pattern to use.

>
> > Note that switching to any of the test patterns, will NOT trigger link
> > re-establishment whereas switching to normal operation WILL. This is
> > done so:
> >
> > a) we can isolate and verify (e)DP link functionality by switching to
> >    one of the test patters
> >
> > b) trigger a link re-establishment by switching back to normal mode
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 137 ++++++++++++++++++++++--------
> >  1 file changed, 101 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index 6308d93ad91d..7a795b613ed0 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -17,6 +17,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/device.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> > @@ -222,11 +223,10 @@
> >  #define COLOR_B                      GENMASK(15, 8)
> >  #define ENI2CFILTER          BIT(4)
> >  #define COLOR_BAR_MODE               GENMASK(1, 0)
> > +#define COLOR_BAR_MODE_NORMAL        0
> >  #define COLOR_BAR_MODE_BARS  2
> > -#define PLL_DBG                      0x0a04
> >
> > -static bool tc_test_pattern;
> > -module_param_named(test, tc_test_pattern, bool, 0644);
>
> I assume that his being a debug feature there's no system relying on the
> module parameter that would break if you remove it ?
>

Yeah, I don't know of any system that needs that parameter. It seems
pretty useless for anything but basic debugging.

> > +#define PLL_DBG                      0x0a04
> >
> >  struct tc_edp_link {
> >       struct drm_dp_link      base;
> > @@ -789,16 +789,6 @@ static int tc_set_video_mode(struct tc_data *tc,
> >       if (ret)
> >               return ret;
> >
> > -     /* Test pattern settings */
> > -     ret = regmap_write(tc->regmap, TSTCTL,
> > -                        FIELD_PREP(COLOR_R, 120) |
> > -                        FIELD_PREP(COLOR_G, 20) |
> > -                        FIELD_PREP(COLOR_B, 99) |
> > -                        ENI2CFILTER |
> > -                        FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
> > -     if (ret)
> > -             return ret;
> > -
> >       /* DP Main Stream Attributes */
> >       vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
> >       ret = regmap_write(tc->regmap, DP0_VIDSYNCDELAY,
> > @@ -1150,14 +1140,6 @@ static int tc_stream_enable(struct tc_data *tc)
> >
> >       dev_dbg(tc->dev, "enable video stream\n");
> >
> > -     /* PXL PLL setup */
> > -     if (tc_test_pattern) {
> > -             ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
> > -                                 1000 * tc->mode.clock);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > -
> >       ret = tc_set_video_mode(tc, &tc->mode);
> >       if (ret)
> >               return ret;
> > @@ -1186,12 +1168,8 @@ static int tc_stream_enable(struct tc_data *tc)
> >       if (ret)
> >               return ret;
> >       /* Set input interface */
> > -     value = DP0_AUDSRC_NO_INPUT;
> > -     if (tc_test_pattern)
> > -             value |= DP0_VIDSRC_COLOR_BAR;
> > -     else
> > -             value |= DP0_VIDSRC_DPI_RX;
> > -     ret = regmap_write(tc->regmap, SYSCTRL, value);
> > +     ret = regmap_write(tc->regmap, SYSCTRL,
> > +                        DP0_AUDSRC_NO_INPUT | DP0_VIDSRC_DPI_RX);
> >       if (ret)
> >               return ret;
> >
> > @@ -1220,39 +1198,44 @@ static void tc_bridge_pre_enable(struct drm_bridge *bridge)
> >       drm_panel_prepare(tc->panel);
> >  }
> >
> > -static void tc_bridge_enable(struct drm_bridge *bridge)
> > +static int __tc_bridge_enable(struct tc_data *tc)
> >  {
> > -     struct tc_data *tc = bridge_to_tc(bridge);
> >       int ret;
> >
> >       ret = tc_get_display_props(tc);
> >       if (ret < 0) {
> >               dev_err(tc->dev, "failed to read display props: %d\n", ret);
> > -             return;
> > +             return ret;
> >       }
> >
> >       ret = tc_main_link_enable(tc);
> >       if (ret < 0) {
> >               dev_err(tc->dev, "main link enable error: %d\n", ret);
> > -             return;
> > +             return ret;
> >       }
> >
> >       ret = tc_stream_enable(tc);
> >       if (ret < 0) {
> >               dev_err(tc->dev, "main link stream start error: %d\n", ret);
> >               tc_main_link_disable(tc);
> > -             return;
> >       }
> >
> > -     drm_panel_enable(tc->panel);
> > +     return ret;
> >  }
> >
> > -static void tc_bridge_disable(struct drm_bridge *bridge)
> > +static void tc_bridge_enable(struct drm_bridge *bridge)
> >  {
> >       struct tc_data *tc = bridge_to_tc(bridge);
> > -     int ret;
> >
> > -     drm_panel_disable(tc->panel);
> > +     if (__tc_bridge_enable(tc) < 0)
> > +             return;
> > +
> > +     drm_panel_enable(tc->panel);
> > +}
> > +
> > +static int __tc_bridge_disable(struct tc_data *tc)
> > +{
> > +     int ret;
> >
> >       ret = tc_stream_disable(tc);
> >       if (ret < 0)
> > @@ -1261,6 +1244,16 @@ static void tc_bridge_disable(struct drm_bridge *bridge)
> >       ret = tc_main_link_disable(tc);
> >       if (ret < 0)
> >               dev_err(tc->dev, "main link disable error: %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static void tc_bridge_disable(struct drm_bridge *bridge)
> > +{
> > +     struct tc_data *tc = bridge_to_tc(bridge);
> > +
> > +     drm_panel_disable(tc->panel);
> > +     __tc_bridge_disable(tc);
> >  }
> >
> >  static void tc_bridge_post_disable(struct drm_bridge *bridge)
> > @@ -1372,6 +1365,77 @@ static enum drm_connector_status tc_connector_detect(struct drm_connector *conne
> >               return connector_status_disconnected;
> >  }
> >
> > +static int tc_tstctl_set(void *data, u64 val)
> > +{
> > +     struct tc_data *tc = data;
> > +     int ret;
> > +
> > +     if (FIELD_GET(COLOR_BAR_MODE, val) == COLOR_BAR_MODE_NORMAL) {
> > +             ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_DPI_RX);
> > +             if (ret) {
> > +                     dev_err(tc->dev,
> > +                             "failed to select dpi video stream\n");
> > +                     return ret;
> > +             }
> > +
> > +             ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
> > +             if (ret) {
> > +                     dev_err(tc->dev, "failed to set TSTCTL\n");
> > +                     return ret;
> > +             }
> > +
> > +             ret = tc_pxl_pll_dis(tc);
> > +             if (ret) {
> > +                     dev_err(tc->dev, "failed to disable PLL\n");
> > +                     return ret;
> > +             }
> > +
> > +             /*
> > +              * Re-establish DP link
> > +              */
> > +             ret = __tc_bridge_disable(tc);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret = __tc_bridge_enable(tc);
> > +             if (ret)
> > +                     return ret;
>
> If the bridge is currently disabled you should not enable it. I think
> you need to guard against race conditions with the enable/disable
> functions, as well as delay writes until the bridge gets enabled if it
> is currently disabled.
>

OK, will do in v2.

> > +     } else {
> > +             ret = tc_pxl_pll_en(tc, clk_get_rate(tc->refclk),
> > +                                 1000 * tc->mode.clock);
> > +             if (ret) {
> > +                     dev_err(tc->dev, "failed to enable PLL\n");
> > +                     return ret;
> > +             }
> > +
> > +             ret = regmap_write(tc->regmap, TSTCTL, val | ENI2CFILTER);
> > +             if (ret) {
> > +                     dev_err(tc->dev, "failed to set TSTCTL\n");
> > +                     return ret;
> > +             }
> > +
> > +             ret = regmap_write(tc->regmap, SYSCTRL, DP0_VIDSRC_COLOR_BAR);
> > +             if (ret) {
> > +                     dev_err(tc->dev, "failed to color bar video stream\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_SIMPLE_ATTRIBUTE(tc_tstctl_fops, NULL, tc_tstctl_set, "%llu\n");
>
> Shouldn't you also provide a get handler ?

There really isn't a use-case for reading the value of TestCtl AFAICT,
so, I skipped it to avoid having extra code.

>
> > +static int tc_late_register(struct drm_connector *connector)
> > +{
> > +     if (connector->debugfs_entry)
> > +             debugfs_create_file_unsafe("tstctl", 0644,
> > +                                        connector->debugfs_entry,
> > +                                        connector_to_tc(connector),
> > +                                        &tc_tstctl_fops);
> > +     return 0;
> > +}
>
> Why a .late_register() handler, can't you do this at probe time ?
>

.late_register() happens after drm_debugfs_connector_add() where
connector->debugfs_entry gets initialized. AFAICT, I could move that
code to probe, but then I'd have create a separate debugfs root
directory as well as add code to clean it up (currently I rely on
drm_debugfs_connector_remove() removing everything recursively.

Thanks,
Andrey Smirnov
