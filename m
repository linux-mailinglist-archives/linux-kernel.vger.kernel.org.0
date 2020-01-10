Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEFA137904
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgAJWF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 17:05:57 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:48828 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgAJWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:05:54 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 833F62005F;
        Fri, 10 Jan 2020 23:05:49 +0100 (CET)
Date:   Fri, 10 Jan 2020 23:05:48 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH 0/6] dt-bindings: display: Update few panel bindings with
 YAML
Message-ID: <20200110220548.GB29600@ravnborg.org>
References: <20200101112444.16250-1-jagan@amarulasolutions.com>
 <20200104151702.GC17768@ravnborg.org>
 <CAMty3ZDbDf6YovrEdG0pACQAwMQidjKr6BJvx-FPXqyT11G05w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDbDf6YovrEdG0pACQAwMQidjKr6BJvx-FPXqyT11G05w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=d2ZgxUcwpuBiIAahjgQA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

On Mon, Jan 06, 2020 at 03:41:40PM +0530, Jagan Teki wrote:
> Hi Sam,
> 
> On Sat, Jan 4, 2020 at 8:47 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Jagan.
> > On Wed, Jan 01, 2020 at 04:54:38PM +0530, Jagan Teki wrote:
> > > These panel bindings are owned by me, so updated all of them into
> > > YAML DT schema.
> > >
> > > Any inputs?
> > Thanks for doing the conversion.
> >
> > dt_binding_check was not happy:
> > Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.example.dt.yaml: panel: 'backlight', 'port' do not match any of the regexes: 'pinctrl-[0-9]+'
> >   DTC     Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml
> >   CHECK   Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml
> > Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml: panel: 'backlight', 'port' do not match any of the regexes: 'pinctrl-[0-9]+'
> > Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml: panel: compatible: Additional items are not allowed ('simple-panel' was unexpected)
> > Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.example.dt.yaml: panel: compatible: ['friendlyarm,hd702e', 'simple-panel'] is too long
> >   DTC     Documentation/devicetree/bindings/display/panel/sitronix,st7701.example.dt.yaml
> > Error: Documentation/devicetree/bindings/display/panel/sitronix,st7701.example.dts:22.42-43 syntax error
> > FATAL ERROR: Unable to parse input tree
> >
> > Please fix and check the bindings using dt_binding_check before
> > resubmit.
> >
> > I had to install libyaml-dev (as least I recall this was the name)
> > before dt_binding_check worked OK for me.
> 
> I did check dt_binfing_check with this series. Here is the complete
> build log and you can see the panels related to this series are
> checked fine. Let me know if I miss anything here?

Due to other errors you never reached the poart that checks the example.
I use the following to focus on a single binding:

(from my script, but you get the idea)

domake ${arch} ${config} dt_binding_check DT_SCHEMA_FILES=${bindings}/display/panel/feixin,k101-im2ba02.yaml

In this way I can ignore all the bindings that otherwise fails.

Note: I sometimes have to clean my ouput directory to force that the
examples are tested.

It is also a good idea to introduce errors on purpose in the example, in
this way you can check that they are tested.

	Sam
