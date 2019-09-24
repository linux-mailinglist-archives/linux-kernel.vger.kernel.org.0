Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43003BC5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 12:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504493AbfIXKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 06:50:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:55880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387644AbfIXKun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:50:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 03:50:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="272598308"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 03:50:41 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id C913B20E30; Tue, 24 Sep 2019 13:50:38 +0300 (EEST)
Date:   Tue, 24 Sep 2019 13:50:38 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] media: v4l2-fwnode: fix location of acpi/dsd
 documentation
Message-ID: <20190924105038.GH9467@paasikivi.fi.intel.com>
References: <c7e1b210db1c656bbf1a9488aca26c936ab7577a.1569321356.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e1b210db1c656bbf1a9488aca26c936ab7577a.1569321356.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Tue, Sep 24, 2019 at 07:36:00AM -0300, Mauro Carvalho Chehab wrote:
> This got moved to the firmware-guide.
> 
> Fixes: f2dde1ed0f28 ("Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and convert to reST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
> index 3bd1888787eb..0e361565f2f9 100644
> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
> @@ -819,7 +819,7 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
>   *
>   * THIS EXAMPLE EXISTS MERELY TO DOCUMENT THIS FUNCTION. DO NOT USE IT AS A
>   * REFERENCE IN HOW ACPI TABLES SHOULD BE WRITTEN!! See documentation under
> - * Documentation/acpi/dsd instead and especially graph.txt,
> + * Documentation/firmware-guide/acpi/dsd instead and especially graph.txt,
>   * data-node-references.txt and leds.txt .

Thanks! The files now have .rst suffix. Could you address that as well?

With that,

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

>   *
>   *	Scope (\_SB.PCI0.I2C2)

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
