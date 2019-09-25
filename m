Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15BBE188
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfIYPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 11:42:58 -0400
Received: from 8bytes.org ([81.169.241.247]:55902 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfIYPm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:42:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BA63F447; Wed, 25 Sep 2019 17:42:56 +0200 (CEST)
Date:   Wed, 25 Sep 2019 17:42:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kurt Garloff <kurt@garloff.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: IOMMU vs Ryzen embedded EMMC controller
Message-ID: <20190925154256.GB4643@8bytes.org>
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
 <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
 <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 05:27:32PM +0200, Jiri Kosina wrote:
> On Sat, 21 Sep 2019, Kurt Garloff wrote:
> > [12916.740274] mmc0: sdhci: ============================================
> > [12916.740337] mmc0: error -5 whilst initialising MMC card
> 
> Do you have BAR memory allocation failures in dmesg with IOMMU on? 
> Actually, sharing both working and non-working dmesg, as well as 
> /proc/iomem contents, would be helpful.

Yes, can you please grab dmesg from a boot with iommu enabled and add
'amd_iommu_dump' to the kernel command line? That should give some hints
on what is going on.

Regards,

	Joerg
