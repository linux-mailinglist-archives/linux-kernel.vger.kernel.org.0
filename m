Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7863197
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 09:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGIHE0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Jul 2019 03:04:26 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55405 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbfGIHE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:04:26 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17179194-1500050 
        for multiple; Tue, 09 Jul 2019 08:04:07 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     =?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190709065800.2354-1-janusz.krzysztofik@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Micha=C5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190709065800.2354-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <156265584538.9375.16081841013219935184@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Fix reporting of size of created GEM object
Date:   Tue, 09 Jul 2019 08:04:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-07-09 07:58:00)
> Commit e163484afa8d ("drm/i915: Update size upon return from
> GEM_CREATE") (re)introduced reporting of actual size of created GEM
> objects, possibly rounded up on object alignment.  Unfortunately, its
> implementation resulted in a possible use-after-free bug.  The bug has
> been fixed by commit 929eec99f5fd ("drm/i915: Avoid use-after-free in
> reporting create.size") at the cost of possibly incorrect value being
> reported as actual object size.
> 
> Safely restore correct reporting by capturing actual size of created
> GEM object before a reference to the object is put.
> 
> Fixes: 929eec99f5fd ("drm/i915: Avoid use-after-free in reporting create.size")

This doesn't do anything.
-Chris
