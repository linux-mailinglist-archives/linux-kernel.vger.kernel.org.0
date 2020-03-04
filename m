Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2206179B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbgCDVhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 16:37:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:26509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgCDVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:37:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 13:37:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,515,1574150400"; 
   d="scan'208";a="263745165"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.153.168]) ([10.249.153.168])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2020 13:37:19 -0800
Subject: Re: [PATCH] PNP: add missing include/linux/pnp.h in MAINTAINERS
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org
References: <1582574407-27214-1-git-send-email-clabbe@baylibre.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <cc4f8fef-fcfe-ca31-39d3-3b3616061276@intel.com>
Date:   Wed, 4 Mar 2020 22:37:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582574407-27214-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2020 9:00 PM, Corentin Labbe wrote:
> include/linux/pnp.h should be part of PNP in MAINTAINERS.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b85f22b9b69..5b1574631b21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13404,6 +13404,7 @@ F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
>   PNP SUPPORT
>   M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>   S:	Maintained
> +F:	include/linux/pnp.h
>   F:	drivers/pnp/
>   
>   POSIX CLOCKS and TIMERS

Applied as 5.7 material with minor changes in the subject and changelog.

Thanks!


