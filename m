Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE59C7AB31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfG3Ok2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:40:28 -0400
Received: from verein.lst.de ([213.95.11.211]:51939 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbfG3Ok2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:40:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6570E68AFE; Tue, 30 Jul 2019 16:40:23 +0200 (CEST)
Date:   Tue, 30 Jul 2019 16:40:23 +0200
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
Subject: Re: [PATCH 03/13] nouveau: pass struct nouveau_svmm to
 nouveau_range_fault
Message-ID: <20190730144023.GA6683@lst.de>
References: <20190730055203.28467-1-hch@lst.de> <20190730055203.28467-4-hch@lst.de> <20190730123554.GD24038@mellanox.com> <20190730131038.GB4566@lst.de> <20190730131454.GG24038@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730131454.GG24038@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:14:58PM +0000, Jason Gunthorpe wrote:
> I have a patch deleting hmm->mm, so using svmm seems cleaner churn
> here, we could defer and I can fold this into that patch?

Sounds good.  If I don't need to resend feel fee to fold it, otherwise
I'll fix it up.
