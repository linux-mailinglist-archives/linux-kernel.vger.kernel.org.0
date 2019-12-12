Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04B911C9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 10:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfLLJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 04:46:16 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:55176 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576143975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dhXc0hzpDoP0LP4NSBAMjDZwUwr/XdPCcsPghJX+ijI=;
  b=QTjchn3P1xveVX0WHkPFwa1p3SL6aQ4kwCuqH8hkncEa7TdorUr0Hs9X
   fqaHRgTwY3O7212yu5B9Gw3UPvI27+3EQB2iN7D0HoDI5hrphkCnOIlq/
   sl3WOzLp67ug95NJyLfA/3lFd65DyZfIJywfk8HHUNwqPLn761MMSZW2K
   g=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: sZq+6Bqqho6dJH0ffNG0utzQUqfntE8WwDXagBrPi7yOImVchjjDnJ0Mgr+DwacELCKTWXP72Z
 RExnWQaI+o8qRO0fcfw3ThsOPkrf0TGVCURTUd9LOJo06Ljpbb+oRxHc3trlR/Z8ZxNQ+tiWfk
 8a52pDLzYuXGKaSOFzWSsJzrHef8//cG9BMag8gfBED/rWhGdjvsutJi/Rys/nfwWbPvemsJN0
 Ux2SJ1Mf4UxEL6099h7iJzqHX3iK/rm+FBKSpKWdx0hBvN+g91sJdABtoeGoc3Qd0Xo+08M5fW
 7EQ=
X-SBRS: 2.7
X-MesageID: 9705820
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,305,1571716800"; 
   d="scan'208";a="9705820"
Date:   Thu, 12 Dec 2019 10:46:00 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <sjpark@amazon.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v7 1/3] xenbus/backend: Add memory pressure
 handler callback
Message-ID: <20191212094600.GA11756@Air-de-Roger>
References: <20191211181016.14366-1-sjpark@amazon.de>
 <20191211181016.14366-2-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211181016.14366-2-sjpark@amazon.de>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:10:14PM +0000, SeongJae Park wrote:
> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lack
> flexibility.
> 
> To mitigate such problems, this commit adds a memory reclaim callback to
> 'xenbus_driver'.  If a memory pressure is detected, 'xenbus' requests
> every backend driver to volunarily release its memory.
> 
> Note that it would be able to improve the callback facility for more
> sophisticated handlings of general pressures.  For example, it would be
> possible to monitor the memory consumption of each device and issue the
> release requests to only devices which causing the pressure.  Also, the
> callback could be extended to handle not only memory, but general
> resources.  Nevertheless, this version of the implementation defers such
> sophisticated goals as a future work.
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Roger Pau Monn� <roger.pau@citrix.com>

Thanks, Roger.
