Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659F86467E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfGJMsF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Jul 2019 08:48:05 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53151 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727303AbfGJMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:48:05 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17199471-1500050 
        for multiple; Wed, 10 Jul 2019 13:47:10 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Micha=C5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190710123631.26575-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <156276282845.11940.4812142560907762693@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH 0/6] Rename functions to match their entry points
Date:   Wed, 10 Jul 2019 13:47:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-07-10 13:36:25)
> Need for this was identified while working on split of driver unbind
> path into _remove() and _release() parts.  Consistency in function
> naming has been recognized as helpful when trying to work out which
> phase the code is in.
> 
> What I'm still not sure about is desired depth of that modification -
> how deep should we go down with renaming to not override meaningfull
> function names.  Please advise if you think still more deep renaming
> makes sense.

I did a double take over "driver_release" but by the end I was in
agreement.

The early_release though, that is worth a bit of artistic license to say
early_probe pairs with late_release.
-Chris
