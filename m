Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05DB2B144
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 11:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE0J1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 05:27:20 -0400
Received: from 8bytes.org ([81.169.241.247]:40200 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfE0J1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:27:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AF2D82AF; Mon, 27 May 2019 11:27:18 +0200 (CEST)
Date:   Mon, 27 May 2019 11:27:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
Message-ID: <20190527092718.GC21613@8bytes.org>
References: <20190227152506.4696a59f@canb.auug.org.au>
 <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
 <20190227085546-mutt-send-email-mst@kernel.org>
 <20190228100442.GB1594@8bytes.org>
 <20190512131410-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512131410-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 01:16:26PM -0400, Michael S. Tsirkin wrote:
> Joerg, what are we doing with these patches?
> It was tested in next with no bad effects.
> I sent an ack - do you want to pick it up?
> Or have me include it in my pull?

I'd prefer it in my tree, if you are fine with the spec.

Regards,

	Joerg
