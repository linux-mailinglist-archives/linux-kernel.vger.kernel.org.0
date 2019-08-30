Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B976FA3940
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfH3O3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 10:29:24 -0400
Received: from 8bytes.org ([81.169.241.247]:52544 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbfH3O3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:29:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 67FE0246; Fri, 30 Aug 2019 16:29:21 +0200 (CEST)
Date:   Fri, 30 Aug 2019 16:29:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] iommu/vt-d: remove global page flush support
Message-ID: <20190830142919.GE11578@8bytes.org>
References: <1566834809-57510-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566834809-57510-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:53:29AM -0700, Jacob Pan wrote:
>  drivers/iommu/intel-svm.c   | 36 +++++++++++++++---------------------
>  include/linux/intel-iommu.h |  3 ---
>  2 files changed, 15 insertions(+), 24 deletions(-)

Applied, thanks.
