Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB651954C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0KEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 06:04:24 -0400
Received: from 8bytes.org ([81.169.241.247]:56198 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgC0KEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:04:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 906FE2C8; Fri, 27 Mar 2020 11:04:23 +0100 (CET)
Date:   Fri, 27 Mar 2020 11:04:22 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/3] Misc bug fixes for VT-d SVM
Message-ID: <20200327100422.GC11538@8bytes.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 09:32:28PM -0700, Jacob Pan wrote:
>   iommu/vt-d: Fix mm reference leak
>   iommu/vt-d: Add build dependency on IOASID

Applied these two, thanks.
