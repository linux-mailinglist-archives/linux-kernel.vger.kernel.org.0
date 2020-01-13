Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DFD138E46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 10:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgAMJzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 04:55:18 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:33588 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578909318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x7xJTqB14LWoSFgsa+eCPpwC/buUotSsSvKgqBM35Yo=;
  b=dKY7z9FVWudV/rhTiuEzFU/hRXj83jaUogSIKR6swvPsj6I+4KC6TKKT
   4bvZAmhWQ6gppWjIGpSYfQ99TRP/KG3s/qjBou8wB6G58muStnKvtq/oA
   strYSdpPJaCWId6ilYRuaXBdOEk0XfOv+cXEC0WdFuDmgaObCB0GhAAvG
   Q=;
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
IronPort-SDR: JfT05Zxv6Ttu7bOIRF8cT096SWH96bNNGjcAzINGkIUCaMfRd2VuA5qaKWjU42bxNdu9S6FVSU
 kMxRM8gCs1bbBPg9Og6QUvQ3/TjuamvJwVv645LEHV/R9y6VcRYt4hjWOqr6Qj+WjzWIv5N1kq
 q4sukZK2YwbRqNq/68uhdVRuGkJMro9uHe4CSGhBbea9oVtGSNybIgs97GurbC5O5ZlRFdoxqj
 Y0/rNRUS75owEXBcJbc5/qKGsTg7GCUqtNqWdla6dMvu3fXuhIH0oqh9zsAZT4+nUaO7O10lD1
 MdU=
X-SBRS: 2.7
X-MesageID: 10812478
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,428,1571716800"; 
   d="scan'208";a="10812478"
Date:   Mon, 13 Jan 2020 10:55:07 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <pdurrant@amazon.com>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v13 0/5] xenbus/backend: Add memory pressure
 handler callback
Message-ID: <20200113095507.GE11756@Air-de-Roger>
References: <20191218183718.31719-1-sjpark@amazon.com>
 <20200113094952.30727-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200113094952.30727-1-sjpark@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:49:52AM +0100, SeongJae Park wrote:
> Every patch of this patchset got at least one 'Reviewed-by' or 'Acked-by' from
> appropriate maintainers by last Wednesday, and after that, got no comment yet.
> May I ask some more comments?

I'm not sure why more comments are needed, patches have all the
relevant Acks and will be pushed in due time unless someone has
objections.

Please be patient and wait at least until the next merge window, this
patches are not bug fixes so pushing them now would be wrong.

Roger.
