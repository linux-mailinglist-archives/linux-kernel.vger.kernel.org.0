Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8579815903D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgBKNrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:47:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:35535 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgBKNrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:47:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:47:39 -0800
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226507295"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:47:36 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] drm/i915/hdmi: convert to struct drm_device based logging macros.
In-Reply-To: <20200206080014.13759-12-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200206080014.13759-1-wambui.karugax@gmail.com> <20200206080014.13759-12-wambui.karugax@gmail.com>
Date:   Tue, 11 Feb 2020 15:47:33 +0200
Message-ID: <87tv3xz156.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Feb 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> @@ -1364,11 +1372,15 @@ int intel_hdmi_hdcp_write_an_aksv(struct intel_digital_port *intel_dig_port,
>  static int intel_hdmi_hdcp_read_bksv(struct intel_digital_port *intel_dig_port,
>  				     u8 *bksv)
>  {
> +	struct drm_i915_private *i915 =
> +		intel_dig_port->base.base.dev->dev_private;

The preferred way to get from intel_digital_port to i915 throughout is

	struct drm_i915_private *i915 = to_i915(intel_dig_port->base.base.dev);

I realize there are some bad examples in the file; I've posted [1] to
fix them.

BR,
Jani.


[1] http://patchwork.freedesktop.org/patch/msgid/20200211134427.31605-1-jani.nikula@intel.com

-- 
Jani Nikula, Intel Open Source Graphics Center
