Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0363154153
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgBFJoU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Feb 2020 04:44:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:40881 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgBFJoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:44:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 01:44:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="311645461"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2020 01:44:19 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Feb 2020 01:44:19 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.225]) with mapi id 14.03.0439.000;
 Thu, 6 Feb 2020 17:44:17 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "tysand@google.com" <tysand@google.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Topic: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Index: AQHV3Mq/N+pHUOUW3kyXc/hsfZBMQqgNWrYAgACKBvD//3w6AIAAhvTQ
Date:   Thu, 6 Feb 2020 09:44:17 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E42397C@shsmsx102.ccr.corp.intel.com>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
 <6ccbfeea-de66-20d7-0e08-a5834a3c3d3f@redhat.com>
 <286AC319A985734F985F78AFA26841F73E4238BA@shsmsx102.ccr.corp.intel.com>
 <80f975c9-5f18-a613-6412-292dafd34dfe@redhat.com>
In-Reply-To: <80f975c9-5f18-a613-6412-292dafd34dfe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 6, 2020 5:32 PM, David Hildenbrand wrote:
> 
> If the page cache is empty, a drop_slab() will deflate the whole balloon if I
> am not wrong.
> 
> Especially, a echo 3 > /proc/sys/vm/drop_caches
> 
> will first drop the page cache and then drop_slab()

Then that's the problem of "echo 3 > /proc/sys/vm/drop_cache" itself. It invokes other shrinkers as well (if considered an issue), need to be tweaked in the mm.

Best,
Wei
