Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC80152634
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 07:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgBEGJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 01:09:57 -0500
Received: from verein.lst.de ([213.95.11.211]:35691 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgBEGJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:09:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B547A68C7B; Wed,  5 Feb 2020 07:09:54 +0100 (CET)
Date:   Wed, 5 Feb 2020 07:09:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] memremap: Remove stale comments
Message-ID: <20200205060954.GA21395@lst.de>
References: <20200205005029.2177-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205005029.2177-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
