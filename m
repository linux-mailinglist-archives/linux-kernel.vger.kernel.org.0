Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9EB4C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfIQLN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 07:13:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:13217 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfIQLN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:13:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 04:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; 
   d="scan'208";a="270506422"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 17 Sep 2019 04:13:23 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iABQA-0003MM-Hk; Tue, 17 Sep 2019 14:13:22 +0300
Date:   Tue, 17 Sep 2019 14:13:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
Message-ID: <20190917111322.GD2680@smile.fi.intel.com>
References: <20190916211536.29646-1-jekhor@gmail.com>
 <20190916211536.29646-2-jekhor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916211536.29646-2-jekhor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:15:36AM +0300, Yauhen Kharuzhy wrote:
> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> PMIC at driver probing for further charger detection. This causes reset of
> USB data sessions and removing all devices from bus. If system was
> booted from Live CD or USB dongle, this makes system unusable.
> 
> Check if USB ID pin is floating and re-route data lines in this case
> only, don't touch otherwise.

> +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> +		goto disable_sw_control;
> +	}
> +
> +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);

We have second implementation of this. Would it make sense to split to some
helper?

> +	/* If no USB host or device connected, route D+ and D- to PMIC for
> +	 * initial charger detection
> +	 */

I'm not sure it's acceptable style of multi-line comment, but it's up to
maintainer.

> +	if (id != INTEL_USB_ID_GND)
> +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
>  
>  	/* Get initial state */
>  	cht_wc_extcon_pwrsrc_event(ext);
> -- 
> 2.23.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko


