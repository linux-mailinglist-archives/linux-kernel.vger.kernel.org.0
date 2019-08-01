Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CE37D601
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfHAHEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:04:43 -0400
Received: from verein.lst.de ([213.95.11.211]:40870 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHAHEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:04:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D24CC68AFE; Thu,  1 Aug 2019 09:04:38 +0200 (CEST)
Date:   Thu, 1 Aug 2019 09:04:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] mm: allow HMM_MIRROR on all architectures with
 MMU
Message-ID: <20190801070438.GC15404@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-14-hch@lst.de> <20190730180346.GR24038@mellanox.com> <20190730180452.GS24038@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730180452.GS24038@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:04:56PM +0000, Jason Gunthorpe wrote:
> Oh, can we make this into a non-user selectable option now? 
> 
> ie have the drivers that use the API select it?

Sure, I'll throw in another patch for that.
