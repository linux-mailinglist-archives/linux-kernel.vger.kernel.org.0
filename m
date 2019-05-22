Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72B627175
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfEVVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 17:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbfEVVOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:14:53 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93FCB2173E;
        Wed, 22 May 2019 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558559692;
        bh=YqxAZ35p2dCb4ol3pLFSqCJ1k7KxyeByBxDmBp5VkbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Biw2BRIldASqZ6cE7U4pIVIimXdJqOYDrDywf8hjysNKnDbHBBRDCxBLaYFdxaREa
         wBSWEY84IXYCS7lrImeeL7RnVcgPlquYbwbyzAGRrQU4RFM1HrzAqumYf9fCOUmrXb
         HSPkkDTQc8Qx4QtRRP7kzgPAuGr1wtp6yzxFBj3w=
Date:   Wed, 22 May 2019 14:14:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     jroedel@suse.de, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iommu/intel: fix variable 'iommu' set but not
 used
Message-Id: <20190522141452.9105fbd041ed24eedde950b9@linux-foundation.org>
In-Reply-To: <1558557386-17160-1-git-send-email-cai@lca.pw>
References: <1558557386-17160-1-git-send-email-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 16:36:26 -0400 Qian Cai <cai@lca.pw> wrote:

> The commit cf04eee8bf0e ("iommu/vt-d: Include ACPI devices in iommu=pt")
> added for_each_active_iommu() in iommu_prepare_static_identity_mapping()
> but never used the each element, i.e, "drhd->iommu".
> 
> drivers/iommu/intel-iommu.c: In function
> 'iommu_prepare_static_identity_mapping':
> drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but
> not used [-Wunused-but-set-variable]
>   struct intel_iommu *iommu;
> 
> Fixed the warning by passing "drhd->iommu" directly to
> for_each_active_iommu() which all subsequent self-assignments should be
> ignored by a compiler anyway.
> 

Yes, assigning drhd->iommu to itself seems a bit nasty.  Maybe this is
a case for __mabe_unused (with a comment explaining why), if that fixes
the warning.  Dunno.

btw, for_each_active_dev_scope() and for_each_dev_scope() should be
dragged out and shot.  Or at least, should have those single-char
identifiers changed into something meaningful so poor sods like me have
a hope of understanding the code :(

