Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3238253
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfFGAyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 20:54:38 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:34223 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFGAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:54:37 -0400
Received: by mail-qk1-f176.google.com with SMTP id t64so289814qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nl0stj+fpa79AUdKrN20GwskOwyXB8flj8/J8tcfdAI=;
        b=A17En6qpbxIQAIE/fV53WSsBRZWq7ZzWsc6I2S1KyVklZwCY3//LJA/NWfPiVZowQA
         aoJTKD+VSGYybMEN2ggvD9zRJJVllVKtNjHNyJ13o0ci+QwkQHf1WJz5LXYNWdPSfF+7
         xQG7MkC0Z3WYopvgAH7N4ionVRrj92snkj/P/ST01m/52MnnVxypl3Sodcg4jlgBLQ3m
         12fk8WoJr+Uc9qg5YsE+QgqbyVYwCv4ULI9ocDObsjFkEt0ffbB+opXncnUgKTgERM6K
         6QbxjAO55OEOGH9slRHeF1aodnZcJZBHe/3Y5P8u9wzcVSRSgGjyn7trvp/BQpooGQQ7
         Jhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nl0stj+fpa79AUdKrN20GwskOwyXB8flj8/J8tcfdAI=;
        b=mk8PYlQh/zZa69MGzikuyAcqRnQ3su/c181/hRGl0rw47dLTIBhVk3sEBQ/QKGpiGc
         unA8ZWZA4tFeoMqKR1KzMVO/b/1icQqYNLB3eh0ignsckXVHuEMV9308c2soXnTFaEH1
         FViHFYssuiKgVfu+81wRvS+tFCR6cUgRNIQin0ULR6L00LkasNavi6TLOhHXUHCazqfI
         nFO+W0fLsHK1CglHUDtmHj+tdN2LJLPtKtHrEtGJtJNBPMebhlOesvNUfAuOSEqLiFu4
         fy2KL5y87uYcrxMAVyFUonQdhw2/dwclbwFiA+5JCZU1W/0Jt1P4HPSoRubqOhFSRmeq
         akHg==
X-Gm-Message-State: APjAAAWk+vSCZRdrDiKPhtdc41yUwtklEccFgLj1ogUyb4vkUX3PK3w6
        5c1wPgLbK4XEUtQ8oRWc2VlY+y1ugxNSeO3yVCo=
X-Google-Smtp-Source: APXvYqxtrRdvYZ4JK7ZoHE7LPC5eOI7CvIl8kNDarGPrIB+VHD2mPrqUBjE/NpkcJoKKC5yjdVYoWF21w+Xxl6irHko=
X-Received: by 2002:a37:6b07:: with SMTP id g7mr41214192qkc.217.1559868876170;
 Thu, 06 Jun 2019 17:54:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Jun 2019 10:54:25 +1000
Message-ID: <CAPM=9tx4SOKLnRvYzYksuF8M231aUgXA4d-qEP_Ds-0UcA1=4Q@mail.gmail.com>
Subject: 
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

A small bit more lively this week but not majorly so. I'm away in
Japan next week for family holiday, so I'll be pretty disconnected,
I've asked Daniel to do fixes for the week while I'm out.

core:
- Allow fb changes in async commits (drivers as well)

udmabuf:
- Unmap scatterlist when unmapping udmabuf

komeda:
- oops, dma mapping and warning fixes

arm-hdlcd:
- clock fixes,
- mode validation fix

i915:
- Add a missing Icelake workaround
- GVT - DMA map fault fix and enforcement fixes

Dave.
amdgpu:
- DCE resume fix
- New raven variation updates



drm-fixes-2019-06-07:
drm i915, amdgpu, arm display, atomic update fixes
The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-06-07

for you to fetch changes up to e659b4122cf9e0938b80215de6c06823fb4cf796:

  Merge tag 'drm-intel-fixes-2019-06-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-06-07
10:41:33 +1000)

----------------------------------------------------------------
drm i915, amdgpu, arm display, atomic update fixes

----------------------------------------------------------------
Aleksei Gimbitskii (2):
      drm/i915/gvt: Check if cur_pt_type is valid
      drm/i915/gvt: Assign NULL to the pointer after memory free.

Chengming Gui (1):
      drm/amd/powerplay: add set_power_profile_mode for raven1_refresh

Colin Xu (3):
      drm/i915/gvt: Update force-to-nonpriv register whitelist
      drm/i915/gvt: Fix GFX_MODE handling
      drm/i915/gvt: Fix vGPU CSFE_CHICKEN1_REG mmio handler

Dan Carpenter (1):
      drm/komeda: Potential error pointer dereference

Dave Airlie (5):
      Merge tag 'drm-intel-fixes-2019-06-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-06-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'malidp-fixes' of git://linux-arm.org/linux-ld into drm-fixes
      Merge tag 'drm-intel-fixes-2019-06-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Gao, Fred (1):
      drm/i915/gvt: Fix cmd length of VEB_DI_IECP

Helen Koike (5):
      drm/rockchip: fix fb references in async update
      drm/amd: fix fb references in async update
      drm/msm: fix fb references in async update
      drm/vc4: fix fb references in async update
      drm: don't block fb changes for async plane updates

Joonas Lahtinen (2):
      Merge tag 'gvt-fixes-2019-05-30' of
https://github.com/intel/gvt-linux into drm-intel-fixes
      Merge tag 'gvt-fixes-2019-06-05' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Louis Li (1):
      drm/amdgpu: fix ring test failure issue during s3 in vce 3.0 (V2)

Lowry Li (Arm Technology China) (1):
      drm/komeda: fixing of DMA mapping sg segment warning

Lucas Stach (1):
      udmabuf: actually unmap the scatterlist

Prike Liang (1):
      drm/amd/amdgpu: add RLC firmware to support raven1 refresh

Robin Murphy (2):
      drm/arm/hdlcd: Actually validate CRTC modes
      drm/arm/hdlcd: Allow a bit of clock tolerance

Tina Zhang (1):
      drm/i915/gvt: Initialize intel_gvt_gtt_entry in stack

Tvrtko Ursulin (1):
      drm/i915/icl: Add WaDisableBankHangMode

Weinan Li (1):
      drm/i915/gvt: add F_CMD_ACCESS flag for wa regs

Wen He (1):
      drm/arm/mali-dp: Add a loop around the second set CVAL and try 5 times

Xiaolin Zhang (1):
      drm/i915/gvt: save RING_HEAD into vreg when vgpu switched out

Xiong Zhang (1):
      drm/i915/gvt: refine ggtt range validation

YueHaibing (1):
      drm/komeda: remove set but not used variable 'kcrtc'

james qian wang (Arm Technology China) (1):
      drm/komeda: Constify the usage of komeda_component/pipeline/dev_funcs

 drivers/dma-buf/udmabuf.c                          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 15 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h             |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 12 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |  1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 31 +++++++++++--
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 +
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |  8 ++--
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |  4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  6 ++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  8 ++--
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  4 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   | 10 ++---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  4 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 14 +++---
 drivers/gpu/drm/arm/malidp_drv.c                   | 13 +++++-
 drivers/gpu/drm/drm_atomic_helper.c                | 22 +++++-----
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     | 38 +++++++++++-----
 drivers/gpu/drm/i915/gvt/handlers.c                | 49 ++++++++++++++++++---
 drivers/gpu/drm/i915/gvt/reg.h                     |  2 +
 drivers/gpu/drm/i915/gvt/scheduler.c               | 25 +++++++++++
 drivers/gpu/drm/i915/gvt/scheduler.h               |  1 +
 drivers/gpu/drm/i915/i915_reg.h                    |  3 ++
 drivers/gpu/drm/i915/intel_workarounds.c           |  6 +++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  4 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 51 +++++++++++-----------
 drivers/gpu/drm/vc4/vc4_plane.c                    |  2 +-
 include/drm/drm_modeset_helper_vtables.h           |  8 ++++
 33 files changed, 268 insertions(+), 99 deletions(-)
