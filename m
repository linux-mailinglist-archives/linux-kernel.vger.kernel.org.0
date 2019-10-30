Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A498BE991B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfJ3JYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:24:38 -0400
Received: from 8bytes.org ([81.169.241.247]:49984 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:24:38 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0617E34A; Wed, 30 Oct 2019 10:24:36 +0100 (CET)
Date:   Wed, 30 Oct 2019 10:24:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Apply the same IVRS IOAPIC workaround to Acer
 Aspire A315-41
Message-ID: <20191030092433.GA5968@8bytes.org>
References: <20191021151721.12393-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021151721.12393-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:17:21PM +0200, Takashi Iwai wrote:
> Acer Aspire A315-41 requires the very same workaround as the existing
> quirk for Dell Latitude 5495.  Add the new entry for that.
> 
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1137799
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/iommu/amd_iommu_quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied for v5.4, thanks Takashi.

