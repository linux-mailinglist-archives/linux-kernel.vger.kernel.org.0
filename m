Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAD11D7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfLLUjF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Dec 2019 15:39:05 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52548 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbfLLUjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:39:05 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19560382-1500050 
        for multiple; Thu, 12 Dec 2019 20:38:54 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Colin Ian King <colin.king@canonical.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1d2c3c9d-5f11-db41-68ef-61ff9ec601cb@canonical.com>
Cc:     Venkata Sandeep Dhanalakota <venkata.s.dhanalakota@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1d2c3c9d-5f11-db41-68ef-61ff9ec601cb@canonical.com>
Message-ID: <157618313562.7396.11949995525623174493@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: re: drm/i915: Use the i915_device name for identifying our, request fences
Date:   Thu, 12 Dec 2019 20:38:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2019-12-12 19:53:33)
> Hi,
> 
> Static analysis with Coverity has picked up an issue with the following
> commit:
> 
> commit 65c29dbb19b2451990c5c477fef7ada3b8218f05
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Wed Dec 11 15:02:04 2019 +0000
> 
>     drm/i915: Use the i915_device name for identifying our request fences
> 
> In source drivers/gpu/drm/i915/i915_request.c and function
> i915_fence_get_timeline_name there is the following:
> 
>         return to_request(fence)->gem_context->name ?: "[" DRIVER_NAME "]";
> 
> However name is an array: char name[TASK_COMM_LEN + 8], so it can never
> be null, so the ternary operator will always return name and will never
> reaturn "[" DRIVER_NAME "]".  Should it instead be checking if name[0]
> is '\0' instead?

It's older than that patch, we made it a char[] some time ago. There's a
patch pending to make it conditional on ce->gem_context instead.
-Chris
