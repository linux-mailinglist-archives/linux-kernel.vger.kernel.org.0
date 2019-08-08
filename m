Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38FC86351
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfHHNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 09:42:24 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:29022 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfHHNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:42:24 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 09:42:23 EDT
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: nEDU6LVRbg88KTlTux6ru2PgFlw3LZjUfq4C1Lk4MHjAdYYLx5hH5dgAN+PxYLeziP35n1JIkU
 V9/9gTTKBFaujkKcXN+7jTqPGwdxUON4C8t9vauc6bqqS5VS2VfgYKYCgkoY0mPwr3McBoUsMN
 bRXbiVpK7UnxHm2OUDKfgczWJCS1nMhKNkWTo0BYps8sKTld02npKy+2E2kcAibKuNvv6aWJeW
 uPS33gMZybumugUioywI5gGjPgweC8x1Al6DE1locvpzmoxG/q3OOVbjPNnzHDRPL6qIZxb2j3
 tEA=
X-SBRS: 2.7
X-MesageID: 4024476
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,361,1559534400"; 
   d="scan'208";a="4024476"
Date:   Thu, 8 Aug 2019 15:35:10 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] xen/blkback: Use refcount_t for refcount
Message-ID: <20190808133510.tre6twn764pv3e7m@Air-de-Roger>
References: <20190808131100.24751-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190808131100.24751-1-hslester96@gmail.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:11:00PM +0800, Chuhong Yuan wrote:
> Reference counters are preferred to use refcount_t instead of
> atomic_t.
> This is because the implementation of refcount_t can prevent
> overflows and detect possible use-after-free.
> So convert atomic_t ref counters to refcount_t.

Thanks!

I think there are more reference counters in blkback than
the one you fixed. There's also an inflight field in xen_blkif_ring,
and a pendcnt in pending_req which look like possible candidates to
switch to use refcount_t, have you looked into switching those two
also?

Roger.
