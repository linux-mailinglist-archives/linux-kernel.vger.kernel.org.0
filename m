Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FACE17ED13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 01:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCJAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 20:06:24 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:37295 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCJAGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:06:23 -0400
Received: by mail-pj1-f73.google.com with SMTP id d9so680781pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bdQzhDLUPsxOm6QqZ3hLu+lvyMhDWFhXWI3PbzbhChY=;
        b=HL3ZhDns/Fm8Dzrc17UD5zmpwurRv/Q9PXH36tRJTRSymI40PHBq6pcyslCC61Qk+o
         NTwIxD663xAck53Xs+lfHDMiTxRI6gdxZFaCPntKL9ihkQLfJpFyS4+0HsLGlVWBH7Pg
         8i4CXlBg/NfTw5tHfnARzxkHFPNg2sHJsfQrWWs7eu7eS3W2q2qC4oQbG5xiX3h8x6Rn
         gSUQuan0HxAOuJ4bky3oFQTkXOQrGde9rOVTut2edQRTTBbk//IIo/7Rvz7FbfktkYLY
         M7wxm507BXjhQpSQg1Ma4eqvW/YaJxxCwR1xzfg1gGh2jfWtzeB+76Y1PB1cZcC4QAQ1
         15Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bdQzhDLUPsxOm6QqZ3hLu+lvyMhDWFhXWI3PbzbhChY=;
        b=Vm2LpG65mgtH+Eb6qFHN7zPwNJcmJQs5q33qIqcHzI3VkSzijXIN2I4dSS0EunEHCa
         28vk3ChLTuEiem2P4XWf5GFIQT3//Gs+1Fz1hOAdNhKAnuUacEB687Uqjz4T9o58F4PT
         OscoA83qLu/TEt9NChMFgowx+oP4NQwP4skJoRiPHXqhFDf0DJdX9aG7N4MH9n0hInML
         TJSVYFkki2DdCLPA5kujWkAmDEPhXWwwqYJa3XKNe5mqD8DEhwqtQ5jreoga632MGfwn
         I6lqFkW8kFv23UAwVPzqKm4k5ipwzOYxHrYQuU7WUkY4ciVSbUNpb8KYH8uEXxUB+i1W
         F+5A==
X-Gm-Message-State: ANhLgQ1Pvn2DhezgqdJTVjSvRLycz0E6x2LOqhMJngYtHE4wbbEveGTx
        vBENyJGa8w4NQ0jMcBBS60tPVVUEPKYW
X-Google-Smtp-Source: ADFU+vuGQ8fT2JXf1JRD3wm3mul6BK5fRWp/eQfqYaAjUaKocRKkkUmdDfacVg+LSo7TqiBDGChU5mRWRnGn
X-Received: by 2002:a63:f925:: with SMTP id h37mr18801182pgi.103.1583798782458;
 Mon, 09 Mar 2020 17:06:22 -0700 (PDT)
Date:   Mon,  9 Mar 2020 17:06:13 -0700
Message-Id: <20200310000617.20662-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v7 0/4] drm: Add support for integrated privacy screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        "=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?=" <jose.souza@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
        mathewk@google.com, Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>,
        mpearson@lenovo.com, Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds:
 - (Generic) integrated privacy screen support in drm
 - Ability in i915 to attach to ACPI nodes
 - an implmentation for ACPI privacy screen in i915

Rajat Jain (4):
  intel_acpi: Rename drm_dev local variable to dev
  drm/connector: Add support for privacy-screen property
  drm/i915: Lookup and attach ACPI device node for connectors
  drm/i915: Add support for integrated privacy screen

 drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
 drivers/gpu/drm/drm_connector.c               |  56 ++++++
 drivers/gpu/drm/i915/Makefile                 |   3 +-
 drivers/gpu/drm/i915/display/intel_acpi.c     |  28 ++-
 drivers/gpu/drm/i915/display/intel_atomic.c   |   1 +
 .../drm/i915/display/intel_display_types.h    |   5 +
 drivers/gpu/drm/i915/display/intel_dp.c       |  43 ++++-
 .../drm/i915/display/intel_privacy_screen.c   | 175 ++++++++++++++++++
 .../drm/i915/display/intel_privacy_screen.h   |  27 +++
 drivers/gpu/drm/i915/i915_drv.h               |   2 +
 include/drm/drm_connector.h                   |  25 +++
 11 files changed, 365 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_privacy_screen.h

-- 
2.25.1.481.gfbce0eb801-goog

