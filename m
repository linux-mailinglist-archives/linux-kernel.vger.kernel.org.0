Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFC11D0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfLLP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 10:28:06 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:2174 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfLLP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576164485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvgORIxOYpFKDQliLXZpKH57CcT6Jc8jG1mpwed1XFM=;
  b=dajOOG86SYPFPdYPX+lfzIFMxFEJ7SETyG4UHO1UZRywZt22Eehyhqk3
   Og/Vavw5W1XFx3O+lkGIBG51EDvdnJ0tj7oDf+PGIqf2epNiloDLMey+9
   dn54E+RPHAOzo1nAUavJ7B9YU94+e9YJEepV24MIFDJlq+8NyunRsoBoS
   M=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: I4h8En3BXKbrUkzf/pMTjpOcz5DugWSud/TOnaQG8/yjRnCs+felomVJF9tkitwa2GXPzHR5vs
 juOU9uZdTtTY+J1T0PdISZanhZfVnRDG6WKQXXfio6eF6NfaHcOy0lz7hc9hTCg32/iW8pCEly
 aIi+YclRWsAsq5mJTNHbovUsAH+cmEnTGHrN5iMjwReVgM1tnRi1j3ZMdk/bde3QgYutvaaC6d
 pzZI/zV5aPOwH0RmSwtnO9T7Yg0vER/2SmH7/s7vTBXZ/bXZlDIX6l9xKNoY7drB58boDKtBUV
 PQE=
X-SBRS: 2.7
X-MesageID: 9588030
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,306,1571716800"; 
   d="scan'208";a="9588030"
Date:   Thu, 12 Dec 2019 16:27:57 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <sjpark@amazon.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a
 memory pressure is detected
Message-ID: <20191212152757.GF11756@Air-de-Roger>
References: <20191211181016.14366-1-sjpark@amazon.de>
 <20191211181016.14366-3-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191211181016.14366-3-sjpark@amazon.de>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:10:15PM +0000, SeongJae Park wrote:
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index fd1e19f1a49f..98823d150905 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>  		HZ * xen_blkif_pgrant_timeout);
>  }
>  
> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> +static unsigned int buffer_squeeze_duration_ms = 10;
> +module_param_named(buffer_squeeze_duration_ms,
> +		buffer_squeeze_duration_ms, int, 0644);
> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> +
> +static unsigned long buffer_squeeze_end;
> +
> +void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
> +{
> +	buffer_squeeze_end = jiffies +
> +		msecs_to_jiffies(buffer_squeeze_duration_ms);

I'm not sure this is fully correct. This function will be called for
each blkback instance, but the timeout is stored in a global variable
that's shared between all blkback instances. Shouldn't this timeout be
stored in xen_blkif so each instance has it's own local variable?

Or else in the case you have 1k blkback instances the timeout is
certainly going to be longer than expected, because each call to
xen_blkbk_reclaim_memory will move it forward.

Thanks, Roger.
