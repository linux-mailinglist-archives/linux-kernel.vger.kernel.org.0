Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DB75EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGZGXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 02:23:24 -0400
Received: from verein.lst.de ([213.95.11.211]:41742 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfGZGXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:23:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2300068B02; Fri, 26 Jul 2019 08:23:21 +0200 (CEST)
Date:   Fri, 26 Jul 2019 08:23:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/7] mm/hmm: a few more C style and comment clean ups
Message-ID: <20190726062320.GA22881@lst.de>
References: <20190726005650.2566-1-rcampbell@nvidia.com> <20190726005650.2566-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: it seems like you've only CCed me on patches 2-7, but not on the
cover letter and patch 1.  I'll try to find them later, but to make Ccs
useful they should normally cover the whole series.

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
