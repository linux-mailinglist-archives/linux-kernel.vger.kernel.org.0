Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18151B6307
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfIRMYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 08:24:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:54551 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfIRMYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:24:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 05:24:06 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="387898031"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 05:24:04 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v3 1/7] drm: add drm_print_bits
In-Reply-To: <20190904054740.20817-2-kraxel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190904054740.20817-1-kraxel@redhat.com> <20190904054740.20817-2-kraxel@redhat.com>
Date:   Wed, 18 Sep 2019 15:24:01 +0300
Message-ID: <87sgotx066.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Gerd Hoffmann <kraxel@redhat.com> wrote:
> New helper to print named bits of some value (think flags fields).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_print.h     |  3 +++
>  drivers/gpu/drm/drm_print.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 112165d3195d..12d4916254b4 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -89,6 +89,9 @@ __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
>  void drm_puts(struct drm_printer *p, const char *str);
>  void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
> +void drm_print_bits(struct drm_printer *p,
> +		    unsigned long value, const char *bits[],
> +		    unsigned int from, unsigned int to);
>  
>  __printf(2, 0)
>  /**
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index ad302d71eeee..dfa27367ebb8 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -185,6 +185,39 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
>  }
>  EXPORT_SYMBOL(drm_printf);
>  
> +/**
> + * drm_print_bits - print bits to a &drm_printer stream
> + *
> + * Print bits (in flag fields for example) in human readable form.
> + * The first name in the @bits array is for the bit indexed by @from.
> + *
> + * @p: the &drm_printer
> + * @value: field value.
> + * @bits: Array with bit names.
> + * @from: start of bit range to print (inclusive).
> + * @to: end of bit range to print (exclusive).
> + */
> +void drm_print_bits(struct drm_printer *p,
> +		    unsigned long value, const char *bits[],
> +		    unsigned int from, unsigned int to)
> +{
> +	bool first = true;
> +	unsigned int i;
> +
> +	for (i = from; i < to; i++) {
> +		if (!(value & (1 << i)))
> +			continue;

for_each_set_bit from bitops.h?

> +		if (WARN_ON_ONCE(!bits[i-from]))
> +			continue;
> +		drm_printf(p, "%s%s", first ? "" : ",",
> +			   bits[i-from]);

I wonder about the usefulness of from and to, as well as indexing
(i-from) for the strings.

To limit the values to be printed in a more general way than range, you
can use:

	drm_print_bits(p, value & GENMASK(h, l), bits);

And obviously to adjust the starting position:

	drm_print_bits(p, value >> l, bits);

Seems like a simple len parameter to indicate the ARRAY_SIZE() of bits
would be more straighforward to guard against array overflow.

	drm_print_bits(p, value, bits, ARRAY_SIZE(bits));


BR,
Jani.


> +		first = false;
> +	}
> +	if (first)
> +		drm_printf(p, "(none)");
> +}
> +EXPORT_SYMBOL(drm_print_bits);
> +
>  void drm_dev_printk(const struct device *dev, const char *level,
>  		    const char *format, ...)
>  {

-- 
Jani Nikula, Intel Open Source Graphics Center
