Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106F8EA317
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 19:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfJ3SN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 14:13:27 -0400
Received: from verein.lst.de ([213.95.11.211]:47143 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfJ3SN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:13:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7130E68B05; Wed, 30 Oct 2019 19:13:25 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:13:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        vladimir.murzin@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/coherent: remove unused dma_get_device_base()
Message-ID: <20191030181325.GA19564@lst.de>
References: <1568725242-2433-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568725242-2433-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it turns out the user now showed up, so I'm skipping this patch.
