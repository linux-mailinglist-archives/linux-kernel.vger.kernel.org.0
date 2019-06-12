Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A841E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436765AbfFLIE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:04:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfFLIE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DDA5ABE9;
        Wed, 12 Jun 2019 08:04:28 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:04:26 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     tmurphy@arista.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
Message-ID: <20190612080426.GL8151@suse.de>
References: <20190506164440.37399-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506164440.37399-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 12:44:40PM -0400, Qian Cai wrote:
> The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
> iommu_map_page") 

That patch was reverted by me in

	97a18f548548a6ee1b9be14c6fc72090b8839875

because it caused issues by testers. So maybe re-submit the above patch
with this fix included?

Regards,

	Joerg

