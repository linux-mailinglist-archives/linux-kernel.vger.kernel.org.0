Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323322C7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfE1Nhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfE1Nhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:37:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 285ADACD4;
        Tue, 28 May 2019 13:37:44 +0000 (UTC)
Date:   Tue, 28 May 2019 15:37:42 +0200
From:   "jroedel@suse.de" <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Gary R Hook <ghook@amd.com>, "Hook, Gary" <Gary.Hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Message-ID: <20190528133742.GA8151@suse.de>
References: <20190506041106.29167-1-cai@lca.pw>
 <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
 <1557845746.6132.27.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557845746.6132.27.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:55:46AM -0400, Qian Cai wrote:
> Jroedel, I am wondering what the plan for 41e59a41fc5d1 (iommu tree) or this
> patch to be pushed to the linux-next or mainline...

Looks like I applied that patch directly to the master branch, which is
not what goes upstream. I cherry-picked it to x86/amd, so it will go
upstream for v5.3.


Regards,

	Joerg
