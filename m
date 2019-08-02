Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC67EF5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404266AbfHBIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:32:34 -0400
Received: from verein.lst.de ([213.95.11.211]:50925 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbfHBIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:32:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 86EAE68C7B; Fri,  2 Aug 2019 10:32:30 +0200 (CEST)
Date:   Fri, 2 Aug 2019 10:32:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dan.j.williams@intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
Message-ID: <20190802083230.GB11000@lst.de>
References: <20190722094143.18387-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722094143.18387-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I've seen you've queued this up in -mm, but the explicit intent here was
to quickly merge this after -rc1 so that the move doesn't conflict with
further development for 5.3.  Any chance you could send this patch on
to Linus?
