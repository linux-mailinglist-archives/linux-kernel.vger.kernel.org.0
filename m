Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637ECE9C08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 14:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfJ3NHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 09:07:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:31723 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3NHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:07:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:07:42 -0700
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="193962381"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:07:39 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chris Chiu <chiu@endlessm.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        ville.syrjala@linux.intel.com
Subject: Re: Unexpected screen flicker during i915 initialization
In-Reply-To: <CAB4CAwcMqyOLJFPcVyoGuiXo-ujeyzL2TJkpZ3qAc1HymJ2x7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAB4CAwcMqyOLJFPcVyoGuiXo-ujeyzL2TJkpZ3qAc1HymJ2x7A@mail.gmail.com>
Date:   Wed, 30 Oct 2019 15:07:34 +0200
Message-ID: <87o8xy8jqh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019, Chris Chiu <chiu@endlessm.com> wrote:
> Hi guys,
>     We have 2 laptops, ASUS Z406MA and Acer TravelMate B118, both
> powered by the same Intel N5000 GemniLake CPU. On the Acer laptop, the
> panel will blink once during boot which never happens on the ASUS
> laptop. It caught my attention and I find the difference between them
> but I need help for more information,
>
>     The major difference happens in bxt_sanitize_cdclk() on the
> following condition check.
>         if (cdctl == expected)
>                 /* All well; nothing to sanitize */
>                 return;
>
>     On the problematic Acer laptop, the value of cdctl is 0x27a while
> the same cdctl is 0x278 on ASUS machine. Due to the 0x27a is not equal
> to the expected value 0x278 so it needs to be sanitized by assigning
> -1 to  dev_priv->cdclk.hw.vco. Then the consequent bxt_set_cdclk()
> will force the full PLL disable and enable. And that's the flicker
> (blink) we observed during boot.
>
>     Although I can't find the definition about the BIT(2) of CDCLK_CTL
> which cause this difference. Can anyone suggest what exactly the
> problem is and how should we deal with it? Thanks.

The 11 least significant bits of that register are the cdclk frequency
in 10.1 fixed point format. Apparently the Acer BIOS or GOP has a
different idea of how to calculate the value from what i915 and the Asus
think.

To handle this in i915, we'd need to allow some deviation from the
expected value, and only switch to use our value at the next modeset. We
do need the sanitization though, because sometimes there have been
completely bogus values to begin with.

Please file a bug over at [1] and reference this thread.

BR,
Jani.


[1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel


-- 
Jani Nikula, Intel Open Source Graphics Center
