Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B935565B63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfGKQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 12:21:04 -0400
Received: from verein.lst.de ([213.95.11.211]:59048 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfGKQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:21:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85E9568B05; Thu, 11 Jul 2019 18:21:02 +0200 (CEST)
Date:   Thu, 11 Jul 2019 18:21:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     jroedel@suse.de, hch@lst.de, torvalds@linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: fix a crash in iova_magazine_free_pfns
Message-ID: <20190711162102.GA11336@lst.de>
References: <1562861865-23660-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562861865-23660-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, the change looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
