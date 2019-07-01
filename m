Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6AC5AFED
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF3NrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 09:47:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:48976 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfF3NrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 09:47:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2019 06:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,434,1557212400"; 
   d="scan'208";a="186131455"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.128])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2019 06:47:08 -0700
Date:   Sun, 30 Jun 2019 21:49:44 +0800
From:   Philip Li <philip.li@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>, rong.a.chen@intel.com
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: buildbot status?
Message-ID: <20190630134944.GA22324@intel.com>
References: <20190628142859.GA4844@lst.de>
 <87h887qu2t.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h887qu2t.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 12:51:54PM +0300, Kalle Valo wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Hi buildbot maintainers,
> >
> > lately I usually get no, in some case a few very delayed build bot
> > results for my repos.  Is this as known issue?
> 
> I have the same problem, I did receive few reports on Wednesday but
> nothing after that. I rely a lot for buildbot doing build checks on
> wireless-drivers patches so I hope it comes back soon.
hi Kalle and Christoph, sorry for inconvenience. We will check this as
early as possible which may be due to certain issue in our side. +Rong
to help check the exact problem.

> 
> -- 
> Kalle Valo
