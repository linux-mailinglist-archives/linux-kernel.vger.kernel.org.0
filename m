Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30FA19A886
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgDAJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 05:22:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:62811 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDAJWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:22:10 -0400
IronPort-SDR: XtCmU5mrcEv+kQrnT4M21nLRmR6HjoP2/8girXBl9FYoAWDlmVl9AJCNc3fcY1m5qOIubRzSR9
 BkYJb4hgjGJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 02:22:10 -0700
IronPort-SDR: JT0/RzqxXMkZa9y2Rcyon4u6ODsbw9lO35PfCHIJ2S8yWZHtAVg4v0HS1v4h9NUfIs72WJ237o
 tfP4L8Fa1J9A==
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="422646211"
Received: from unknown (HELO localhost) ([10.252.38.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 02:22:07 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [git pull] drm for 5.7-rc1
In-Reply-To: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
Date:   Wed, 01 Apr 2020 12:22:04 +0300
Message-ID: <87d08rftmr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Apr 2020, Dave Airlie <airlied@gmail.com> wrote:
> i915 and amdgpu have initial OLED backlight support

I suppose we've had a bunch of "initial support" code for a long time
already, but only now Lyude made it actually work on real world
machines. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
