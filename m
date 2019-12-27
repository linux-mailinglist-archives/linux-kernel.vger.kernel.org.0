Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6BD12BB14
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 21:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfL0UI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 15:08:59 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:33299 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfL0UI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 15:08:59 -0500
Received: by mail-lf1-f41.google.com with SMTP id n25so21402146lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 12:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=H1f1DKFwyHw0Dhp3ttDcFE2jgiDt5bJAsShojhkT1DE=;
        b=Z8dBEsxBYWpSgED9Ej3Y31+deZbiuVcDE0C7ke50kHN1O3H1lHk8byHKImX1twOUNw
         ZTUxJvlarxhksf9VYl/xm4GVGurIcvwbfGBSU6E+R9wyah+IkCGU4puz73X8W6Sjt/EG
         PVE3yQ41/n+ncKcYGUvJGWO1HOYfNJtZorgvA8IuEP+nfHvdPUPV4RBqp1sur5XvC2+0
         lx8Eo5tZhYHYl0WYf8PL9KC98kfS7aCAQcB/4mfAr/xF7MOWmc30PqSku/gfIvlr3Fn8
         ldd/CLVVeOgYz6RE8xx7b1xqdQtLx4aGqm7YUqcXW1UFPqMWDW+qwq5uoUypMVb5cdAQ
         E0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=H1f1DKFwyHw0Dhp3ttDcFE2jgiDt5bJAsShojhkT1DE=;
        b=YDNTyU2GOVHZ1pr5vf3E9OE9oQvhe1mkQfZKnzbl3q5qw4tTAd7v/G3d68FdICTuj1
         gtXEeILWmFlPO2gMIyyYRMyFbF/+orhCYTZWICVz6IQPmfh7GHAU4d0c0VwFhV0rd3HY
         L254v7e8gvezZ+B1iggOYOTsDjPwkkd54nF21aC1PrGJ1UGvN9XU7yma0cn+dV5h5Pxo
         KbG+YNV4geAW8jdJ/QwIAR1x7X2Ed/CCwIBUaCFBgBktLMpatjIeyqnc0EN9Ngb3iJoc
         INenBQ/aDGFhT47hyd+2DeKonX0Ad/Gl0QVr/tPluOVnlO4diNxkA65MEJaI9xPIvfbb
         RC7g==
X-Gm-Message-State: APjAAAUyzFkKC+HKQ8buFo7kRam8HR1+dIkqgb4cEBH4uR63gKy4YIA5
        o26woLNJF/VjuppCONV79BdB3owPmlEPRYy+okmbVCvfQ9o=
X-Google-Smtp-Source: APXvYqxOi5h5Eaizf2pVbR0O3CEGGg7DKGINdC4P1cEfrkTBgiYE1K9RIrYxdh+iO9pMXO6ScdWbjt4yuPHpfXzO9GI=
X-Received: by 2002:ac2:465e:: with SMTP id s30mr30870448lfo.134.1577477336864;
 Fri, 27 Dec 2019 12:08:56 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 28 Dec 2019 06:08:45 +1000
Message-ID: <CAPM=9tzSB+6b0KuXaKfTP_GLpMyBUQheC_L4Nyo4zhygDvixUw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Post-xmas food coma recovery fixes. Only 3 fixes for i915 since I
expect most people are holidaying.

Dave.

drm-fixes-2019-12-28:
drm fixes for 5.5-rc4

i915:
- power management rc6 fix
- framebuffer tracking fix
- display power management ratelimit fix
The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-12-28

for you to fetch changes up to e31d941c7dd797df37ea94958638a88723325c30:

  Merge tag 'drm-intel-fixes-2019-12-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-12-27
13:13:30 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc4

i915:
- power management rc6 fix
- framebuffer tracking fix
- display power management ratelimit fix

----------------------------------------------------------------
Chris Wilson (2):
      drm/i915/gt: Ratelimit display power w/a
      drm/i915: Hold reference to intel_frontbuffer as we track activity

Dave Airlie (1):
      Merge tag 'drm-intel-fixes-2019-12-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Tvrtko Ursulin (1):
      drm/i915/pmu: Ensure monotonic rc6

 drivers/gpu/drm/i915/display/intel_display.c     |  2 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c | 16 ++----
 drivers/gpu/drm/i915/display/intel_frontbuffer.h | 34 ++++++++++-
 drivers/gpu/drm/i915/display/intel_overlay.c     | 17 ++++--
 drivers/gpu/drm/i915/gem/i915_gem_clflush.c      |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c       |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c       | 26 ++++++++-
 drivers/gpu/drm/i915/gem/i915_gem_object.h       | 23 +++++++-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h |  2 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c            |  3 +-
 drivers/gpu/drm/i915/i915_gem.c                  | 10 ++--
 drivers/gpu/drm/i915/i915_pmu.c                  | 73 +++++++-----------------
 drivers/gpu/drm/i915/i915_pmu.h                  |  2 +-
 drivers/gpu/drm/i915/i915_vma.c                  | 10 +++-
 14 files changed, 139 insertions(+), 86 deletions(-)
