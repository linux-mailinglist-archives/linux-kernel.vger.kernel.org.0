Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7E70831
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfGVSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:12:48 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.108]:34360 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbfGVSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:12:47 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 5AB5B5112
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:12:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pcnmhxewm4FKppcnmh8nn6; Mon, 22 Jul 2019 13:12:46 -0500
X-Authority-Reason: nr=8
Received: from cablelink149-185.telefonia.intercable.net ([201.172.149.185]:46522 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hpcnk-002AEO-VS; Mon, 22 Jul 2019 13:12:45 -0500
Date:   Mon, 22 Jul 2019 13:12:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/i915: Mark expected switch fall-throughs
Message-ID: <20190722181244.GA2085@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.149.185
X-Source-L: No
X-Exim-ID: 1hpcnk-002AEO-VS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink149-185.telefonia.intercable.net (embeddedor) [201.172.149.185]:46522
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/gpu/drm/i915/gem/i915_gem_mman.c: In function ‘i915_gem_fault’:
drivers/gpu/drm/i915/gem/i915_gem_mman.c:342:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (!i915_terminally_wedged(i915))
      ^
drivers/gpu/drm/i915/gem/i915_gem_mman.c:345:2: note: here
  case -EAGAIN:
  ^~~~

drivers/gpu/drm/i915/gem/i915_gem_pages.c: In function ‘i915_gem_object_map’:
./include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
 # define unlikely(x) __builtin_expect(!!(x), 0)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:136:2: note: in expansion of macro ‘unlikely’
  unlikely(__ret_warn_on);     \
  ^~~~~~~~
drivers/gpu/drm/i915/i915_utils.h:49:25: note: in expansion of macro ‘WARN’
 #define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
                         ^~~~
drivers/gpu/drm/i915/gem/i915_gem_pages.c:270:3: note: in expansion of macro ‘MISSING_CASE’
   MISSING_CASE(type);
   ^~~~~~~~~~~~
drivers/gpu/drm/i915/gem/i915_gem_pages.c:272:2: note: here
  case I915_MAP_WB:
  ^~~~

drivers/gpu/drm/i915/i915_gpu_error.c: In function ‘error_record_engine_registers’:
./include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
 # define unlikely(x) __builtin_expect(!!(x), 0)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:136:2: note: in expansion of macro ‘unlikely’
  unlikely(__ret_warn_on);     \
  ^~~~~~~~
drivers/gpu/drm/i915/i915_utils.h:49:25: note: in expansion of macro ‘WARN’
 #define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
                         ^~~~
drivers/gpu/drm/i915/i915_gpu_error.c:1196:5: note: in expansion of macro ‘MISSING_CASE’
     MISSING_CASE(engine->id);
     ^~~~~~~~~~~~
drivers/gpu/drm/i915/i915_gpu_error.c:1197:4: note: here
    case RCS0:
    ^~~~

drivers/gpu/drm/i915/display/intel_dp.c: In function ‘intel_dp_get_fia_supported_lane_count’:
./include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
 # define unlikely(x) __builtin_expect(!!(x), 0)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:136:2: note: in expansion of macro ‘unlikely’
  unlikely(__ret_warn_on);     \
  ^~~~~~~~
drivers/gpu/drm/i915/i915_utils.h:49:25: note: in expansion of macro ‘WARN’
 #define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
                         ^~~~
drivers/gpu/drm/i915/display/intel_dp.c:233:3: note: in expansion of macro ‘MISSING_CASE’
   MISSING_CASE(lane_info);
   ^~~~~~~~~~~~
drivers/gpu/drm/i915/display/intel_dp.c:234:2: note: here
  case 1:
  ^~~~

drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
  CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/disp/cursgv100.o
drivers/gpu/drm/i915/display/intel_display.c:12043:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (WARN_ON(!HAS_DDI(to_i915(dev))))
       ^
drivers/gpu/drm/i915/display/intel_display.c:12046:3: note: here
   case INTEL_OUTPUT_DP:
   ^~~~

Also, notice that the Makefile is modified in order to stop
ignoring fall-through warnings. The -Wimplicit-fallthrough
option will be enabled globally in v5.3.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/Makefile                | 1 -
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 drivers/gpu/drm/i915/display/intel_dp.c      | 1 +
 drivers/gpu/drm/i915/gem/i915_gem_mman.c     | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c    | 2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c        | 1 +
 6 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 91355c2ea8a5..8cace65f50ce 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -16,7 +16,6 @@ subdir-ccflags-y := -Wall -Wextra
 subdir-ccflags-y += $(call cc-disable-warning, unused-parameter)
 subdir-ccflags-y += $(call cc-disable-warning, type-limits)
 subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
-subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
 subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
 # clang warnings
 subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 8592a7d422de..30b97ded6fdd 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -12042,7 +12042,7 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
 		case INTEL_OUTPUT_DDI:
 			if (WARN_ON(!HAS_DDI(to_i915(dev))))
 				break;
-			/* else: fall through */
+			/* else, fall through */
 		case INTEL_OUTPUT_DP:
 		case INTEL_OUTPUT_HDMI:
 		case INTEL_OUTPUT_EDP:
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4336df46fe78..d0fc34826771 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -231,6 +231,7 @@ static int intel_dp_get_fia_supported_lane_count(struct intel_dp *intel_dp)
 	switch (lane_info) {
 	default:
 		MISSING_CASE(lane_info);
+		/* fall through */
 	case 1:
 	case 2:
 	case 4:
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 391621ee3cbb..39a661927d8e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -341,7 +341,7 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 		 */
 		if (!i915_terminally_wedged(i915))
 			return VM_FAULT_SIGBUS;
-		/* else: fall through */
+		/* else, fall through */
 	case -EAGAIN:
 		/*
 		 * EAGAIN means the gpu is hung and we'll wait for the error
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index b36ad269f4ea..65eb430cedba 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -268,7 +268,7 @@ static void *i915_gem_object_map(const struct drm_i915_gem_object *obj,
 	switch (type) {
 	default:
 		MISSING_CASE(type);
-		/* fallthrough to use PAGE_KERNEL anyway */
+		/* fallthrough - to use PAGE_KERNEL anyway */
 	case I915_MAP_WB:
 		pgprot = PAGE_KERNEL;
 		break;
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index b7e9fddef270..41a511d5267f 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1194,6 +1194,7 @@ static void error_record_engine_registers(struct i915_gpu_state *error,
 			switch (engine->id) {
 			default:
 				MISSING_CASE(engine->id);
+				/* fall through */
 			case RCS0:
 				mmio = RENDER_HWS_PGA_GEN7;
 				break;
-- 
2.22.0

