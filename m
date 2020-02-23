Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06316986B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBWPcl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 Feb 2020 10:32:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:40832 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWPcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:32:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 07:32:40 -0800
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="230388634"
Received: from rcoelln-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 07:32:37 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Distribute switch variables for initialization
In-Reply-To: <20200221113057.GL13686@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <202002201602.92CADF7D@keescook> <20200221113057.GL13686@intel.com>
Date:   Sun, 23 Feb 2020 17:32:49 +0200
Message-ID: <87h7zhtj32.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> On Thu, Feb 20, 2020 at 04:05:17PM -0800, Kees Cook wrote:
>> Variables declared in a switch statement before any case statements
>> cannot be automatically initialized with compiler instrumentation (as
>> they are not part of any execution flow). With GCC's proposed automatic
>> stack variable initialization feature, this triggers a warning (and they
>> don't get initialized). Clang's automatic stack variable initialization
>> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
>> doesn't initialize such variables[1]. Note that these warnings (or silent
>> skipping) happen before the dead-store elimination optimization phase,
>> so even when the automatic initializations are later elided in favor of
>> direct initializations, the warnings remain.
>> 
>> To avoid these problems, move such variables into the "case" where
>> they're used or lift them up into the main function body.
>> 
>> drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
>> drivers/gpu/drm/i915/display/intel_display.c:12963:17: warning: statement will never be executed [-Wswitch-unreachable]
>> 12963 |    unsigned int port_mask;
>>       |                 ^~~~~~~~~
>> 
>> drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_get_fifo_size’:
>> drivers/gpu/drm/i915/intel_pm.c:474:7: warning: statement will never be executed [-Wswitch-unreachable]
>>   474 |   u32 dsparb, dsparb2, dsparb3;
>>       |       ^~~~~~
>> drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_atomic_update_fifo’:
>> drivers/gpu/drm/i915/intel_pm.c:1997:7: warning: statement will never be executed [-Wswitch-unreachable]
>>  1997 |   u32 dsparb, dsparb2, dsparb3;
>>       |       ^~~~~~
>> 
>> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
>> 
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> v2: remove port_mask entirely (Ville Syrjälä)
>> v1: https://lore.kernel.org/lkml/20200220062258.68854-1-keescook@chromium.org
>> ---
>>  drivers/gpu/drm/i915/display/intel_display.c | 7 ++-----
>>  drivers/gpu/drm/i915/intel_pm.c              | 4 ++--
>>  2 files changed, 4 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
>> index 064dd99bbc49..5f8c61932e82 100644
>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>> @@ -12960,7 +12960,6 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>>  		WARN_ON(!connector_state->crtc);
>>  
>>  		switch (encoder->type) {
>> -			unsigned int port_mask;
>>  		case INTEL_OUTPUT_DDI:
>>  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
>>  				break;
>> @@ -12968,13 +12967,11 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>>  		case INTEL_OUTPUT_DP:
>>  		case INTEL_OUTPUT_HDMI:
>>  		case INTEL_OUTPUT_EDP:
>> -			port_mask = 1 << encoder->port;
>> -
>>  			/* the same port mustn't appear more than once */
>> -			if (used_ports & port_mask)
>> +			if (used_ports & BIT(encoder->port))
>>  				ret = false;
>>  
>> -			used_ports |= port_mask;
>> +			used_ports |= BIT(encoder->port);
>
> Thanks. Looks good.
>
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Thanks for the patch and review, pushed to dinq.

BR,
Jani.

>
>>  			break;
>>  		case INTEL_OUTPUT_DP_MST:
>>  			used_mst_ports |=
>> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
>> index bd2d30ecc030..17d8833787c4 100644
>> --- a/drivers/gpu/drm/i915/intel_pm.c
>> +++ b/drivers/gpu/drm/i915/intel_pm.c
>> @@ -469,9 +469,9 @@ static void vlv_get_fifo_size(struct intel_crtc_state *crtc_state)
>>  	struct vlv_fifo_state *fifo_state = &crtc_state->wm.vlv.fifo_state;
>>  	enum pipe pipe = crtc->pipe;
>>  	int sprite0_start, sprite1_start;
>> +	u32 dsparb, dsparb2, dsparb3;
>>  
>>  	switch (pipe) {
>> -		u32 dsparb, dsparb2, dsparb3;
>>  	case PIPE_A:
>>  		dsparb = I915_READ(DSPARB);
>>  		dsparb2 = I915_READ(DSPARB2);
>> @@ -1969,6 +1969,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
>>  	const struct vlv_fifo_state *fifo_state =
>>  		&crtc_state->wm.vlv.fifo_state;
>>  	int sprite0_start, sprite1_start, fifo_size;
>> +	u32 dsparb, dsparb2, dsparb3;
>>  
>>  	if (!crtc_state->fifo_changed)
>>  		return;
>> @@ -1994,7 +1995,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
>>  	spin_lock(&uncore->lock);
>>  
>>  	switch (crtc->pipe) {
>> -		u32 dsparb, dsparb2, dsparb3;
>>  	case PIPE_A:
>>  		dsparb = intel_uncore_read_fw(uncore, DSPARB);
>>  		dsparb2 = intel_uncore_read_fw(uncore, DSPARB2);
>> -- 
>> 2.20.1
>> 
>> 
>> -- 
>> Kees Cook
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Graphics Center
