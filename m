Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCC6521C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfGKGze convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Jul 2019 02:55:34 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:54366 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727479AbfGKGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:55:33 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17214703-1500050 
        for multiple; Thu, 11 Jul 2019 07:55:08 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190711065001.26664-1-janusz.krzysztofik@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Micha=C5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190711065001.26664-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <156282810561.12388.3170839936247979239@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] drm/i915: Drop extern qualifiers from header function
 prototypes
Date:   Thu, 11 Jul 2019 07:55:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-07-11 07:50:01)
> Follow dim checkpatch recommendation so it doesn't complain on that now
> and again on header file modifications.
> 
> v2: Drop testing leftover
> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

I'm not sure the entire cc wants to see extern header churn.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
