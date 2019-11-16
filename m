Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D135EFF3E3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfKPQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 11:29:42 -0500
Received: from verein.lst.de ([213.95.11.211]:49370 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfKPQ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 11:29:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE9D568BE1; Sat, 16 Nov 2019 17:29:37 +0100 (CET)
Date:   Sat, 16 Nov 2019 17:29:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/5] memremap: Check for size parameter
Message-ID: <20191116162937.GA23951@lst.de>
References: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:00:40PM +0200, Andy Shevchenko wrote:
> There is no use of memremap() to be called with size = 0.
> Simple return NULL pointer and allow callers to drop this check.

Given that this really is an error condition, maybe a WARN_ON_ONCE
would fit here?
