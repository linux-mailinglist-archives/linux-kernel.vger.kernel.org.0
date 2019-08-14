Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6448DCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfHNSWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:22:33 -0400
Received: from verein.lst.de ([213.95.11.211]:40221 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfHNSWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:22:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 314CD68B02; Wed, 14 Aug 2019 20:22:29 +0200 (CEST)
Date:   Wed, 14 Aug 2019 20:22:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: unexport set_memory_x and set_memory_nx
Message-ID: <20190814182228.GA18779@lst.de>
References: <20190813090146.26377-1-hch@lst.de> <20190813090146.26377-2-hch@lst.de> <20190814165029.yfmpopn34vxpnmte@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814165029.yfmpopn34vxpnmte@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:50:29PM +0100, Will Deacon wrote:
> arm64 allmodconfig and defconfig are happy with this, so I'll pick it up
> for 5.4 if that's ok with you?

Sounds great.
