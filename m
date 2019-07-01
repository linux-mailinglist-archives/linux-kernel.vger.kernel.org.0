Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7825112CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfECLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 07:47:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59218 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfECLrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:47:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 769B6374;
        Fri,  3 May 2019 04:47:35 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 124C23F220;
        Fri,  3 May 2019 04:47:33 -0700 (PDT)
Date:   Fri, 3 May 2019 12:47:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: implement generic dma_map_ops for IOMMUs v4
Message-ID: <20190503114731.GH55449@arrakis.emea.arm.com>
References: <20190430105214.24628-1-hch@lst.de>
 <20190502132208.GA3069@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502132208.GA3069@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:22:08PM +0200, Christoph Hellwig wrote:
> can you quickly look over the arm64 parts?  I'd really like to still
> get this series in for this merge window as it would conflict with
> a lot of dma-mapping work for next merge window, and we also have
> the amd and possibly intel iommu conversions to use it waiting.

Done. They look fine to me.

-- 
Catalin
