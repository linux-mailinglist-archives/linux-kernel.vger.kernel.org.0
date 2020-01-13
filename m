Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604B2138FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgAMLSB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jan 2020 06:18:01 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52061 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbgAMLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:18:01 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19860154-1500050 
        for multiple; Mon, 13 Jan 2020 11:17:55 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200113111025.2048-1-wambui.karugax@gmail.com>
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200113111025.2048-1-wambui.karugax@gmail.com>
Message-ID: <157891427231.27314.12398974277241668021@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: convert to new logging macros based on struct
 intel_engine_cs.
Date:   Mon, 13 Jan 2020 11:17:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wambui Karuga (2020-01-13 11:10:25)
> fn(...) {
> ...
> struct intel_engine_cs *E = ...;
> +struct drm_i915_private *dev_priv = E->i915;

No new dev_priv.

There should be no reason for drm_dbg here, as the rest of the debug is
behind ENGINE_TRACE and so the vestigial debug should be moved over, or
deleted as not being useful.

The error messages look unhelpful.

>                 if ((batch_end - cmd) < length) {
> -                       DRM_DEBUG("CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",
> -                                 *cmd,
> -                                 length,
> -                                 batch_end - cmd);
> +                       drm_dbg(&dev_priv->drm,
> +                               "CMD: Command length exceeds batch length: 0x%08X length=%u batchlen=%td\n",

No. This is not driver debug. If anything this should be pr_debug, or
some over user centric channel.
-Chris
