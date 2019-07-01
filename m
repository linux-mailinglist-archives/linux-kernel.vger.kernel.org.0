Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14EE5628A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFZGpW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jun 2019 02:45:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:4173 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfFZGpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:45:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 23:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,418,1557212400"; 
   d="scan'208";a="184742164"
Received: from pgsmsx113.gar.corp.intel.com ([10.108.55.202])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2019 23:45:18 -0700
Received: from pgsmsx111.gar.corp.intel.com ([169.254.2.124]) by
 pgsmsx113.gar.corp.intel.com ([169.254.6.32]) with mapi id 14.03.0439.000;
 Wed, 26 Jun 2019 14:45:17 +0800
From:   "Lee, Shawn C" <shawn.c.lee@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rajatja@google.com" <rajatja@google.com>,
        "marcheu@chromium.org" <marcheu@chromium.org>,
        Furquan Shaikh <furquan@google.com>
Subject: RE: [PATCH] i915: intel_dp_aux_backlight: Fix max backlight
 calculations
Thread-Topic: [PATCH] i915: intel_dp_aux_backlight: Fix max backlight
 calculations
Thread-Index: AQHVK2e5KBKwjJViVUiah6kZvn/ER6atfk3A
Date:   Wed, 26 Jun 2019 06:45:17 +0000
Message-ID: <D42A2A322A1FCA4089E30E9A9BA36AC65D61CB76@PGSMSX111.gar.corp.intel.com>
References: <20190618062628.133783-1-furquan@google.com>
 <87v9wtog67.fsf@intel.com>
In-Reply-To: <87v9wtog67.fsf@intel.com>
Reply-To: "20190618062628.133783-1-furquan@google.com" 
          <20190618062628.133783-1-furquan@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWE1OTgxODUtNTMyZC00OTI5LWI4ZjctMDJjYzQ4NGYyMDY5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaUlBbE96bTZTMStVeFBVaCtiNzJVOHd2RDdVdnoxZnJkVGVRTW5VM3NPOCtleHpQa2UzWDV2eG44WDVsdjBpYyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>On Mon, 17 Jun 2019, Furquan Shaikh <furquan@google.com> wrote:
>> Max backlight value for the panel was being calculated using byte 
>> count i.e. 0xffff if 2 bytes are supported for backlight brightness 
>> and 0xff if 1 byte is supported. However, EDP_PWMGEN_BIT_COUNT 
>> determines the number of active control bits used for the brightness 
>> setting. Thus, even if the panel uses 2 byte setting, it might not use 
>> all the control bits. Thus, max backlight should be set based on the 
>> value of EDP_PWMGEN_BIT_COUNT instead of assuming 65535 or 255.
>>
>> Additionally, EDP_PWMGEN_BIT_COUNT was being updated based on the VBT 
>> frequency which results in a different max backlight value. Thus, 
>> setting of EDP_PWMGEN_BIT_COUNT is moved to setup phase instead of 
>> enable so that max backlight can be calculated correctly. Only the 
>> frequency divider is set during the enable phase using the value of 
>> EDP_PWMGEN_BIT_COUNT.
>
>The eDP aux backlight is another fine example of simple made difficult. Ugh.
>
>Shawn (Cc'd) has recently submitted patches to this code. Shawn, please also look through this and provide your comments, if any.
>

From my point for view, this change give the correct backlight.max value.
Just like what driver did in intel_panel.c to retrieve PWM freq from VBT and convert to max backlight value.
This should avoid driver configure brightness level that over TCON capability to cause unexpected issue on display backlight.

Best regards,
Shawn

>One comment inline.
>
>> Signed-off-by: Furquan Shaikh <furquan@google.com>
>> Reviewed-by: St�phane Marchesin <marcheu@chromium.org>
>> ---
>>  drivers/gpu/drm/i915/intel_dp_aux_backlight.c | 132 
>> ++++++++++++------
>>  1 file changed, 88 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/intel_dp_aux_backlight.c 
>> b/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
>> index 357136f17f85..4636c8e8ae8a 100644
>> --- a/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
>> +++ b/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
>> @@ -110,61 +110,34 @@ static bool intel_dp_aux_set_pwm_freq(struct 
>> intel_connector *connector)  {
>>  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
>>  	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
>> -	int freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
>> -	u8 pn, pn_min, pn_max;
>> +	int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
>> +	u8 pn;
>>  
>> -	/* Find desired value of (F x P)
>> -	 * Note that, if F x P is out of supported range, the maximum value or
>> -	 * minimum value will applied automatically. So no need to check that.
>> -	 */
>>  	freq = dev_priv->vbt.backlight.pwm_freq_hz;
>> -	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
>>  	if (!freq) {
>>  		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
>>  		return false;
>>  	}
>>  
>> -	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
>> -
>> -	/* Use highest possible value of Pn for more granularity of brightness
>> -	 * adjustment while satifying the conditions below.
>> -	 * - Pn is in the range of Pn_min and Pn_max
>> -	 * - F is in the range of 1 and 255
>> -	 * - FxP is within 25% of desired value.
>> -	 *   Note: 25% is arbitrary value and may need some tweak.
>> -	 */
>> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
>> -			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) != 1) {
>> -		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
>> +	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
>> +			      &pn) < 0) {
>> +		DRM_DEBUG_KMS("Failed to read aux pwmgen bit count\n");
>>  		return false;
>>  	}
>> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
>> -			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) != 1) {
>> -		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
>> -		return false;
>> -	}
>> -	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>> -	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>>  
>> +	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
>> +	f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
>> +	fxp_actual = f << pn;
>> +
>> +	/* Ensure frequency is within 25% of desired value */
>>  	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
>>  	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
>> -	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
>> -		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
>> -		return false;
>> -	}
>>  
>> -	for (pn = pn_max; pn >= pn_min; pn--) {
>> -		f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
>> -		fxp_actual = f << pn;
>> -		if (fxp_min <= fxp_actual && fxp_actual <= fxp_max)
>> -			break;
>> -	}
>> -
>> -	if (drm_dp_dpcd_writeb(&intel_dp->aux,
>> -			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
>> -		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
>> +	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
>> +		DRM_DEBUG_KMS("Actual frequency out of range\n");
>>  		return false;
>>  	}
>> +
>>  	if (drm_dp_dpcd_writeb(&intel_dp->aux,
>>  			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
>>  		DRM_DEBUG_KMS("Failed to write aux backlight freq\n"); @@ -224,16 
>> +197,87 @@ static void intel_dp_aux_disable_backlight(const struct drm_connector_state *old
>>  	
>> set_aux_backlight_enable(enc_to_intel_dp(old_conn_state->best_encoder)
>> , false);  }
>>  
>> +static u32 intel_dp_aux_calc_max_backlight(struct intel_connector 
>> +*connector) {
>> +	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
>> +	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
>> +	u32 max_backlight = 0;
>> +	int freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
>> +	u8 pn, pn_min, pn_max;
>> +
>> +	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn)) {
>> +		pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>> +		max_backlight = (1 << pn) - 1;
>> +	}
>
>If the dpcd read fails, pn may be uninitialized; need to check the return value properly here.
>
>Otherwise, seems fine, though unnecessarily complicated but that's hardly your fault...
>
>
>BR,
>Jani.
>
>> +
>> +	/* Find desired value of (F x P)
>> +	 * Note that, if F x P is out of supported range, the maximum value or
>> +	 * minimum value will applied automatically. So no need to check that.
>> +	 */
>> +	freq = dev_priv->vbt.backlight.pwm_freq_hz;
>> +	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
>> +	if (!freq) {
>> +		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
>> +		return max_backlight;
>> +	}
>> +
>> +	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
>> +
>> +	/* Use highest possible value of Pn for more granularity of brightness
>> +	 * adjustment while satifying the conditions below.
>> +	 * - Pn is in the range of Pn_min and Pn_max
>> +	 * - F is in the range of 1 and 255
>> +	 * - FxP is within 25% of desired value.
>> +	 *   Note: 25% is arbitrary value and may need some tweak.
>> +	 */
>> +	if (drm_dp_dpcd_readb(&intel_dp->aux,
>> +			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) != 1) {
>> +		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
>> +		return max_backlight;
>> +	}
>> +	if (drm_dp_dpcd_readb(&intel_dp->aux,
>> +			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) != 1) {
>> +		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
>> +		return max_backlight;
>> +	}
>> +	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>> +	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>> +
>> +	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
>> +	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
>> +	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
>> +		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
>> +		return max_backlight;
>> +	}
>> +
>> +	for (pn = pn_max; pn >= pn_min; pn--) {
>> +		f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
>> +		fxp_actual = f << pn;
>> +		if (fxp_min <= fxp_actual && fxp_actual <= fxp_max)
>> +			break;
>> +	}
>> +
>> +	if (drm_dp_dpcd_writeb(&intel_dp->aux,
>> +			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
>> +		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
>> +		return max_backlight;
>> +	}
>> +
>> +	max_backlight = (1 << pn) - 1;
>> +
>> +	return max_backlight;
>> +}
>> +
>>  static int intel_dp_aux_setup_backlight(struct intel_connector *connector,
>>  					enum pipe pipe)
>>  {
>>  	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
>>  	struct intel_panel *panel = &connector->panel;
>>  
>> -	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
>> -		panel->backlight.max = 0xFFFF;
>> -	else
>> -		panel->backlight.max = 0xFF;
>> +	panel->backlight.max = intel_dp_aux_calc_max_backlight(connector);
>> +
>> +	if (!panel->backlight.max)
>> +		return -ENODEV;
>>  
>>  	panel->backlight.min = 0;
>>  	panel->backlight.level = intel_dp_aux_get_backlight(connector);
>
>--
>Jani Nikula, Intel Open Source Graphics Center
>
