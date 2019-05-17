Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004CC219DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfEQOcu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 May 2019 10:32:50 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63692 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728887AbfEQOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:32:49 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16590567-1500050 
        for multiple; Fri, 17 May 2019 15:32:37 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190517140617.31187-1-janusz.krzysztofik@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
References: <20190517140617.31187-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <155810355587.12244.1572259791791116662@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] drm/i915: Tolerate file owned GEM contexts on hot unbind
Date:   Fri, 17 May 2019 15:32:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-05-17 15:06:17)
> From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
> 
> During i915_driver_unload(), GEM contexts are verified restrictively
> inside i915_gem_fini() if they don't consume shared resources which
> should be cleaned up before the driver is released.  If those checks
> don't result in kernel panic, one more check is performed at the end of
> i915_gem_fini() which issues a WARN_ON() if GEM contexts still exist.

Just fix the underlying bug of this code being called too early. The
assumptions we made for unload are clearly invalid when applied to
unbind, and we need to split the phases.
-Chris
