Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3130CE0AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfJGLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:39:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:39811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbfJGLjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:39:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 04:39:41 -0700
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="183404878"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 04:39:35 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        lima@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH TRIVIAL v2] gpu: Fix Kconfig indentation
In-Reply-To: <20191004144549.3567-1-krzk@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191004144549.3567-1-krzk@kernel.org>
Date:   Mon, 07 Oct 2019 14:39:33 +0300
Message-ID: <87sgo4hjii.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>  drivers/gpu/drm/i915/Kconfig             |  12 +-
>  drivers/gpu/drm/i915/Kconfig.debug       | 144 +++++++++++------------

Please split these out to a separate patch. Can't speak for others, but
the patch looks like it'll be conflicts galore and a problem to manage
if merged in one big lump.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
