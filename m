Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E23D11A53F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 08:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfLKHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 02:43:34 -0500
Received: from verein.lst.de ([213.95.11.211]:53619 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLKHnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:43:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC03568BFE; Wed, 11 Dec 2019 08:43:29 +0100 (CET)
Date:   Wed, 11 Dec 2019 08:43:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Tom Murphy <murphyt7@tcd.ie>,
        Julien Grall <julien.grall@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: fix min_not_zero() type mismatch warning
Message-ID: <20191211074329.GA4458@lst.de>
References: <20191210195803.866126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210195803.866126-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we agree that the parameter should be a u64 instead, and either
Nicolas or Robin (sorry, fading memory) promised to send me a patch for
that.
