Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB1AB94A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405023AbfIFNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 09:32:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:41880 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391614AbfIFNcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:32:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 06:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="199519580"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 06 Sep 2019 06:31:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 06 Sep 2019 16:31:57 +0300
Date:   Fri, 6 Sep 2019 16:31:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] software node: implement reference properties
Message-ID: <20190906133157.GC30048@kuha.fi.intel.com>
References: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
 <20190906111744.GA30048@kuha.fi.intel.com>
 <20190906124043.GS2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906124043.GS2680@smile.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:40:43PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 06, 2019 at 02:17:44PM +0300, Heikki Krogerus wrote:
> > On Thu, Sep 05, 2019 at 09:38:07PM -0700, Dmitry Torokhov wrote:
> > > It is possible to store references to software nodes in the same fashion as
> > > other static properties, so that users do not need to define separate
> > > structures:
> > > 
> > > const struct software_node gpio_bank_b_node = {
> > > 	.name = "B",
> > > };
> > > 
> > > const struct property_entry simone_key_enter_props[] __initconst = {
> > > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > > 	{ }
> > > };
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > This looks really good to me. I'll wait for Andy's comments on the
> > idea, but to me it makes sense.
> 
> Idea in general is fine. Though, taking into consideration, for example,
> drivers/mfd/intel-lpss-pci.c, the size of predefined structures bumps a lot.
> I think we always should keep a pointer. In this case we may not add another
> property type.

Yeah, you have a point.

thanks,

-- 
heikki
